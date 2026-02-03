// /js/services.js

export async function sendEmail(payload) {
  // Connect later to: SendGrid / Mailgun / Firebase / Supabase
  console.log("Email payload:", payload);
  return { success: true };
}

export async function logActivity(event) {
  console.log("Activity log:", event);
}

export async function fetchAI(endpoint, payload) {
  console.log("AI Request:", endpoint, payload);
  return { result: "placeholder response" };
}