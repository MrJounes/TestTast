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
        static let textFieldIndent: CGFloat = 50
        static let textFieldHeight: CGFloat = 30
        static let textFieldRadius: CGFloat = 10
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
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Coctail name"
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.layer.cornerRadius = Constants.textFieldRadius
        textField.delegate = self
        textField.addShadow()
        return textField
    }()
    
    private var drinks: [DrinkModel] = []
    
    var presenter: MainPresenterProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservesForKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservesForKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    @objc func keyboardWillShow(_ notification : Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            textField.snp.removeConstraints()
            textField.snp.makeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(Constants.textFieldHeight)
                $0.bottom.equalToSuperview().offset(-keyboardHeight)
            }
            textField.layer.cornerRadius = .zero
            collectionView.snp.updateConstraints {
                $0.bottom.equalTo(textField.snp.top)
            }
            view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification : Notification) {
        textField.snp.removeConstraints()
        textField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.textFieldIndent)
            $0.height.equalTo(Constants.textFieldHeight)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Constants.textFieldIndent)
        }
        textField.layer.cornerRadius = Constants.textFieldRadius
        collectionView.snp.updateConstraints {
            $0.bottom.equalTo(textField.snp.top).offset(-Constants.textFieldIndent)
        }
        view.layoutIfNeeded()
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
        presenter?.selectDrink(by: indexPath.row)
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

// MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        presenter?.selectDrink(by: text)
    }
}

// MARK: - Private methods
private extension MainViewController {
    
    func setupViewController() {
        view.backgroundColor = .systemBackground
        view.addTapGestureToHideKeyboard()
        addSubviews()
        setupConstraints()
        presenter?.fetchDrinks()
    }
    
    func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(textField)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(textField.snp.top).offset(-Constants.textFieldIndent)
        }
        
        textField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(Constants.textFieldIndent)
            $0.height.equalTo(Constants.textFieldHeight)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Constants.textFieldIndent)
        }
    }
    
    func fetchItemWidth(with text: String) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.sizeToFit()
        let width: CGFloat = label.frame.size.width + Constants.constantItemLength
        return width
    }
    
    func addObservesForKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeObservesForKeyboard() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
}
