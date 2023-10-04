//
//  HomeViewLoadCell.swift
//  LevelTravelTest
//
//  Created by Михаил Шаговитов on 03.10.2023.
//

import UIKit
import SnapKit

final class HomeViewLoadCell: UITableViewCell {
    
    let activityIndicator = UIActivityIndicatorView()
    
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
    
    private func setupViews() {
        addSubview(activityIndicator)

    }
    
    private func setupLayout() {
        
        activityIndicator.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(30)
            $0.top.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}

extension HomeViewLoadCell {
    
    static var nibHomeViewLoadCellCellCell : UINib{
        return UINib(nibName: identifireHomeViewLoadCellCell, bundle: nil)
    }
    
    static var identifireHomeViewLoadCellCell : String{
        return String(describing: self)
    }
}
