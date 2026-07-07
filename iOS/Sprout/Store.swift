import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [Plant] = []
    @Published var isPro: Bool = false

    /// Free tier allows this many entries. Seed data below is always fewer than this
    /// so a fresh install never opens straight into the paywall.
    static let freeLimit = 20

    private let fileName = "sprout_items.json"

    private var fileURL: URL {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        if !FileManager.default.fileExists(atPath: dir.path) {
            try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        }
        return dir.appendingPathComponent(fileName)
    }

    init() {
        load()
    }

    func load() {
        guard let data = try? Data(contentsOf: fileURL),
              let decoded = try? JSONDecoder().decode([Plant].self, from: data) else {
            items = Self.seedData()
            save()
            return
        }
        items = decoded
    }

    func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    var canAddMore: Bool {
        isPro || items.count < Self.freeLimit
    }

    @discardableResult
    func add(_ item: Plant) -> Bool {
        guard canAddMore else { return false }
        items.append(item)
        save()
        return true
    }

    func update(_ item: Plant) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: Plant) {
        items.removeAll { $0.id == item.id }
        save()
    }

    static func seedData() -> [Plant] {
        [
        Plant(plantName: "Monstera", species: "Monstera deliciosa", wateringIntervalDays: 1, lastWatered: Date().addingTimeInterval(-259200)),
        Plant(plantName: "Pothos", species: "Epipremnum aureum", wateringIntervalDays: 2, lastWatered: Date().addingTimeInterval(-518400)),
        Plant(plantName: "Snake Plant", species: "Dracaena trifasciata", wateringIntervalDays: 3, lastWatered: Date().addingTimeInterval(-777600)),
        Plant(plantName: "Fiddle Leaf Fig", species: "Monstera deliciosa", wateringIntervalDays: 4, lastWatered: Date().addingTimeInterval(-1036800))
        ]
    }
}
