//
//  HotelService.swift
//  Hotel
//
//  Created by Grigory Sapogov on 25.12.2023.
//

import UIKit

enum HotelServiceError: Error {
    case invalidImageData
}

final class HotelService {
    
    private let api: Api
    
    init(api: Api = Api()) {
        self.api = api
    }
    
    func fetchHotel(completion: @escaping (Swift.Result<Hotel, Error>) -> Void) {
     
        self.api.fetchHotel { [weak self] result in
            
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(json):
                
                DispatchQueue.global().async {
                    
                    let hotel = Hotel(data: json)
                    
                    self?.updateHotelImage(hotel: hotel, completion: completion)
                    
                }
                
            }
            
        }
        
    }
    
    private func fetchHotelImage(url: String, completion: @escaping (Swift.Result<UIImage, Error>) -> Void) {
        
        self.api.fetchHotelImage(urlString: url) { result in
            
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(data):
                
                DispatchQueue.global().async {
                    
                    guard let image = UIImage(data: data) else {
                        DispatchQueue.main.async {
                            completion(.failure(HotelServiceError.invalidImageData))
                        }
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(image))
                    }
                    
                }
                
            }
            
        }
        
    }
    
    private func updateHotelImage(hotel: Hotel, completion: @escaping (Swift.Result<Hotel, Error>) -> Void) {
        
        DispatchQueue.global().async {
            
            let group = DispatchGroup()
            
            var resultError: Error?
            
            var resultImages: [UIImage] = []
            
            let resultQueue = DispatchQueue(label: "Result.Queue", attributes: .concurrent)
            
            for imageUrl in hotel.imageUrls {
                
                group.enter()
                
                self.fetchHotelImage(url: imageUrl) { result in
                    
                    resultQueue.async(flags: .barrier) {
                        
                        defer {
                            group.leave()
                        }
                        
                        switch result {
                        case let .failure(error):
                            resultError = error
                        case let .success(image):
                            resultImages.append(image)
                        }
                        
                    }
                    
                }
                
            }
            
            group.notify(queue: resultQueue) {
                
                if let resultError = resultError {
                    DispatchQueue.main.async {
                        completion(.failure(resultError))
                    }
                    return
                }
                
                hotel.update(images: resultImages)
                
                DispatchQueue.main.async {
                    completion(.success(hotel))
                }
                
            }
            
        }
        
    }
    
}
