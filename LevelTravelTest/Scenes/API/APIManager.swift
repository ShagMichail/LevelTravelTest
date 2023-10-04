//
//  APIManager.swift
//  LevelTravelTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import Foundation

enum APIManagerError: Error {
    case serverError(HotelsError)
    case unknown(String = "An unknown error occurred.")
    case decodingError(String = "Error parsing server response.")
}

final class APIManager {
    var hotels: [Hotel] = []

    func fetchHotels() -> [Hotel] {
        hotels = [
            Hotel(id: 1, name: "Cosmos Moscow Vdnh Hotel 3", rating: 4.6, address: "Москва", description: "Самые лучшие цены!", images: ["hotel1", "hotel2", "hotel3"]),
            Hotel(id: 2, name: "Palmira Business Club", rating: 2.7, address: "Михайлово-Ярцевское п. район, г. Москва, ул. д. Лужки, мкр-н Солнечный Город-2, д. 2. Загородный клуб «Лачи»", description: "Самые лучшие виды из окон!", images: ["hotel2", "hotel3", "hotel1"]),
            Hotel(id: 3, name: "Magic Harp", rating: 4.1, address: "г. Москва, пер. Лялин, д. 3 стр. 3", description: "Попадаете в сказку с сказочными предложениями!", images: ["hotel3", "hotel1", "hotel2"]),
            Hotel(id: 4, name: "Отель Вега Измайлово", rating: 3.5, address: "Измайловское шоссе, д. 71, стр. 3В, Москва", description: "Удивим вас своим сервисом!", images: ["hotel1", "hotel3", "hotel2"]),
            Hotel(id: 5, name: "Cosmos Moscow Vdnh Hotel 3", rating: 4.6, address: "Москва", description: "Самые лучшие цены!", images: ["hotel2", "hotel3", "hotel1"]),
            Hotel(id: 6, name: "Palmira Business Club", rating: 2.7, address: "Михайлово-Ярцевское п. район, г. Москва, ул. д. Лужки, мкр-н Солнечный Город-2, д. 2. Загородный клуб «Лачи»", description: "Самые лучшие виды из окон!", images: ["hotel3", "hotel1", "hotel2"])
        ]
        return hotels
    }
}

