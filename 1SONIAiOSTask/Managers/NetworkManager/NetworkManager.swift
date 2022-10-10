//
//  NetworkManager.swift
//  1SONIAiOSTask
//
//  Created by Mekhriddin Jumaev on 10/10/22.
//

import UIKit

//protocol NetworkManagerProtocol {
//    func getCharacters(page: Int, completed: @escaping (Result<[Character], AuthError>) -> Void)
//}
//

class NetworkManager {
    
    static let shared = NetworkManager()
    
    init() {}
    
    func getCharacters(page: Int, completed: @escaping (Result<CharacterList, NetworkError>) -> Void) {
        let endpoint = Endpoints.getCharacters + "?page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidAuthCode))
            return
        }
    
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let characterList = try decoder.decode(CharacterList.self, from: data)
                completed(.success(characterList))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
