//
//  BottomView.swift
//  Hotel
//
//  Created by Grigory Sapogov on 25.12.2023.
//

import UIKit

final class ButtomView: UIView {
    
    private(set) var primaryButton = PrimaryButton(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layout()
    }
    
    private func layout() {
        
        self.primaryButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(primaryButton)
        
        self.primaryButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        self.primaryButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        self.primaryButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        self.primaryButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
        
        self.primaryButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
    }
    
}
