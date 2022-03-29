//
//  MainPresenter.swift
//  TestTask
//
//  Created by Игорь Дикань on 28.03.2022.
//

// MARK: - MainPresenterProtocol
protocol MainPresenterProtocol: AnyObject {
    func fetchDrinks()
    func selectDrink(by index: Int)
    func selectDrink(by text: String)
}

// MARK: - MainPresenter
final class MainPresenter {

    weak var viewController: MainViewProtocol?
    
    private let apiService: APIServiceProtocol
    private var drinks: [DrinkModel] = []
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
}

// MARK: - MainPresenterProtocol Impl
extension MainPresenter: MainPresenterProtocol {
    
    func fetchDrinks() {
        apiService.fetchCoctails { [weak self] result in
            switch result {
            case .success(let response):
                let drinks = response.drinks.map {
                    DrinkModel(
                        title: $0.name,
                        isSelected: false
                    )
                }
                self?.drinks = drinks
                self?.viewController?.display(drinks)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func selectDrink(by index: Int) {
        drinks[index].isSelected.toggle()
        viewController?.display(drinks)
    }
    
    func selectDrink(by text: String) {
        let word = text + " "
        drinks.enumerated().forEach { (index, drink) in
            let isEmpty = text.isEmpty
            let isContains = drink.title.contains(word)
            
            if isEmpty || !isContains {
                drinks[index].isSelected = false
            } else {
                drinks[index].isSelected = true
            }
        }
        viewController?.display(drinks)
    }
}
