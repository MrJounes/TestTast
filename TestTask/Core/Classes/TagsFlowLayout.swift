//
//  TagsFlowLayout.swift
//  TestTask
//
//  Created by Игорь Дикань on 28.03.2022.
//

import UIKit

// MARK: - TagsFlowLayout
final class TagsFlowLayout: UICollectionViewFlowLayout {
    
    private enum Constants {
        static let minimumLineSpacing: CGFloat = 8
        static let minimumInteritemSpacing: CGFloat = 8
        static let sectionIndent: CGFloat = 16
    }
    
    override init() {
        super.init()
        setupFlowLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in:rect) else {
            return []
        }
        var x: CGFloat = sectionInset.left
        var y: CGFloat = .zero
        
        for attribute in attributes {
            if attribute.representedElementCategory != .cell {
                continue
            }
            
            if attribute.frame.origin.y >= y {
                x = sectionInset.left
            }
            attribute.frame.origin.x = x
            x += attribute.frame.width + minimumInteritemSpacing
            y = attribute.frame.maxY
        }
        return attributes
    }
}

// MARK: - Private methods
private extension TagsFlowLayout {
    
    func setupFlowLayout() {
        scrollDirection = .vertical
        minimumLineSpacing = Constants.minimumLineSpacing
        minimumInteritemSpacing = Constants.minimumInteritemSpacing
        sectionInset = UIEdgeInsets(
            top: Constants.sectionIndent,
            left: Constants.sectionIndent,
            bottom: Constants.sectionIndent,
            right: Constants.sectionIndent
        )
    }
}
