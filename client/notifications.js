// client/notifications.js
// In-app notification feed (local demo), aligned to spec push/approval/milestones. [1](https://onedrive.live.com/personal/72b59963c95882a1/_layouts/15/doc.aspx?resid=7eef7866-44e5-439e-be23-cee1aed6f46e&cid=72b59963c95882a1)

const key = "visiva_notifications_v1";
const list = document.getElementById("notifList");

function load() {
  try { return JSON.parse(localStorage.getItem(key)) || []; }
  catch { return []; }
}
function save(arr) { localStorage.setItem(key, JSON.stringify(arr)); }

function render() {
  const items = load();
  list.innerHTML = items.length ? items.map(n => `
    <div class="portal-item">
      <div>
        <strong>${n.title}</strong><br/>
        <small>${n.when}</small><br/>
        <span>${n.detail}</span>
      </div>
      <span class="portal-pill">${n.type}</span>
    </div>
  `).join("") : `<div class="portal-help">No notifications yet.</div>`;
}

document.getElementById("seedBtn").addEventListener("click", () => {
  const items = load();
  items.unshift(
    { title:"Approval needed", detail:"Please review the latest homepage hero.", type:"Approval", when:new Date().toLocaleString() },
    { title:"New upload", detail:"Templates pack is available in Downloads.", type:"Upload", when:new Date().toLocaleString() },
    { title:"Milestone reached", detail:"Brand Kit Implementation — Phase 1 complete.", type:"Milestone", when:new Date().toLocaleString() }
  );
  save(items);
  render();
});

render();