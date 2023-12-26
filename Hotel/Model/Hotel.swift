//
//  Hotel.swift
//  Hotel
//
//  Created by Grigory Sapogov on 25.12.2023.
//

import UIKit

final class Hotel {
    
    let id: Int
    
    let name: String
    
    let address: String
    
    let minimalPrice: Decimal
    
    let priceForIt: String
    
    let rating: Int
    
    let ratingName: String
    
    let description: String
    
    let peculiarities: [String]
    
    let imageUrls: [String]
    
    private(set) var images: [UIImage] = []
    
    init(data: [String: Any]) {
        self.id = data["id"] as? Int ?? 0
        self.name = data["name"] as? String ?? ""
        self.address = data["address"] as? String ?? ""
        self.minimalPrice = data["minimal_price"] as? Decimal ?? 0
        self.priceForIt = data["price_for_it"] as? String ?? ""
        self.rating = data["rating"] as? Int ?? 0
        self.ratingName = data["rating_name"] as? String ?? ""
        self.imageUrls = data["image_urls"] as? [String] ?? []
        
        if let aboutData = data["about_the_hotel"] as? [String: Any] {
            self.description = aboutData["description"] as? String ?? ""
            self.peculiarities = aboutData["peculiarities"] as? [String] ?? []
        }
        else {
            self.description = ""
            self.peculiarities = []
        }
        
    }
    
    func update(images: [UIImage]) {
        self.images = images
    }
    
}
