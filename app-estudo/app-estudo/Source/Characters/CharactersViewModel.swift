import UI
import UIKit

protocol CharactersViewModelInput {
    func loadCharacters()
    func getNextCharacters()
    func searchCharacter(name: String)
}

protocol CharactersViewModelProtocol: CharactersViewModelInput {
    var display: CharactersViewControllerDisplay? { get set }
}

class CharactersViewModel: CharactersViewModelProtocol {
    weak var display: CharactersViewControllerDisplay?
    
    private let service: CharactersServicing
    private var currentPage: Int
    private var maxPages: Int
    private var profiles: [ProfileViewModel] = []
    private var textTyped: String
    
    init(service: CharactersServicing) {
        self.service = service
        self.currentPage = 1
        self.maxPages = 1
        self.textTyped = ""
    }
    
    func loadCharacters() {
        service.getCharacter { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.currentPage = 1
                self.maxPages = value.maxPages
                
                let profilesViewModel = mapCharacters(characters: value.characters)
                self.profiles = profilesViewModel
                self.display?.reloadCharacters(character: profilesViewModel, isLoadAllInformation: value.maxPages == 1)
            case .failure:
                break
            }
        }
    }
    
    func getNextCharacters() {
        if currentPage >= maxPages {
            return
        } else {
            currentPage += 1
            service.getCharacterBySearch(by: textTyped, page: currentPage) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    let profilesViewModel = mapCharacters(characters: value.characters)
                    self.profiles.append(contentsOf: profilesViewModel)
                    self.display?.reloadCharacters(character: profiles, isLoadAllInformation: currentPage >= maxPages)
                case .failure:
                    break
                }
            }
        }
    }
    
    func searchCharacter(name: String) {
        self.textTyped = name
        service.getCharacterBySearch(by: name, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let value):
                self.currentPage = 1
                self.maxPages = value.maxPages
                
                let profilesViewModel = mapCharacters(characters: value.characters)
                self.profiles = profilesViewModel
                self.display?.reloadCharacters(character: profilesViewModel, isLoadAllInformation: value.maxPages == 1)
            case .failure:
                break
            }
        }
    }
    
    func mapCharacters(characters: [Character]) -> [ProfileViewModel] {
        return characters.map {
            ProfileViewModel(
                name: $0.name,
                characteristics: [
                    .init(primaryText: "Status", secondaryText: $0.status),
                    .init(primaryText: "Species", secondaryText: $0.species),
                    .init(primaryText: "Gender", secondaryText: $0.gender),
                    .init(primaryText: "Origin", secondaryText: $0.origin),
                    .init(primaryText: "Location", secondaryText: $0.location)
                ]
            )
        }
    }
}
