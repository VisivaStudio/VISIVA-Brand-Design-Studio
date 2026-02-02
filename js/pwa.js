let deferredPrompt;

window.addEventListener("beforeinstallprompt", (e) => {
  e.preventDefault();
  deferredPrompt = e;

  const installBtn = document.createElement("button");
  installBtn.textContent = "Install VISIVA® App";
  installBtn.classList.add("button", "button-primary");

  document.body.appendChild(installBtn);

  installBtn.addEventListener("click", () => {
    installBtn.remove();
    deferredPrompt.prompt();
  });
});