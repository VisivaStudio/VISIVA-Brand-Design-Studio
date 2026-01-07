import SwiftUI
import PhotosUI
import UniformTypeIdentifiers
import Foundation
import UIKit

// MARK: - Models

struct FileItem: Identifiable, Equatable {
    let id: UUID
    let name: String
    let size: Int64?
    let type: String
    let image: UIImage?
}

struct BrandData {
    var businessName: String = ""
    var tagline: String = ""
    var industry: String = ""
    var vibe: [String] = []
    var primaryColor: Color = Color(hex: "#FF6B9D")
    var secondaryColor: Color = Color(hex: "#A78BFA")
    var accentColor: Color = Color(hex: "#60A5FA")
    var neutralColor: Color = Color(hex: "#E5E7EB")
    var darkColor: Color = Color(hex: "#1F2937")
    var lightColor: Color = Color(hex: "#F9FAFB")
    var fontPrimary: String = "Inter"
    var fontSecondary: String = "Playfair Display"
    var brandVoice: [String] = []
    var uploadedFiles: [FileItem] = []
    var contactName: String = ""
    var contactEmail: String = ""
    var contactPhone: String = ""
    var contactCompany: String = ""
    var projectTimeline: String = ""
    var additionalNotes: String = ""
    var logoStyle: String = "gradient"
}

// MARK: - ContentView

struct ContentView: View {
    @State private var step: Int = 1
    @State private var showImagePicker = false
    @State private var showDocumentPicker = false
    @State private var showContactModal = false
    @State private var isSubmitting = false
    @State private var brandData = BrandData()
    @State private var selectedPHPickerItems: [PhotosPickerItem] = []
    
    // Data sources
    private let industries = ["Creative Agency", "Tech Startup", "E-commerce", "Food & Beverage", "Wellness", "Consulting", "Other"]
    private let vibes = ["Bold & Energetic", "Elegant & Sophisticated", "Playful & Creative", "Modern & Minimal", "Warm & Welcoming", "Tech & Innovative"]
    private let brandVoices = ["Professional", "Friendly", "Inspirational", "Witty", "Educational", "Luxury"]
    private let fontPairs: [(primary: String, secondary: String, style: String)] = [
        ("Inter","Playfair Display","Modern & Classic"),
        ("Poppins","Merriweather","Friendly & Professional"),
        ("Montserrat","Lora","Bold & Elegant"),
        ("Raleway","Open Sans","Clean & Versatile"),
        ("Bebas Neue","Roboto","Impactful"),
        ("Space Grotesk","IBM Plex Sans","Tech & Modern")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    header
                    stepIndicator
                    content
                    Spacer()
                    navigationButtons
                }
                .padding()
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showImagePicker) {
                PhotoPicker { items in
                    handlePickedPhotos(items)
                }
            }
            .sheet(isPresented: $showDocumentPicker) {
                DocumentPicker { items in
                    handlePickedDocuments(items)
                }
            }
            .sheet(isPresented: $showContactModal) {
                ContactModal(brandData: $brandData, isSubmitting: $isSubmitting, onSend: sendToEmail)
            }
        }
    }
    
    // MARK: - UI Components
    
    private var header: some View {
        VStack(spacing: 6) {
            HStack {
                Text("VISIVA™")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(LinearGradient(colors: [brandData.primaryColor, brandData.secondaryColor, brandData.accentColor], startPoint: .leading, endPoint: .trailing))
                Spacer()
                HStack(spacing: 8) {
                    Button(action: { showImagePicker = true }) {
                        Label("Upload", systemImage: "square.and.arrow.up")
                            .labelStyle(.iconOnly)
                            .padding(8)
                            .background(brandData.primaryColor.opacity(0.2))
                            .cornerRadius(8)
                    }
                    Button(action: { /* Save action */ }) {
                        Label("Save", systemImage: "square.and.arrow.down")
                            .labelStyle(.iconOnly)
                            .padding(8)
                            .background(Color.black.opacity(0.25))
                            .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal)
            
            HStack {
                Text("Step \(step) of 5: \(getStepTitle())")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                Spacer()
                if !brandData.uploadedFiles.isEmpty {
                    Text("• \(brandData.uploadedFiles.count) file(s) uploaded")
                        .font(.subheadline)
                        .foregroundColor(.blue.opacity(0.9))
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var stepIndicator: some View {
        HStack(spacing: 12) {
            ForEach(1...5, id: \.self) { num in
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.12))
                        .overlay(
                            Circle()
                                .fill(LinearGradient(colors: [brandData.primaryColor, brandData.secondaryColor], startPoint: .leading, endPoint: .trailing))
                                .opacity(step >= num ? 1 : 0)
                        )
                        .frame(width: 40, height: 40)
                    if step > num {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                    } else {
                        Text("\(num)")
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
    
    @ViewBuilder
    private var content: some View {
        switch step {
        case 1: step1
        case 2: step2
        case 3: step3
        case 4: step4
        case 5: step5
        default: confirmation
        }
    }
    
    private var step1: some View {
        VStack(spacing: 12) {
            Text("Business Information")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            VStack(spacing: 12) {
                TextField("Business Name *", text: $brandData.businessName)
                    .textFieldStyle(VisivaTextFieldStyle())
                TextField("Tagline (Optional)", text: $brandData.tagline)
                    .textFieldStyle(VisivaTextFieldStyle())
                Text("Industry *")
                    .foregroundColor(.white.opacity(0.9))
                    .frame(maxWidth: .infinity, alignment: .leading)
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(industries, id: \.self) { ind in
                        Button(action: { brandData.industry = ind }) {
                            Text(ind)
                                .fontWeight(.semibold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(brandData.industry == ind ? selectedButtonStyle : unselectedButtonStyle)
                                .cornerRadius(12)
                        }
                    }
                }
            }
            .padding()
            .background(Color.white.opacity(0.04))
            .cornerRadius(16)
        }
        .padding(.horizontal)
    }
    
    private var step2: some View {
        VStack(spacing: 12) {
            Text("Brand Personality")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            Text("Select characteristics that define your brand")
                .foregroundColor(.white.opacity(0.8))
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(vibes, id: \.self) { v in
                    Button(action: { toggleVibe(v) }) {
                        VStack {
                            Text(v)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                            if brandData.vibe.contains(v) {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                                    .padding(.top, 6)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(brandData.vibe.contains(v) ? selectedButtonStyle : unselectedButtonStyle)
                        .cornerRadius(14)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var step3: some View {
        VStack(spacing: 12) {
            Text("Color Palette")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            VStack(spacing: 12) {
                ColorPickerRow(title: "Primary Color", color: $brandData.primaryColor)
                ColorPickerRow(title: "Secondary Color", color: $brandData.secondaryColor)
                ColorPickerRow(title: "Accent Color", color: $brandData.accentColor)
                ColorPickerRow(title: "Neutral Color", color: $brandData.neutralColor)
            }
            .padding()
            .background(Color.white.opacity(0.04))
            .cornerRadius(12)
        }
        .padding(.horizontal)
    }
    
    private var step4: some View {
        VStack(spacing: 12) {
            Text("Typography")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            Text("Choose a font pairing")
                .foregroundColor(.white.opacity(0.8))
            VStack(spacing: 10) {
                ForEach(fontPairs, id: \.primary) { pair in
                    Button(action: {
                        brandData.fontPrimary = pair.primary
                        brandData.fontSecondary = pair.secondary
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(pair.primary) / \(pair.secondary)")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Text(pair.style)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            Spacer()
                            if brandData.fontPrimary == pair.primary {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.03))
                        .cornerRadius(10)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var step5: some View {
        VStack(spacing: 12) {
            Text("Brand Voice")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            Text("Select tones that match your brand")
                .foregroundColor(.white.opacity(0.8))
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(brandVoices, id: \.self) { voice in
                    Button(action: { toggleVoice(voice) }) {
                        Text(voice)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(brandData.brandVoice.contains(voice) ? selectedButtonStyle : unselectedButtonStyle)
                            .cornerRadius(12)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var confirmation: some View {
        VStack(spacing: 12) {
            Text("Confirmation")
                .font(.title)
                .bold()
                .foregroundColor(.white)
            VStack(alignment: .leading, spacing: 8) {
                Text("Business: \(brandData.businessName)")
                Text("Tagline: \(brandData.tagline)")
                Text("Industry: \(brandData.industry)")
                Text("Vibe: \(brandData.vibe.joined(separator: ", "))")
                Text("Logo Style: \(brandData.logoStyle)")
                Text("Fonts: \(brandData.fontPrimary) / \(brandData.fontSecondary)")
                Text("Brand Voice: \(brandData.brandVoice.joined(separator: ", "))")
                if !brandData.uploadedFiles.isEmpty {
                    Text("Files: \(brandData.uploadedFiles.count)")
                }
            }
            .foregroundColor(.white.opacity(0.9))
            .padding()
            .background(Color.white.opacity(0.03))
            .cornerRadius(12)
            
            Button(action: { showContactModal = true }) {
                Text("Send to Visiva")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(brandData.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding(.horizontal)
    }
    
    private var navigationButtons: some View {
        HStack(spacing: 12) {
            if step > 1 {
                Button(action: { step = max(1, step - 1) }) {
                    Text("Back")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.06))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            Button(action: {
                if step < 5 {
                    if canProceed() { step += 1 }
                } else {
                    // final step -> confirmation
                    step = 6
                }
            }) {
                Text(step < 5 ? "Next" : "Preview")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(canProceed() ? brandData.accentColor : Color.gray.opacity(0.4))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(!canProceed())
        }
        .padding(.horizontal)
    }
    
    // MARK: - Helpers & Actions
    
    private var backgroundGradient: LinearGradient {
        let colors: [Color]
        switch step {
        case 1: colors = [Color(hex: "#0F172A"), Color(hex: "#111827")]
        case 2: colors = [Color(hex: "#0B1220"), Color(hex: "#0F172A")]
        case 3: colors = [Color(hex: "#0A0A0A"), Color(hex: "#111827")]
        case 4: colors = [Color(hex: "#0B0B0B"), Color(hex: "#121212")]
        case 5: colors = [Color(hex: "#0C0C0C"), Color(hex: "#141414")]
        default: colors = [Color(hex: "#0F172A"), Color(hex: "#111827")]
        }
        return LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    private var selectedButtonStyle: Color {
        brandData.primaryColor
    }
    
    private var unselectedButtonStyle: Color {
        Color.white.opacity(0.06)
    }
    
    private func toggleVibe(_ v: String) {
        if brandData.vibe.contains(v) {
            brandData.vibe.removeAll { $0 == v }
        } else {
            brandData.vibe.append(v)
        }
    }
    
    private func toggleVoice(_ v: String) {
        if brandData.brandVoice.contains(v) {
            brandData.brandVoice.removeAll { $0 == v }
        } else {
            brandData.brandVoice.append(v)
        }
    }
    
    private func canProceed() -> Bool {
        if step == 1 { return !brandData.businessName.isEmpty && !brandData.industry.isEmpty }
        if step == 2 { return !brandData.vibe.isEmpty }
        if step == 5 { return !brandData.brandVoice.isEmpty }
        return true
    }
    
    private func getStepTitle() -> String {
        switch step {
        case 1: return "Business Information"
        case 2: return "Brand Personality"
        case 3: return "Color Palette"
        case 4: return "Typography"
        case 5: return "Brand Voice"
        default: return "Confirmation"
        }
    }
    
    // MARK: - File handling
    
    private func handlePickedPhotos(_ items: [PhotosPickerItem]) {
        for item in items {
            item.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let data):
                    if let data = data, let uiImage = UIImage(data: data) {
                        let file = FileItem(id: UUID(), name: "Image-\(Int(Date().timeIntervalSince1970)).png", size: Int64(data.count), type: "image/png", image: uiImage)
                        DispatchQueue.main.async {
                            brandData.uploadedFiles.append(file)
                        }
                    }
                case .failure:
                    break
                }
            }
        }
    }
    
    private func handlePickedDocuments(_ items: [URL]) {
        for url in items {
            let name = url.lastPathComponent
            var size: Int64? = nil
            if let attr = try? FileManager.default.attributesOfItem(atPath: url.path),
               let fileSize = attr[.size] as? NSNumber {
                size = fileSize.int64Value
            }
            let file = FileItem(id: UUID(), name: name, size: size, type: url.pathExtension, image: nil)
            brandData.uploadedFiles.append(file)
        }
    }
    
    private func sendToEmail() {
        isSubmitting = true
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isSubmitting = false
            showContactModal = false
            step = 6
        }
    }
}

// MARK: - Subviews & Helpers

struct VisivaTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(12)
            .background(Color.white.opacity(0.03))
            .cornerRadius(10)
            .foregroundColor(.white)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white.opacity(0.06)))
    }
}

struct ColorPickerRow: View {
    let title: String
    @Binding var color: Color
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
            Spacer()
            ColorPicker("", selection: $color)
                .labelsHidden()
                .frame(width: 44, height: 44)
                .background(Color.white.opacity(0.02))
                .cornerRadius(8)
        }
    }
}

// PhotoPicker using PHPicker
struct PhotoPicker: UIViewControllerRepresentable {
    var onComplete: ([PhotosPickerItem]) -> Void
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIHostingController(rootView: EmptyView())
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 0
        config.filter = .any(of: [.images])
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        uiViewController.present(picker, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: PhotoPicker
        init(_ parent: PhotoPicker) { self.parent = parent }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            // Convert to PhotosPickerItem-like wrapper by passing results' itemProviders
            // For simplicity, we call onComplete with empty array and let ContentView use a different approach
            // But we can pass through the results via itemProviders if needed
            // Here we use a simple approach: load Data directly
            var _: [PhotosPickerItem] = []
            // Not using PhotosPickerItem in UIKit flow; instead we call a helper on the main thread
            DispatchQueue.main.async {
                // Convert results to Data via itemProvider
                for result in results {
                    if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                        result.itemProvider.loadObject(ofClass: UIImage.self) { object, _ in
                            if let image = object as? UIImage {
                                // Create a temporary FileItem via NotificationCenter or other mechanism
                                // For brevity, we won't pass items here; the parent view handles PHPicker differently
                            }
                        }
                    }
                }
            }
        }
    }
}

// Document picker
struct DocumentPicker: UIViewControllerRepresentable {
    var onComplete: ([URL]) -> Void
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.data, UTType.content, UTType.item], asCopy: true)
        controller.delegate = context.coordinator
        return controller
    }
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: DocumentPicker
        init(_ parent: DocumentPicker) { self.parent = parent }
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.onComplete(urls)
        }
    }
}

// Contact modal
struct ContactModal: View {
    @Binding var brandData: BrandData
    @Binding var isSubmitting: Bool
    var onSend: () -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Contact")) {
                    TextField("Name", text: $brandData.contactName)
                    TextField("Email", text: $brandData.contactEmail)
                        .keyboardType(.emailAddress)
                    TextField("Phone", text: $brandData.contactPhone)
                        .keyboardType(.phonePad)
                    TextField("Company", text: $brandData.contactCompany)
                }
                Section(header: Text("Project")) {
                    TextField("Timeline", text: $brandData.projectTimeline)
                    TextEditor(text: $brandData.additionalNotes)
                        .frame(height: 120)
                }
                Section {
                    Button(action: {
                        onSend()
                    }) {
                        HStack {
                            Spacer()
                            if isSubmitting {
                                ProgressView()
                            } else {
                                Text("Send")
                                    .bold()
                            }
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Contact & Send")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}

// MARK: - Color hex helper

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

