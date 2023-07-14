import Foundation

struct LocationsResult: Decodable {
    let locations: [Location]
    let maxItems: Int
    let maxPages: Int

    init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        var infoContainer = try container.nestedContainer(keyedBy: InfoCodingKeys.self, forKey: .info)
        
        locations = try container.decode([Location].self, forKey: .results)
        maxItems = try infoContainer.decode(Int.self, forKey: .count)
        maxPages = try infoContainer.decode(Int.self, forKey: .pages)
    }
}

extension LocationsResult {
    private enum CodingKeys: String, CodingKey {
        case info
        case results
    }
    
    private enum InfoCodingKeys: String, CodingKey {
        case count
        case pages
    }
}
