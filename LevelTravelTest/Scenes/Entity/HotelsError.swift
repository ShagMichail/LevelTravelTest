//
//  HotelsError.swift
//  LevelTravelTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import Foundation

struct HotelsStatus: Decodable {
    let status: HotelsError
}

struct HotelsError: Decodable {
    let errorCode: Int
    let errorMessage: String
    
    enum BrandsKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
}

