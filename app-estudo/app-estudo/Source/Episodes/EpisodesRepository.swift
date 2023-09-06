import Foundation

protocol EpisodesRepositoryProtocol {
    func addEpisode(id: String)
    func removeEpisode(id: String)
    func containsEpisode(id: String) -> Bool
    func countEpisodes() -> Int
}

class EpisodesRepository: EpisodesRepositoryProtocol {
    private let userdefault = UserDefaults(suiteName: "episode")
    private let category = "episode-"
    
    func addEpisode(id: String) {
        userdefault?.set(id, forKey: createId(id: id))
    }
    
    func removeEpisode(id: String) {
        userdefault?.removeObject(forKey: createId(id: id))
    }
    
    func containsEpisode(id: String) -> Bool {
        userdefault?.object(forKey: createId(id: id)) != nil
    }
    
    func countEpisodes() -> Int {
        userdefault?.dictionaryRepresentation().keys.reduce(0, { partialResult, key in
            if key.contains(category) {
                return partialResult + 1
            } else {
                return partialResult
            }
        }) ?? 0
    }
    
    private func createId(id: String) -> String {
        "\(category)\(id)"
    }
}
