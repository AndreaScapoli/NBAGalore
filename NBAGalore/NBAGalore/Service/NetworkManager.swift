//
//  APIServiceManager.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 18/02/21.
//

import Foundation

protocol TeamNetworking {
    
    func getTeams(completion: @escaping ((Result<Teams, Error>)) -> Void)
}

protocol PlayerNetworking {
    
    func getPlayers(page: Int, completion: @escaping ((Result<Players, Error>)) -> Void)
}

class NetworkManager: NSObject, TeamNetworking, PlayerNetworking {
    
    var session: URLSession?
    
    override init() {
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .useProtocolCachePolicy
        config.timeoutIntervalForRequest = 10.0
        config.httpAdditionalHeaders = [
            "x-rapidapi-key": "370901ee07msh74f8d13edad15b2p11c8f6jsnb41b333489f2",
            "x-rapidapi-host": "free-nba.p.rapidapi.com"
        ]
        
        self.session = URLSession(configuration: config)
    }
    
    //TODO: Error handling
    func getResponse<T: Decodable>(from url: String, decodeIn responseType: T.Type, completionHandler: @escaping (Result<T, Error>) -> () ) {
        
        guard let url = URL(string: url) else { return }
        
        let task = session?.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let urlError = error as? URLError {
                completionHandler(.failure(urlError))
            }
            
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let decodedResult = try jsonDecoder.decode(responseType, from: data)
                    completionHandler(.success(decodedResult))
                    
                } catch {
                    
                    completionHandler(.failure(error))
                }
            }
        })
        
        task?.resume()
    }
    
    //TODO: Bring these methods to a repository class
    func getTeams(completion: @escaping ((Result<Teams, Error>)) -> Void) {
        
        let url = "https://free-nba.p.rapidapi.com/teams/"
        
        self.getResponse(from: url, decodeIn: Teams.self) { response in
            
            switch response {
            case .success(let result):
                completion(Result.success(result))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func getPlayers(page: Int, completion: @escaping ((Result<Players, Error>)) -> Void) {
        
        let url = "https://free-nba.p.rapidapi.com/players/?page=\(page)&per_page=100"
        
        self.getResponse(from: url, decodeIn: Players.self) { response in
            
            switch response {
            case .success(let result):
                completion(Result.success(result))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
