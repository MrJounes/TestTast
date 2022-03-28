//
//  DrinkCollectionViewCell.swift
//  TestTask
//
//  Created by Игорь Дикань on 28.03.2022.
//

import UIKit
import SnapKit

// MARK: - DrinkCollectionViewCell
final class DrinkCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let containerCornerRadius: CGFloat = 10
        static let titleSideIndent: CGFloat = 8
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = Constants.containerCornerRadius
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public methods
extension DrinkCollectionViewCell {
    
    func setupCell(with model: DrinkModel) {
        titleLabel.text = model.title
    }
}

// MARK: - Private methods
private extension DrinkCollectionViewCell {
    
    func setupCell() {
        addSubviews()
        setupConstraints()
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Constants.titleSideIndent)
        }
    }
}
