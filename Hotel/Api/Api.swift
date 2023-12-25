//
//  Api.swift
//  Hotel
//
//  Created by Grigory Sapogov on 25.12.2023.
//

import Foundation

enum ApiError: Error {
    case invalidUrl
    case invalidData
}

final class Api {
    
    private func fetchData(urlString: String, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(ApiError.invalidUrl))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(ApiError.invalidData))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
            
        }
        
        task.resume()
        
        
    }
    
    func fetchHotel(completion: @escaping (Swift.Result<[String: Any], Error>) -> Void) {
        
        self.fetchData(urlString: "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473") { result in
            
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(data):
                
                DispatchQueue.global().async {
                    
                    do {
                        
                        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            DispatchQueue.main.async {
                                completion(.failure(ApiError.invalidData))
                            }
                            return
                        }
                        
                        DispatchQueue.main.async {
                            completion(.success(json))
                        }
                        
                    }
                    catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func fetchHotelImage(urlString: String, completion: @escaping (Swift.Result<Data, Error>) -> Void) {
        
        self.fetchData(urlString: urlString, completion: completion)
        
    }
    
}
