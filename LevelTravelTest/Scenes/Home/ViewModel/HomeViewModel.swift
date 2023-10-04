//
//  HomeViewModel.swift
//  LevelTravelTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import Foundation

final class HomeControllerViewModel {
    
    var onBrandsUpdated: (()->Void)?
    var onErrorMessage: ((APIManagerError)->Void)?
    
    var servise = APIManager()
    var dataStore: HotelsDataStore = HomeViewDataStore.shared
    
    private(set) var hotels: [(Hotel, Bool)] = [] {
        didSet {
            dataStore.hotels = hotels
            self.onBrandsUpdated?()
        }
    }
    
    init() {
        self.fetchBrands()
    }
    
    public func fetchBrands() {
        
        let hotelsFetch = servise.fetchHotels()
        for i in hotelsFetch {
            self.hotels.append((i,false))
        }
    }
}

