# class Users::SessionsController < Devise::SessionsController
#   before_action :authenticate_user!

#   # ログイン後にリダイレクトするパスを指定
#   def after_sign_in_path_for(_resource)
#     root_path
#   end

#   # ログアウト後にリダイレクトするパスを指定
#   def after_sign_out_path_for(_resource_or_scope)
#     root_path
#   end

#   private

#   def configure_sign_in_params
#     devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
#   end
# end
