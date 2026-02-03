/* ================================
   VISIVA® Tools JS (Batch F)
   - Auth guard for /portal/*
   - Basic tool helpers (generate previews)
   - API placeholders (fetch /api/*)
   ================================ */

(function () {
  // ---- Auth Guard ----
  const isAuthed = localStorage.getItem("visiva_auth") === "true";
  if (!isAuthed) {
    // always redirect to the client login
    window.location.href = "../client/auth/login.html";
    return;
  }

  // ---- Active Sidebar Link ----
  const file = location.pathname.split("/").pop();
  document.querySelectorAll(".portal-link").forEach(a => {
    if (a.getAttribute("href") === file) a.classList.add("active");
  });

  // ---- Logout ----
  const logoutBtn = document.getElementById("logoutBtn");
  if (logoutBtn) {
    logoutBtn.addEventListener("click", () => {
      localStorage.removeItem("visiva_auth");
      window.location.href = "../client/auth/login.html";
    });
  }

  // ---- Helpers ----
  window.VISIVA = {
    toast(msg) {
      // simple inline toast, no dependencies
      const t = document.createElement("div");
      t.textContent = msg;
      t.style.position = "fixed";
      t.style.bottom = "18px";
      t.style.right = "18px";
      t.style.padding = "12px 14px";
      t.style.borderRadius = "12px";
      t.style.background = "rgba(0,0,0,0.75)";
      t.style.border = "1px solid rgba(199,167,106,0.35)";
      t.style.color = "#fff";
      t.style.zIndex = 9999;
      document.body.appendChild(t);
      setTimeout(() => t.remove(), 2200);
    },

    // Generic preview generator (local demo output)
    synthesize(title, fields) {
      const lines = [];
      lines.push(`— ${title} —\n`);
      Object.entries(fields).forEach(([k, v]) => {
        lines.push(`${k}: ${String(v || "").trim()}`);
      });
      lines.push("\n(Connect this tool to /api/* for real outputs.)");
      return lines.join("\n");
    },

    async callAPI(path, payload) {
      // Placeholder for backend wiring later.
      // Return local demo response if endpoint not available.
      try {
        const res = await fetch(path, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload)
        });
        if (!res.ok) throw new Error("API not available");
        return await res.json();
      } catch (e) {
        return { ok: true, demo: true, data: payload };
      }
    }
  };
})();