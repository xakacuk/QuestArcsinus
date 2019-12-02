//
//  HTTPManager.swift
//  QuestArcsinus
//
//  Created by Евгений Бейнар on 27.11.2019.
//  Copyright © 2019 Евгений Бейнар. All rights reserved.
//

import Foundation
import Alamofire

public final class HTTPManager {
    
    private enum Path: String {
        case search = "?search="
        case people = "people/"
    }

    private enum Const {
        static let url = "https://swapi.co/api/"
    }

    private enum Config {
        static let timeout: Double = 15.0
    }
    
    static let shared = HTTPManager()
    
    public typealias Parameters = [String: Any]
    public typealias Headers = [String: String]
    
    private let decoder = JSONDecoder()
    
    private lazy var networkSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = Config.timeout
        configuration.timeoutIntervalForRequest = Config.timeout
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()
    
    func searchPerson(name: String,
                         completionHandler: @escaping (Swift.Result<ResponseSearchPeople?, Error>) -> Void) {
            
            self.networkSessionManager.request("\(Const.url)\(Path.people.rawValue)\(Path.search.rawValue)\(name)",
                method: .get,
                parameters: nil,
                headers: nil).validate().responseJSON { [weak self] response in
                    
                guard let sSelf = self else { return }
                    
                guard let data = response.data else {
                    assertionFailure()
                    return
                }
                
                if let rawString = String(bytes: data, encoding: .utf8) {
                    print(rawString)
                }
                
                switch response.result {
                    case .success(_):
                        guard let data = response.data else {
                            assertionFailure()
                            return
                        }
                        
                        do {
                            let person = try sSelf.decoder.decode(ResponseSearchPeople.self, from: data)
                            completionHandler(.success(person))
                        } catch {
                            completionHandler(.failure(error))
                        }
                        
                        break
                    
                    case .failure(let error):

                        if let httpStatusCode = response.response?.statusCode {
                            completionHandler(.failure(error))
                            break
    //                       switch httpStatusCode {
                            // return custom code api error
    //                       }
                        } else {
                            break
                        }
                }
            }
        }
    
}
