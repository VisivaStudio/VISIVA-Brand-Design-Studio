/* ================================
   VISIVA® Client Portal (Batch 4)
   - Auth guard
   - Active nav
   - Mock data rendering
   - Logout
   ================================ */

(function () {
  // ---- Auth Guard ----
  const isAuthed = localStorage.getItem("visiva_auth") === "true";
  const onAuthPages = location.pathname.includes("/client/auth/");
  if (!isAuthed && !onAuthPages) {
    // redirect to login
    location.href = "./auth/login.html";
    return;
  }

  // ---- Active Nav Highlight ----
  const path = location.pathname.split("/").pop();
  document.querySelectorAll(".portal-link").forEach(a => {
    if (a.getAttribute("href") === path) a.classList.add("active");
  });

  // ---- Logout ----
  const logoutBtn = document.getElementById("logoutBtn");
  if (logoutBtn) {
    logoutBtn.addEventListener("click", () => {
      localStorage.removeItem("visiva_auth");
      location.href = "./auth/login.html";
    });
  }

  // ---- Mock Data (replace later with API calls) ----
  const data = {
    client: { name: "VISIVA Client", company: "Client Company", tier: "Premium" },
    projects: [
      { id: "P-1024", name: "Brand Kit Implementation", status: "In Progress", updated: "This week" },
      { id: "P-1025", name: "Website Identity Rollout", status: "Review", updated: "Recently" },
      { id: "P-1026", name: "Social Campaign Templates", status: "Delivered", updated: "Earlier" }
    ],
    downloads: [
      { name: "Primary Logo Pack (SVG+PNG).zip", size: "24MB", href: "../assets/downloads/logo-pack.zip" },
      { name: "Brand Guidelines (Interactive PDF).pdf", size: "8MB", href: "../assets/downloads/brand-guidelines.pdf" },
      { name: "Templates Pack (Canva+Figma).zip", size: "52MB", href: "../assets/downloads/templates-pack.zip" }
    ],
    assets: [
      { name: "Logo Variations", note: "Primary, secondary, icon marks", tag: "Approved" },
      { name: "Colour Palette", note: "Core + extended palette", tag: "Approved" },
      { name: "Typography System", note: "Display + UI + Mono usage", tag: "Approved" },
      { name: "Social Templates", note: "Story + post + banner set", tag: "In Review" }
    ],
    notifications: [
      { title: "New file uploaded", detail: "Templates Pack is available in Downloads." },
      { title: "Approval needed", detail: "Please review ‘Website Identity Rollout’." },
      { title: "Milestone reached", detail: "Brand Kit Implementation — Phase 1 complete." }
    ]
  };

  // ---- Render helpers ----
  const mountList = (id, items, renderItem) => {
    const el = document.getElementById(id);
    if (!el) return;
    el.innerHTML = items.map(renderItem).join("");
  };

  // Dashboard widgets
  mountList("projectList", data.projects, (p) => `
    <div class="portal-item">
      <div>
        <strong>${p.name}</strong><br/>
        <small>${p.id} • ${p.updated}</small>
      </div>
      <span class="portal-pill">${p.status}</span>
    </div>
  `);

  mountList("assetList", data.assets, (a) => `
    <div class="portal-item">
      <div>
        <strong>${a.name}</strong><br/>
        <small>${a.note}</small>
      </div>
      <span class="portal-pill">${a.tag}</span>
    </div>
  `);

  mountList("downloadList", data.downloads, (d) => `
    <div class="portal-item">
      <div>
        <strong>${d.name}</strong><br/>
        <small>${d.size}</small>
      </div>
      <a class="portal-btn" href="${d.href}" download>Download</a>
    </div>
  `);

  mountList("notificationList", data.notifications, (n) => `
    <div class="portal-item">
      <div>
        <strong>${n.title}</strong><br/>
        <small>${n.detail}</small>
      </div>
      <span class="portal-pill">Update</span>
    </div>
  `);

  // Projects page list
  mountList("projectsPageList", data.projects, (p) => `
    <div class="portal-item">
      <div>
        <strong>${p.name}</strong><br/>
        <small>${p.id} • ${p.updated}</small>
      </div>
      <div style="display:flex; gap:10px; align-items:center;">
        <span class="portal-pill">${p.status}</span>
        <a class="portal-btn" href="project.html?id=${encodeURIComponent(p.id)}">Open</a>
      </div>
    </div>
  `);

  // Downloads page list
  mountList("downloadsPageList", data.downloads, (d) => `
    <div class="portal-item">
      <div>
        <strong>${d.name}</strong><br/>
        <small>${d.size}</small>
      </div>
      <a class="portal-btn primary" href="${d.href}" download>Download</a>
    </div>
  `);

  // Single project page
  const projectId = new URLSearchParams(location.search).get("id");
  if (projectId) {
    const p = data.projects.find(x => x.id === projectId);
    const titleEl = document.getElementById("projectTitle");
    const metaEl = document.getElementById("projectMeta");
    if (p && titleEl && metaEl) {
      titleEl.textContent = p.name;
      metaEl.textContent = `${p.id} • Status: ${p.status} • Updated: ${p.updated}`;
    }
  }

})();