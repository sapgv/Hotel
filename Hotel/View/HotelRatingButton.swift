//
//  HotelRatingButton.swift
//  Hotel
//
//  Created by Grigory Sapogov on 25.12.2023.
//

import UIKit

final class HotelRatingButton: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private let stackView = UIStackView()
    
    private let imageView = UIImageView()
    
    private let titleLabel = UILabel()
    
    private let padding: CGFloat = 4
    
    func setup(hotel: Hotel) {
        self.titleLabel.text = "\(hotel.rating) \(hotel.ratingName)"
    }
    
    private func commonInit() {
        
        self.backgroundColor = Colors.ratingBackgroundColor
        self.tintColor = Colors.ratingTextColor
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        self.setupStackView()
        self.setupImageView()
        self.setupTitleLabel()
        self.layout()
        
    }
    
    private func setupStackView() {
        self.stackView.axis = .horizontal
        self.stackView.alignment = .fill
        self.stackView.distribution = .fill
        self.stackView.spacing = 4
    }
    
    private func setupImageView() {
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.image = UIImage(systemName: "star.fill")?.withTintColor(Colors.ratingTextColor)
    }
    
    private func setupTitleLabel() {
        self.titleLabel.font = Fonts.ratingFont
        self.titleLabel.textColor = Colors.ratingTextColor
    }
    
    private func layout() {
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        self.stackView.addArrangedSubview(imageView)
        self.stackView.addArrangedSubview(titleLabel)
        
        self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding).isActive = true
        
        self.imageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
    }
    
}
