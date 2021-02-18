//
//  APIServiceManager.swift
//  NBAGalore
//
//  Created by Andrea Scapoli on 18/02/21.
//

import Foundation

public typealias ResultHandler<T> = (Result<T, Error>) -> ()

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    var session: URLSession?
    
    //    typealias SerializationFunction<T> = (Data?, URLResponse?, Error?) -> Result<T>
    
    override private init() {
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .useProtocolCachePolicy
        config.timeoutIntervalForRequest = 10.0
        config.httpAdditionalHeaders = [
            "x-rapidapi-key": "370901ee07msh74f8d13edad15b2p11c8f6jsnb41b333489f2",
            "x-rapidapi-host": "free-nba.p.rapidapi.com"
        ]
        
        self.session = URLSession(configuration: config)
    }
    
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
    
    func getTeams(completion: @escaping (Teams) -> Void) {
        
        let url = "https://free-nba.p.rapidapi.com/teams/"
        
        self.getResponse(from: url, decodeIn: Teams.self) { response in
            
            switch response {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print(error)
            }
        }
        
        //        let task = session?.dataTask(with: url, completionHandler: { (data, response, error) in
        //
        //            if let error = error {
        //                print("Error accessing swapi.co: \(error)")
        //                return
        //            } else {
        //
        //                guard let httpResponse = response as? HTTPURLResponse,
        //                      (200...299).contains(httpResponse.statusCode) else {
        //                    print("Error with the response, unexpected status code: \(String(describing: response))")
        //                    return
        //                }
        //
        //                if let data = data,
        //                   let teams = try? JSONDecoder().decode(Teams.self, from: data) {
        //                    completionHandler(teams)
        //                }
        //            }
        //        })
        //
        //        task?.resume()
    }
}
