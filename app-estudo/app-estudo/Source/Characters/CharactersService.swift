import API

protocol CharactersServicing {
    func getCharacter(completion: @escaping(Result<CharactersResult, ApiError>) -> Void)
    func getCharacterBySearch(by name: String, page: Int, completion: @escaping(Result<CharactersResult, ApiError>) -> Void)
}

class CharactersService: CharactersServicing {
    private let api = Api()
    
    func getCharacter(completion: @escaping (Result<CharactersResult, API.ApiError>) -> Void) {
        api.cancel()
        api.execute(endpoint: CharacterEndpoints.characters(page: nil)) {
            (result: Result<CharactersResult, ApiError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getCharacterBySearch(by name: String, page: Int, completion: @escaping (Result<CharactersResult, API.ApiError>) -> Void) {
        api.cancel()
        api.execute(endpoint: CharacterEndpoints.searchCharacters(name: name, page: page)) {
            (result: Result<CharactersResult, ApiError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
