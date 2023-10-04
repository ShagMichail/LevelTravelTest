//
//  HomeViewCell.swift
//  LevelTravelTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import UIKit
import SnapKit
import ImageSlideshow

protocol HomeViewCellDescription: AnyObject {
    func didTapFavouritesButton(hotel: (Hotel, Bool))
    func didTapSlideShow(slide: ImageSlideshow)
}

final class HomeViewCell: UITableViewCell {
    
    static let identifier = "CustomGroopTableViewCell"
    lazy var container = UIView()
    
    var hotel: (Hotel, Bool)?
    
    weak var delegate: HomeViewCellDescription?
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowRadius = 7
        view.layer.shadowOffset = CGSize(width: 5, height: 10)
        view.layer.cornerRadius = 20
        view.layer.shadowOpacity = 0.3
        return view
    }()

    lazy var slideshow = ImageSlideshow()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var favouritesButton: UIButton = {
        var button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 10
        button.layer.cornerRadius = 20
        button.setImage(UIImage(named: "likeRed"), for: .normal)
        return button
    }()
    
    let pageIndicator = UIPageControl()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .default
        contentView.backgroundColor = .clear
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }

    func configure(hotel: (Hotel, Bool) ) {
        self.hotel = hotel
        nameLabel.text = hotel.0.name
        ratingLabel.text = "Рейтинг отеля: \(hotel.0.rating)"

        slideshow.setImageInputs([
            ImageSource(image: UIImage(named: "\(hotel.0.images[0])")!),
            ImageSource(image: UIImage(named: "\(hotel.0.images[1])")!),
            ImageSource(image: UIImage(named: "\(hotel.0.images[2])")!)
        ])
        
        favouritesButton.addTarget(self, action: #selector(didTapFavouritesButton), for: .touchUpInside)
        
        if hotel.1 {
            favouritesButton.tintColor = .red
        } else {
            favouritesButton.tintColor = .systemBlue
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapSlideShow))
        slideshow.addGestureRecognizer(gestureRecognizer)
    }
    
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(slideshow)
        containerView.addSubview(nameLabel)
        containerView.addSubview(ratingLabel)
        containerView.addSubview(favouritesButton)
    }
    
    private func setupLayout() {
        
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide).inset(15)
            $0.bottom.equalTo(ratingLabel).inset(-10)
        }
        
        slideshow.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(containerView).inset(10)
            $0.height.equalTo(200)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView).inset(25)
            $0.top.equalTo(slideshow.snp.bottom).inset(-10)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.leading.equalTo(containerView).inset(25)
            $0.top.equalTo(nameLabel.snp.bottom).inset(-10)
        }
        
        favouritesButton.snp.makeConstraints {
            $0.bottom.equalTo(containerView).inset(15)
            $0.trailing.equalTo(containerView.snp.trailing).inset(20)
            $0.top.equalTo(nameLabel.snp.bottom).inset(-10)
            $0.height.equalTo(26)
            $0.width.equalTo(30)
        }
    }
    
    @objc func didTapFavouritesButton() {
        delegate?.didTapFavouritesButton(hotel: hotel!)
    }
    
    @objc func didTapSlideShow() {
        delegate?.didTapSlideShow(slide: self.slideshow)
    }
}


