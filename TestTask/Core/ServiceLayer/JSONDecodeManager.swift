//
//  JSONDecodeManager.swift
//  TestTask
//
//  Created by Игорь Дикань on 28.03.2022.
//

import Foundation

// MARK: - JSONDecodable
protocol JSONDecodable {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

// MARK: - JSONDecodeManager
final class JSONDecodeManager {
    
    private let decoder: JSONDecoder
    
    init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
}

// MARK: - JSONDecodable Impl
extension JSONDecodeManager: JSONDecodable {
    
    func decode<T: Decodable>(_ data: Data) throws -> T {
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            throw error
        }
    }
}
