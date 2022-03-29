//
//  UICollectionView.swift
//  TestTask
//
//  Created by Игорь Дикань on 28.03.2022.
//

import UIKit

extension UICollectionView {

    func register(cellType: UICollectionViewCell.Type) {
        register(
            cellType,
            forCellWithReuseIdentifier: cellType.reuseIdentifier
        )
    }

    func dequeueReusableCell<T: UICollectionViewCell>(withType type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: type.reuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError("\(String(describing: T.self)) not found")
        }
        return cell
    }
}
