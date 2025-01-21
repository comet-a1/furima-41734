# syntax = docker/dockerfile:1

# ベースイメージの指定
ARG RUBY_VERSION=3.2.0
FROM ruby:$RUBY_VERSION-slim AS base

# 作業ディレクトリの設定
WORKDIR /rails

# 必要なパッケージのインストール
RUN set -eux; \
    apt-get update -qq; \
    until apt-get install --no-install-recommends -y \
        curl \
        libpq-dev \
        libjemalloc2 \
        libvips \
        git; do \
      echo "apt-get install failed, retrying in 5 seconds..."; \
      sleep 5; \
      apt-get update -qq; \
    done; \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# 環境変数の設定
ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_WITHOUT=development

# ビルドステージの開始
FROM base AS build

# ビルドに必要なパッケージのインストール
RUN set -eux; \
    apt-get update -qq; \
    until apt-get install --no-install-recommends -y \
        build-essential \
        libpq-dev \
        git \
        node-gyp \
        pkg-config \
        python-is-python3; do \
      echo "apt-get install failed, retrying in 5 seconds..."; \
      sleep 5; \
      apt-get update -qq; \
    done; \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Node.js と Yarn のインストール
ARG NODE_VERSION=20.17.0
ARG YARN_VERSION=1.22.22
ENV PATH=/usr/local/node/bin:$PATH
RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "$NODE_VERSION" /usr/local/node && \
    npm install -g yarn@$YARN_VERSION && \
    rm -rf /tmp/node-build-master

# アプリケーションの Gem をインストール
COPY Gemfile Gemfile.lock /rails/
RUN bundle install && \
    rm -rf ~/.bundle/ "$BUNDLE_PATH"/ruby/*/cache "$BUNDLE_PATH"/ruby/*/bundler/gems/*/.git

# Node.js の依存関係をインストール
COPY package.json yarn.lock /rails/
RUN yarn install --frozen-lockfile

# アプリケーションコードをコピー
COPY . /rails

# Bootsnap のプリコンパイルと権限設定
RUN bundle exec bootsnap precompile app/ lib/
RUN chmod +x ./bin/rails

# アセットのプリコンパイル
ARG DATABASE_URL
ARG SECRET_KEY_BASE
ENV DATABASE_URL=$DATABASE_URL
ENV SECRET_KEY_BASE=$SECRET_KEY_BASE
RUN DATABASE_URL=$DATABASE_URL RAILS_ENV=production SECRET_KEY_BASE=$SECRET_KEY_BASE bundle exec rails assets:precompile

# 不要な Node.js モジュールを削除（任意）
RUN rm -rf node_modules

# 最終ステージの開始
FROM base

# ビルド済みのアーティファクトをコピー
COPY --from=build "$BUNDLE_PATH" "$BUNDLE_PATH"
COPY --from=build /rails /rails

# ファイルの所有権とパーミッションを設定
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails /rails

USER rails

# 作業ディレクトリの設定
WORKDIR /rails

# 環境変数の設定
ENV RAILS_ENV=production

# ポートの公開
EXPOSE 3000

# CMD の設定
CMD ["bash", "-c", "bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0 -p 3000"]
