//
//  SceneBuilderService.swift
//  TestTask
//
//  Created by Игорь Дикань on 28.03.2022.
//

// MARK: - SceneBuildable
protocol SceneBuildable {
    func buildMainScene() -> MainViewController
}

// MARK: - SceneBuilderService
final class SceneBuilderService {
    
    private let jsonDecoderManager: JSONDecodable
    private let networkService: Networkable
    private let apiService: APIServiceProtocol
    
    init() {
        jsonDecoderManager = JSONDecodeManager()
        networkService = NetworkService(jsonDecoder: jsonDecoderManager)
        apiService = APIService(networkService: networkService)
    }
}

// MARK: - SceneBuildable Impl
extension SceneBuilderService: SceneBuildable {
    
    func buildMainScene() -> MainViewController {
        let viewController = MainViewController()
        let presenter = MainPresenter(apiService: apiService)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
