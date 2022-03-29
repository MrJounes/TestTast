//
//  GradientView.swift
//  TestTask
//
//  Created by Игорь Дикань on 29.03.2022.
//

import UIKit

// MARK: - GradientView
final class GradientView: UIView {
    
    var topColor: UIColor = UIColor.red
    var bottomColor: UIColor = UIColor.purple

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        guard let gradientLayer = layer as? CAGradientLayer else {
            return
        }
        gradientLayer.colors = [
            topColor.cgColor,
            bottomColor.cgColor
        ]
    }
}
