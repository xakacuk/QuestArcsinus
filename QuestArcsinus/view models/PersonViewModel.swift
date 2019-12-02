//
//  PersonViewModel.swift
//  QuestArcsinus
//
//  Created by Евгений Бейнар on 27.11.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import Foundation

final class PersonViewModel {
    
    private let httpManager = HTTPManager.shared
    
    func getPersonFromInternet(name: String, completion: @escaping (Swift.Result<[Person], Error>) -> Void) {
        httpManager.searchPerson(name: name) { result in
            switch result {
                case .success(let resposne):
                    completion(.success(resposne!.results))
                    break
                case .failure(let error):
                    completion(.failure(error))
                    break
            }
        }
    }
}
