Contributing to VISIVA® – Brand Designer
Thank you for helping build VISIVA® – Brand Designer, our flagship app for strategic storytelling and brand identity.
We maintain strict standards to ensure every contribution reflects VISIVA®’s registered trademark and professional legacy.
---
📂 Repository Hygiene
• Do not commit auto‑generated files
	◦ DerivedData/
	◦ .swiftpm/
	◦ xcuserdata/
	◦ *.xcworkspace/contents.xcworkspacedata
• These are machine‑specific and clutter the repo. They are already excluded in .gitignore.
• Shared schemes only
	◦ Keep xcshareddata/xcschemes for team‑wide build/run consistency.
	◦ Ignore user‑specific schemes in xcuserdata.
---
🎨 Brand Integrity
• Always use the official VISIVA® gradient palette (red → orange → pink → purple → blue).
• Ensure the VISIVA® wordmark includes the ® symbol in UI and assets.
• App icons and launch screens must use the Assets.xcassets/AppIcon.appiconset with the provided Contents.json.
---
🛠 Development Standards
• Naming conventions
	◦ Use VisivaBrandDesignerApp.swift (no underscores, clean Swift style).
	◦ Entitlements file: VisivaBrandDesigner.entitlements.
	◦ Target name: Visiva-Brand-Designer.
• SwiftPM
	◦ Dependencies defined in Package.swift must be minimal and branded.
	◦ Do not commit Package.resolved unless locking versions for release.
---
✅ Commit Guidelines
• Use clear, professional commit messages:
	◦ Fix: Align Info.plist with VISIVA® trademark
	◦ Add: Gradient palette to Assets.xcassets
	◦ Clean: Remove xcuserdata clutter
• Avoid vague commits like update or misc.
---
🚀 Contribution Flow
1. Fork the repo.
2. Create a feature branch (feature/gradient-button).
3. Make changes respecting brand and technical standards.
4. Submit a pull request with a clear description.
5. Ensure CI passes before merge.
---
🔑 Outcome
This ensures VISIVA®’s repo stays clean, professional, and trademark‑aligned, while giving collaborators clear rules to follow.
