//
//  HomeVC.swift
//  LevelTravelTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import UIKit
import SnapKit
import ImageSlideshow

final class HomeVC: UIViewController {
    
    var dataStore: HotelsDataStore = HomeViewDataStore.shared
    
    private let viewModel = HomeControllerViewModel()
    
    lazy var contentView = HomeView(delegate: self)
    
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupModel()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        contentView.table.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func loadView() {
        view = contentView
    }
    
    private func setupModel() {
        
        contentView.loadingView.isHidden = true
        
        self.viewModel.onBrandsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.contentView.table.reloadData()
                self?.contentView.loadingView.isHidden = true
            }
        }
        
        self.viewModel.onErrorMessage = { [weak self] error in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                
                switch error {
                case .serverError(let serverError):
                    alert.title = "Server Error \(serverError.errorCode)"
                    alert.message = serverError.errorMessage
                case .unknown(let string):
                    alert.title = "Error Fetching Coins"
                    alert.message = string
                case .decodingError(let string):
                    alert.title = "Error Parsing Data"
                    alert.message = string
                }
                
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        tabBarController?.tabBar.backgroundImage = UIImage()
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true

            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) { // Remove the 1-second delay if you want to load the data without waiting
                self.viewModel.fetchBrands()
                DispatchQueue.main.async {
                    self.contentView.table.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
}


extension HomeVC: HomeViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 330
        } else {
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.dataStore.hotels.count - 2, !isLoading {
            loadMoreData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let currentCell = tableView.cellForRow(at: indexPath) as? HomeViewCell else { return }

        let hotel = self.dataStore.hotels[indexPath.row]
        let rootVC = DetailsVC(hotel: hotel)
        rootVC.contentView.headerView.navTitle.text = "Отель"
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.dataStore.hotels.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewCell.identifier, for: indexPath) as? HomeViewCell else { return UITableViewCell()}
            let hotel = self.dataStore.hotels[indexPath.row]
            cell.configure(hotel: hotel)
            cell.delegate = self
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewLoadCell.identifireHomeViewLoadCellCell, for: indexPath) as? HomeViewLoadCell else { return UITableViewCell()}
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UILabel()
    }
}

extension HomeVC: HomeViewCellDescription {
    func didTapSlideShow(slide: ImageSlideshow) {
        slide.presentFullScreenController(from: self)
    }
    
    func didTapFavouritesButton(hotel: (Hotel, Bool)) {
        var index = 0
        while dataStore.hotels[index].0.id != hotel.0.id {
            index += 1
        }
        if dataStore.hotels[index].1 {
            dataStore.hotels[index].1 = false
        } else {
            dataStore.hotels[index].1 = true
        }
        contentView.table.reloadData()
        
    }
}
