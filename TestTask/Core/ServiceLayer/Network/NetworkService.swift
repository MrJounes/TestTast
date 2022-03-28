//
//  NetworkService.swift
//  TestTask
//
//  Created by Игорь Дикань on 28.03.2022.
//

import Moya

// MARK: - Networkable
protocol Networkable {
    func request<T: Decodable>(
        _ endPoint: TargetType,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

// MARK: - NetworkService
final class NetworkService {

    private let provider = MoyaProvider<MultiTarget>()
    private let jsonDecoder: JSONDecodable
    
    init(jsonDecoder: JSONDecodable) {
        self.jsonDecoder = jsonDecoder
    }
}

// MARK: - Networkable Impl
extension NetworkService: Networkable {

    func request<T: Decodable>(
        _ endPoint: TargetType,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else {
                return
            }
            let target = MultiTarget(endPoint)
            self.provider.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let data = response.data
                        let result: T = try self.jsonDecoder.decode(data)
                        completionHandler(.success(result))
                    } catch {
                        completionHandler(.failure(error))
                    }
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
        }

        func completionHandler(_ resultValue: Result<T, Error>) {
            DispatchQueue.main.async {
                completion(resultValue)
            }
        }
    }
}
