//
//  UICollectionViewCell.swift
//  TestTask
//
//  Created by Игорь Дикань on 28.03.2022.
//

import UIKit

extension UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
