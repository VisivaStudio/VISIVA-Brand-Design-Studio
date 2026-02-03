// client/collab.js
// Collaboration Rooms (demo): stored in localStorage, ready to replace with real backend.
// Spec: chat threads + file sharing + tasks + milestone tracking + notifications. [1](https://onedrive.live.com/personal/72b59963c95882a1/_layouts/15/doc.aspx?resid=7eef7866-44e5-439e-be23-cee1aed6f46e&cid=72b59963c95882a1)

const storeKey = "visiva_collab_state_v1";

const defaultState = {
  rooms: [
    { id: "room-1", name: "Brand Kit Implementation" },
    { id: "room-2", name: "Website Identity Rollout" }
  ],
  activeRoomId: "room-1",
  messages: {
    "room-1": [
      { by: "VISIVA", text: "Welcome — share notes, approvals, and feedback here.", ts: Date.now() - 600000 }
    ],
    "room-2": [
      { by: "VISIVA", text: "Upload website drafts and request approvals.", ts: Date.now() - 300000 }
    ]
  },
  tasks: {
    "room-1": [
      { id: "t1", text: "Approve logo spacing rules", done: false },
      { id: "t2", text: "Confirm palette version", done: true }
    ],
    "room-2": [
      { id: "t3", text: "Review homepage hero layout", done: false }
    ]
  },
  files: {
    "room-1": [{ name: "Brand Guidelines (PDF)", note: "Latest export", link: "downloads.html" }],
    "room-2": [{ name: "Homepage Draft (UI)", note: "Preview file", link: "projects.html" }]
  }
};

function loadState() {
  try {
    return JSON.parse(localStorage.getItem(storeKey)) || defaultState;
  } catch {
    return defaultState;
  }
}

function saveState(state) {
  localStorage.setItem(storeKey, JSON.stringify(state));
}

let state = loadState();

const roomsList = document.getElementById("roomsList");
const roomTitle = document.getElementById("roomTitle");
const chatFeed = document.getElementById("chatFeed");
const chatInput = document.getElementById("chatInput");
const taskList = document.getElementById("taskList");
const taskInput = document.getElementById("taskInput");
const fileList = document.getElementById("fileList");

function fmtTime(ts) {
  const d = new Date(ts);
  return d.toLocaleString();
}

function activeRoom() {
  return state.rooms.find(r => r.id === state.activeRoomId);
}

function renderRooms() {
  roomsList.innerHTML = "";
  state.rooms.forEach(r => {
    const a = document.createElement("a");
    a.href = "#";
    a.className = "portal-link" + (r.id === state.activeRoomId ? " active" : "");
    a.textContent = r.name;
    a.onclick = (e) => {
      e.preventDefault();
      state.activeRoomId = r.id;
      saveState(state);
      renderAll();
    };
    roomsList.appendChild(a);
  });
}

function renderChat() {
  const r = activeRoom();
  roomTitle.textContent = r ? r.name : "Select a Room";
  const msgs = state.messages[state.activeRoomId] || [];
  chatFeed.innerHTML = msgs.map(m => `
    <div class="portal-item">
      <div>
        <strong>${m.by}</strong><br/>
        <small>${fmtTime(m.ts)}</small><br/>
        <span>${m.text}</span>
      </div>
      <span class="portal-pill">Message</span>
    </div>
  `).join("");
}

function renderTasks() {
  const tasks = state.tasks[state.activeRoomId] || [];
  taskList.innerHTML = tasks.map(t => `
    <div class="portal-item">
      <div>
        <strong>${t.done ? "✅ " : ""}${t.text}</strong>
        <br/><small>${t.done ? "Completed" : "Pending"}</small>
      </div>
      <button class="portal-btn" data-task="${t.id}">${t.done ? "Undo" : "Done"}</button>
    </div>
  `).join("");

  taskList.querySelectorAll("button[data-task]").forEach(btn => {
    btn.onclick = () => {
      const id = btn.getAttribute("data-task");
      const list = state.tasks[state.activeRoomId] || [];
      const item = list.find(x => x.id === id);
      if (item) item.done = !item.done;
      state.tasks[state.activeRoomId] = list;
      saveState(state);
      renderTasks();
    };
  });
}

function renderFiles() {
  const files = state.files[state.activeRoomId] || [];
  fileList.innerHTML = files.map(f => `
    <div class="portal-item">
      <div>
        <strong>${f.name}</strong><br/>
        <small>${f.note || ""}</small>
      </div>
      <a class="portal-btn" href="${f.link || "#"}">Open</a>
    </div>
  `).join("");
}

function renderAll() {
  renderRooms();
  renderChat();
  renderTasks();
  renderFiles();
}

document.getElementById("sendMsgBtn")?.addEventListener("click", () => {
  const text = (chatInput.value || "").trim();
  if (!text) return;

  const msgs = state.messages[state.activeRoomId] || [];
  msgs.push({ by: "Client", text, ts: Date.now() });
  state.messages[state.activeRoomId] = msgs;

  chatInput.value = "";
  saveState(state);
  renderChat();
});

document.getElementById("addTaskBtn")?.addEventListener("click", () => {
  const text = (taskInput.value || "").trim();
  if (!text) return;

  const list = state.tasks[state.activeRoomId] || [];
  list.push({ id: "t" + Date.now(), text, done: false });
  state.tasks[state.activeRoomId] = list;

  taskInput.value = "";
  saveState(state);
  renderTasks();
});

document.getElementById("addFileBtn")?.addEventListener("click", () => {
  const list = state.files[state.activeRoomId] || [];
  list.push({ name: "New File (UI)", note: "Connect to storage later", link: "downloads.html" });
  state.files[state.activeRoomId] = list;
  saveState(state);
  renderFiles();
});

document.getElementById("createRoomBtn")?.addEventListener("click", () => {
  const name = prompt("Room name?");
  if (!name) return;
  const id = "room-" + Date.now();
  state.rooms.push({ id, name });
  state.activeRoomId = id;
  state.messages[id] = [];
  state.tasks[id] = [];
  state.files[id] = [];
  saveState(state);
  renderAll();
});

renderAll();