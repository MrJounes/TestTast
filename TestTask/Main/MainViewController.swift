//
//  MainViewController.swift
//  TestTask
//
//  Created by Игорь Дикань on 28.03.2022.
//

import UIKit

// MARK: - MainViewProtocol
protocol MainViewProtocol: AnyObject {
    func displayDrinks()
}

// MARK: - MainViewController
final class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
}

// MARK: - MainViewProtocol Impl
extension MainViewController: MainViewProtocol {
    
    func displayDrinks() {
    }
}

// MARK: - Private methods
private extension MainViewController {
    
    func setupViewController() {
        view.backgroundColor = .systemBackground
        presenter?.fetchDrinks()
    }
}
