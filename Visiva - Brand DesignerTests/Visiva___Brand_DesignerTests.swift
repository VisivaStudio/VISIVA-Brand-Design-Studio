import Testing

@Suite("Visiva – Brand Designer Tests")
struct Visiva_Brand_DesignerTests {

    @Test("Example test compiles and runs")
    func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        #expect(true)
    }
}
@Suite("Smoke Tests")
struct SmokeTests {
    @Test("ContentView builds")
    func contentViewBuilds() async throws {
        _ = ContentView()
    }
}

