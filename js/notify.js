// /js/notify.js
export function notify(message, type = "info") {
  alert(`${type.toUpperCase()}: ${message}`);
}