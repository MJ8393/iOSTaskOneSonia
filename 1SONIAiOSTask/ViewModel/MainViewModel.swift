//
//  MainViewModel.swift
//  1SONIAiOSTask
//
//  Created by Mekhriddin Jumaev on 10/10/22.
//

import Foundation

class WeatherViewModel {
    
    var charactersDidChange: (() -> Void)?
    var loadingDidChange: (() -> Void)?
    
    var page = 1
    var disablePagenation: Bool = false
    var characters: [CDCharacter]? {
        didSet {
            charactersDidChange?()
        }
    }
    var isLoading: Bool? {
        didSet {
            loadingDidChange?()
        }
    }
    
    func getCharacters(page: Int) {
        isLoading = true
        NetworkManager.shared.getCharacters(page: page) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let characterList):
                let characters = characterList.results
                self.saveCharacterToDatabase(characters: characters)
                if characterList.info.next == nil {
                    self.disablePagenation = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCharactersFromDatabase() {
        DataPersistanceManager.shared.fetchCharactersFromDatabase { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let characters):
                self.characters = characters
                if characters.isEmpty {
                    self.getCharacters(page: self.page)
                } else {
                    self.page = characters.count / 20
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveCharacterToDatabase(characters: [Character]) {
        for character in characters {
            DataPersistanceManager.shared.saveCharacterToDatabase(model: character) { result in
                switch result {
                case .success():
                    self.fetchCharactersFromDatabase()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
