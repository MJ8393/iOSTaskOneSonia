//
//  PersistanceManager.swift
//  1SONIAiOSTask
//
//  Created by Mekhriddin Jumaev on 10/10/22.
//

import UIKit
import CoreData


class DataPersistanceManager {
    
    static let shared = DataPersistanceManager()
    
    func saveCharacterToDatabase(model: Character, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.async {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            let context = appDelegate.persistentContainer.viewContext
            
            let item = CDCharacter(context: context)
            
            item.name = model.name
            item.status = model.status
            item.location = model.location.name
            item.imagePath = model.image
            
            do {
                try context.save()
                completion(.success(()))
            } catch {
                print(DatabaseError.failedToSaveData)
            }
        }
    }
    
    
    func fetchCharactersFromDatabase(complesion: @escaping (Result<[CDCharacter], Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<CDCharacter>
        
        request = CDCharacter.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            complesion(.success(titles))
        } catch {
            complesion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    
    func deleteAllCharactersFromDatabase(characters: [CDCharacter], complition: @escaping (Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        for character in characters {
            context.delete(character)
        }
        
        do {
            try context.save()
            complition(.success(()))
        } catch {
            complition(.failure(DatabaseError.failedToDeleteData))
        }
    }
    
}
