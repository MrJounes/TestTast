//
//  CocktailsResponse.swift
//  TestTask
//
//  Created by Игорь Дикань on 28.03.2022.
//

// MARK: - CocktailsResponse
struct CocktailsResponse: Decodable {
    let drinks: [DrinkResponse]
}

// MARK: - DrinkResponse
struct DrinkResponse: Decodable {
    let name: String
    let imageUrlString: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case imageUrlString = "strDrinkThumb"
        case id = "idDrink"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        imageUrlString = try container.decode(String.self, forKey: .imageUrlString)
        id = try container.decode(String.self, forKey: .id)
    }
}
