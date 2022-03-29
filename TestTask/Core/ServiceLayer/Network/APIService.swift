//
//  APIService.swift
//  TestTask
//
//  Created by Игорь Дикань on 28.03.2022.
//

// MARK: - APIServiceProtocol
protocol APIServiceProtocol {
    func fetchCoctails(complition: @escaping (Result<CocktailsResponse, Error>) -> Void)
}

// MARK: - APIService
final class APIService {
    
    private let networkService: Networkable
    
    init(networkService: Networkable) {
        self.networkService = networkService
    }
}

// MARK: - APIServiceProtocol
extension APIService: APIServiceProtocol {
    
    func fetchCoctails(complition: @escaping (Result<CocktailsResponse, Error>) -> Void) {
        networkService.request(APIEndpoint.fetchCocktails, completion: complition)
    }
}
