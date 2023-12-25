//
//  HotelViewModel.swift
//  Hotel
//
//  Created by Grigory Sapogov on 25.12.2023.
//

import Foundation

final class HotelViewModel {
    
    private(set) var hotel: Hotel?
    
    var updateCompletion: ((Error?) -> Void)?
    
    private let hotelService: HotelService
    
    init(hotelService: HotelService = HotelService()) {
        self.hotelService = hotelService
    }
    
    func update() {
    
        self.hotelService.fetchHotel { [weak self] result in
            
            switch result {
            case let .failure(error):
                self?.updateCompletion?(error)
            case let .success(hotel):
                self?.hotel = hotel
                self?.updateCompletion?(nil)
            }
            
        }
        
    }
    
    
}
