//
//  PrimaryButton.swift
//  Hotel
//
//  Created by Grigory Sapogov on 25.12.2023.
//

import UIKit

final class PrimaryButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = Colors.primaryColor
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.titleLabel?.font = Fonts.primaryFont
    }
    
}
