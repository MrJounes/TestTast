//
//  UIView.swift
//  TestTask
//
//  Created by Игорь Дикань on 29.03.2022.
//

import UIKit

extension UIView {
    
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }
    
    func addShadow(
        color: UIColor = .black,
        radius: CGFloat = 4,
        opacity: Float = 0.25,
        offset: CGSize = CGSize(width: 0, height: 2)
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.masksToBounds = false
    }
}
