//
//  DetailsVC.swift
//  LevelTravelTest
//
//  Created by Михаил Шаговитов on 03.10.2023.
//

import UIKit
import ImageSlideshow

final class DetailsVC: UIViewController {
    
    lazy var contentView = DetailsView(delegate: self)
    
    var dataStore: HotelsDataStore = HomeViewDataStore.shared
    
    private var hotel: (Hotel, Bool)
    
    required init(hotel: (Hotel, Bool)) {
        self.hotel = hotel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupElement()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    override func loadView() {
        view = contentView
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
    }
    
    private func setupElement() {
        contentView.configure(with: hotel)
    }
    
    func setupNavBar(){
        navigationController?.navigationBar.isHidden = true
    }
}

extension DetailsVC: DetailsViewDelegate {
    
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    func didTapFavouritesButtonButton() {
        var index = 0
        while dataStore.hotels[index].0.id != self.hotel.0.id {
            index += 1
        }
        
        if hotel.1 {
            contentView.favouritesButton.backgroundColor = .systemBlue
            contentView.favouritesButton.tintColor = .white
            dataStore.hotels[index].1 = false
        } else {
            contentView.favouritesButton.backgroundColor = .white
            contentView.favouritesButton.tintColor = .red
            dataStore.hotels[index].1 = true
        }
    }
    
    func didTapSlideShow(slide: ImageSlideshow) {
        slide.presentFullScreenController(from: self)
    }

}

