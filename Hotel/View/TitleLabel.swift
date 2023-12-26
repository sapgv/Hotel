//
//  TitleLabel.swift
//  Hotel
//
//  Created by Grigory Sapogov on 25.12.2023.
//

import UIKit

final class TitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.font = Fonts.titleFont
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
    }
    
}
