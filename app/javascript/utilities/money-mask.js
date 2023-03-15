function moneyMask(value) {
  if (value.startsWith("0")) {
    value = "";
  }

  value = value.replace(/\./g, "");
  value = value.replace(/[^\d,]/g, "");

  if (value.startsWith(",")) {
    value = "0" + value;
  }

  value = value.replace(/(\d{2})$/, ".$1");
  value = value.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.");

  if (!value.includes(".")) {
    value += ".";
  }
  return value;
}

let value = "";

let transaction_value = document.getElementById(
  "account_transaction_transaction_value"
);

if (transaction_value) {
  document
    .getElementById("account_transaction_transaction_value")
    .addEventListener("input", (event) => {
      const newValue = moneyMask(event.target.value);
      if (newValue !== value) {
        event.target.value = newValue;
        value = newValue;
      }
    });
}
