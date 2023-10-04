//
//  DetailsView.swift
//  LevelTravelTest
//
//  Created by Михаил Шаговитов on 03.10.2023.
//

import UIKit
import SnapKit
import ImageSlideshow

protocol DetailsViewDelegate: AnyObject {
    func didTapBackButton()
    func didTapFavouritesButtonButton()
    func didTapSlideShow(slide: ImageSlideshow)
}

final class DetailsView: UIView {
    
    weak var delegate: DetailsViewDelegate?
    
    lazy var headerView: CustomHeader = {
        var view = CustomHeader()
        view.backgroundColor = .systemBlue
        view.reloadButton.removeFromSuperview()
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var ratingView: CustomLabelView = {
        var view = CustomLabelView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .green
        view.textLabel.textColor = .black
        view.headingLabel.textColor = .darkGray
        return view
    }()
    
    lazy var addresView: CustomLabelView = {
        var view = CustomLabelView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.textLabel.textColor = .black
        view.headingLabel.textColor = .darkGray
        return view
    }()
    
    lazy var descriptionView: CustomLabelView = {
        var view = CustomLabelView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        view.textLabel.textColor = .black
        view.headingLabel.textColor = .darkGray
        return view
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
    
    lazy var slideshow = ImageSlideshow()
    
    required init(delegate: DetailsViewDelegate) {
        super.init(frame: .zero)
        addSubviews()
        makeConstraints()
        setupElement()

        self.delegate = delegate
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElement() {
        headerView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        favouritesButton.addTarget(self, action: #selector(didTapFavouritesButtonButton), for: .touchUpInside)
    }
    
    func configure(with hotel: (Hotel, Bool)) {
        
        if hotel.1 {
            favouritesButton.backgroundColor = .white
            favouritesButton.tintColor = .red
        } else {
            favouritesButton.backgroundColor = .systemBlue
            favouritesButton.tintColor = .white
        }
        
        nameLabel.text = "\(hotel.0.name)"
        addresView.headingLabel.text = "Адрес"
        addresView.textLabel.text = "\(hotel.0.address)"
        descriptionView.headingLabel.text = "Описание"
        descriptionView.textLabel.text = "\(hotel.0.description)"
        ratingView.headingLabel.text = "Рейтинг отеля"
        ratingView.textLabel.text = "\(hotel.0.rating)"
    
        if hotel.0.rating < 3 {
            ratingView.backgroundColor = .red
        } else if hotel.0.rating < 4 {
            ratingView.backgroundColor = .yellow
        } else if hotel.0.rating < 4.5 {
            ratingView.backgroundColor = .systemGreen
        }

        slideshow.setImageInputs([
            ImageSource(image: UIImage(named: "\(hotel.0.images[0])")!),
            ImageSource(image: UIImage(named: "\(hotel.0.images[1])")!),
            ImageSource(image: UIImage(named: "\(hotel.0.images[2])")!)
        ])
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapSlideShow))
        slideshow.addGestureRecognizer(gestureRecognizer)

    }
    
    private func addSubviews() {
        addSubview(headerView)
        addSubview(nameLabel)
        addSubview(slideshow)
        addSubview(addresView)
        addSubview(descriptionView)
        addSubview(ratingView)
        addSubview(favouritesButton)
    }
    
    private func makeConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).inset(-15)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(30)
        }
        
        slideshow.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).inset(-15)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(0)
            $0.width.equalTo(UIScreen.main.bounds.size.width - 20)
            $0.height.equalTo(250)
        }
        
        addresView.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(30)
            $0.top.equalTo(slideshow.snp.bottom).inset(-15)
        }
        
        descriptionView.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(30)
            $0.top.equalTo(addresView.snp.bottom).inset(-15)
        }
        
        ratingView.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).inset(UIScreen.main.bounds.size.width / 7)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(75)
        }
        
        favouritesButton.snp.makeConstraints {
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(UIScreen.main.bounds.size.width / 5)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(75)
            $0.width.equalTo(75)
        }
  
    }
    
    @objc func didTapBackButton() {
        delegate?.didTapBackButton()
    }
    
    @objc func didTapFavouritesButtonButton() {
        delegate?.didTapFavouritesButtonButton()
    }
    
    @objc func didTapSlideShow() {
        delegate?.didTapSlideShow(slide: self.slideshow)
    }
}

