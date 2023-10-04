//
//  CustomLabelView.swift
//  LevelTravelTest
//
//  Created by Михаил Шаговитов on 03.10.2023.
//

import UIKit

final class CustomLabelView: UIView {
    
    lazy var headingLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "AlNile", size: 14)
        return label
    }()
    
    lazy var textLabel: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "AlNile", size: 18)
        return label
    }()
    
    required init() {
        super.init(frame: .zero)
        addSubviews()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(headingLabel)
        addSubview(textLabel)
    }
    
    private func makeConstraints() {
        headingLabel.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).inset(10)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(10).priority(.low)
            $0.top.equalTo(safeAreaLayoutGuide).inset(15)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(headingLabel).inset(25)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(10)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(7)
        }
    }
}
