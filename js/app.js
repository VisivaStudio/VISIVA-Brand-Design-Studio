/* ===========================
   VISIVA® GLOBAL APP LOGIC
   =========================== */

document.addEventListener("DOMContentLoaded", () => {
  
  /* Smooth Scroll Links */
  document.querySelectorAll("a[href^='#']").forEach(link => {
    link.addEventListener("click", (e) => {
      const target = document.querySelector(link.getAttribute("href"));
      if (!target) return;
      e.preventDefault();
      target.scrollIntoView({ behavior: "smooth" });
    });
  });
  
});
