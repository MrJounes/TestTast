//
//  APIEndpoint.swift
//  TestTask
//
//  Created by Игорь Дикань on 28.03.2022.
//

import Moya

// MARK: - APIEndpoint
enum APIEndpoint {
    case fetchCocktails
}

// MARK: - TargetType Impl
extension APIEndpoint: TargetType {
    
    var headers: [String : String]? {
        switch self {
        case .fetchCocktails:
            return nil
        }
    }
    
    var baseURL: URL {
        switch self {
        case .fetchCocktails:
            return URL(string: "https://www.thecocktaildb.com")!
        }
    }
    
    var path: String {
        switch self {
        case .fetchCocktails:
            return "/api/json/v1/1/filter.php"
        }
    }
    
    var method: Method {
        switch self {
        case .fetchCocktails:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchCocktails:
            return ["a": "Non_Alcoholic"]
        }
    }
    
    var task: Task {
        switch self {
        case .fetchCocktails:
            return .requestParameters(
                parameters: parameters ?? [:],
                encoding: URLEncoding())
        }
    }
}
