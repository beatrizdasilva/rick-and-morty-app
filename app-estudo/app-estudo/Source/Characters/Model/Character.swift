struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: String
    let location: String
    let image: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let originContainer = try container.nestedContainer(keyedBy: InfoCodingKeys.self, forKey: .origin)
        let locationContainer = try container.nestedContainer(keyedBy: InfoCodingKeys.self, forKey: .location)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(String.self, forKey: .status)
        species = try container.decode(String.self, forKey: .species)
        gender = try container.decode(String.self, forKey: .gender)
        origin = try originContainer.decode(String.self, forKey: .name)
        location = try locationContainer.decode(String.self, forKey: .name)
        image = try container.decode(String.self, forKey: .image)
    }
}

extension Character {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case gender
        case origin
        case location
        case image
    }
    
    private enum InfoCodingKeys: String, CodingKey {
        case name
    }
}
