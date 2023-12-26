//
//  HotelHeaderCollectionCell.swift
//  Hotel
//
//  Created by Grigory Sapogov on 25.12.2023.
//

import UIKit

class HotelHeaderCollectionCell: UICollectionViewCell {

    @IBOutlet weak var ratingButton: HotelRatingButton!
    
    @IBOutlet weak var hotelTitle: UILabel!
   
    @IBOutlet weak var addressButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addressButton.setTitle("", for: .normal)
    }

    func setup(hotel: Hotel) {

        self.hotelTitle.text = hotel.name

        self.ratingButton.setup(hotel: hotel)

        self.addressButton.setTitle("Madinat Makadi, Safaga Road, Makadi Bay, Египет", for: .normal)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var frame = layoutAttributes.frame
            frame.size.height = ceil(size.height)
            layoutAttributes.frame = frame
            return layoutAttributes
        }
    
}
