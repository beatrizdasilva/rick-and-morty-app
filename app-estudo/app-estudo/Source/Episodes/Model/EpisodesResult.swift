import Foundation

struct EpisodesResult: Decodable {
    let episodes: [Episode]
    let maxItems: Int
    let maxPages: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let infoContainer = try container.nestedContainer(keyedBy: InfoCodingKeys.self, forKey: .info)
        
        episodes = try container.decode([Episode].self, forKey: .results)
        maxItems = try infoContainer.decode(Int.self, forKey: .count)
        maxPages = try infoContainer.decode(Int.self, forKey: .pages)
    }
}

extension EpisodesResult {
    private enum CodingKeys: String, CodingKey {
        case info
        case results
    }
    
    private enum InfoCodingKeys: String, CodingKey {
        case count
        case pages
    }
}
