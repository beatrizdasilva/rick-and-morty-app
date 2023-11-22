import Foundation

struct CharactersResult: Decodable {
    let characters: [Character]
    let maxItems: Int
    let maxPages: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let infoContainer = try container.nestedContainer(keyedBy: InfoCodingKeys.self, forKey: .info)
        
        characters = try container.decode([Character].self, forKey: .results)
        maxItems = try infoContainer.decode(Int.self, forKey: .count)
        maxPages = try infoContainer.decode(Int.self, forKey: .pages)
    }
}

extension CharactersResult {
    private enum CodingKeys: String, CodingKey {
        case info
        case results
    }
    
    private enum InfoCodingKeys: String, CodingKey {
        case count
        case pages
    }
}
