import Foundation

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}
