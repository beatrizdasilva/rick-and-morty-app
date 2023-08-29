import Foundation

protocol EpisodesRepositoryProtocol {
    func addEpisode(id: String)
    func removeEpisode(id: String)
    func containsEpisode(id: String) -> Bool
}

class EpisodesRepository: EpisodesRepositoryProtocol {
    private let userdefault = UserDefaults(suiteName: "episode")
    
    func addEpisode(id: String) {
        userdefault?.set(id, forKey: id)
    }
    
    func removeEpisode(id: String) {
        userdefault?.removeObject(forKey: id)
    }
    
    func containsEpisode(id: String) -> Bool {
        userdefault?.object(forKey: id) != nil
    }
}
