// VISIVA® Client Auth (Front‑End Placeholder)

document.addEventListener("DOMContentLoaded", () => {

  const loginForm = document.getElementById("loginForm");
  const registerForm = document.getElementById("registerForm");

  if (loginForm) {
    loginForm.addEventListener("submit", (e) => {
      e.preventDefault();

      // Placeholder authentication logic
      localStorage.setItem("visiva_auth", "true");

      // Redirect to client dashboard (next batch)
      window.location.href = "../dashboard.html";
    });
  }

  if (registerForm) {
    registerForm.addEventListener("submit", (e) => {
      e.preventDefault();

      alert("Access request submitted. VISIVA® will contact you shortly.");
      window.location.href = "login.html";
    });
  }

});