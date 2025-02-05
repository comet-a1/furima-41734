document.addEventListener("DOMContentLoaded", setupPriceCalculation);
document.addEventListener("turbo:render", setupPriceCalculation);

function setupPriceCalculation() {
  const priceInput = document.getElementById("item-price");
  const taxDisplay = document.getElementById("add-tax-price");
  const profitDisplay = document.getElementById("profit");

  if (!priceInput) return;

  function updatePriceDisplay() {
    const price = priceInput.value.trim();

    if (/^\d+$/.test(price)) {
      const priceValue = Number(price);
      const tax = Math.floor(priceValue * 0.1);
      const profit = priceValue - tax;

      taxDisplay.textContent = tax.toLocaleString();
      profitDisplay.textContent = profit.toLocaleString();
    } else if (price === "") {
      taxDisplay.textContent = "0";
      profitDisplay.textContent = "0";
    } else {
      taxDisplay.textContent = "NaN";
      profitDisplay.textContent = "NaN";
    }
  }

  priceInput.addEventListener("input", updatePriceDisplay);

  updatePriceDisplay();
}