//
//  MainViewController.swift
//  TestTask
//
//  Created by Игорь Дикань on 28.03.2022.
//

import UIKit

// MARK: - MainViewProtocol
protocol MainViewProtocol: AnyObject {
    func display(_ drinks: [DrinkModel])
}

// MARK: - MainViewController
final class MainViewController: UIViewController {
    
    private enum Constants {
        static let itemHeight: CGFloat = 30
        static let constantItemLength: CGFloat = 16
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = TagsFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(cellType: DrinkCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var drinks: [DrinkModel] = []
    
    var presenter: MainPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
}

// MARK: - MainViewProtocol Impl
extension MainViewController: MainViewProtocol {
    
    func display(_ drinks: [DrinkModel]) {
        self.drinks = drinks
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource Impl
extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withType: DrinkCollectionViewCell.self,
            for: indexPath
        )
        let model = drinks[indexPath.item]
        cell.setupCell(with: model)
        return cell
    }
}

// MARK: - UICollectionViewDelegate Impl
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Impl
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let itemTitle = drinks[indexPath.item].title
        return CGSize(
            width: fetchItemWidth(with: itemTitle),
            height: Constants.itemHeight
        )
    }
}

// MARK: - Private methods
private extension MainViewController {
    
    func setupViewController() {
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
        presenter?.fetchDrinks()
    }
    
    func addSubviews() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func fetchItemWidth(with text: String) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.sizeToFit()
        let width: CGFloat = label.frame.size.width + Constants.constantItemLength
        return width
    }
}
