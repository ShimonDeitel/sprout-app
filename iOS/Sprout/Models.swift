import Foundation

struct Plant: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var plantName: String
    var species: String
    var wateringIntervalDays: Int
    var lastWatered: Date

    init(id: UUID = UUID(), plantName: String = "", species: String = "", wateringIntervalDays: Int = 0, lastWatered: Date = Date()) {
        self.id = id
        self.plantName = plantName
        self.species = species
        self.wateringIntervalDays = wateringIntervalDays
        self.lastWatered = lastWatered
    }
}
