//
//  HomeViewDataStore.swift
//  LevelTravelTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import UIKit

protocol HotelsDataStore: AnyObject {
    var hotels: [(Hotel, Bool)] { get set }
}

final class HomeViewDataStore: HotelsDataStore {
    
    var hotels: [(Hotel, Bool)] = []
    
    static let shared = HomeViewDataStore()
    
    init() {}
    
}

