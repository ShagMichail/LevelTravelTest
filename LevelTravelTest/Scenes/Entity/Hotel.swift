//
//  Hotel.swift
//  LevelTravelTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import UIKit

struct Hotel: Decodable {

    let id: Int
    let name: String
    let rating: Float
    let address: String
    let description: String
    let images: [String]
}

struct Query: Decodable {
    let hotels: [Hotel]
}
