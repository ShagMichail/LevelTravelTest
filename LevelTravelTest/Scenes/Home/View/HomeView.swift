//
//  HomeView.swift
//  LevelTravelTest
//
//  Created by Михаил Шаговитов on 02.10.2023.
//

import UIKit
import SnapKit


protocol HomeViewDelegate: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    func numberOfSections(in tableView: UITableView) -> Int
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
}

final class HomeView: UIView {
    
    weak var delegate: HomeViewDelegate?
    
    lazy var headerView: CustomHeader = {
        var view = CustomHeader()
        view.navTitle.text = "Отели"
        view.backButton.removeFromSuperview()
        view.reloadButton.removeFromSuperview()
        view.backgroundColor = .systemBlue
        return view
    }()
    
    lazy var table: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(HomeViewCell.self, forCellReuseIdentifier: HomeViewCell.identifier)
        table.register(HomeViewLoadCell.self, forCellReuseIdentifier: HomeViewLoadCell.identifireHomeViewLoadCellCell)
        table.backgroundColor = .systemGray2
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .white
        return table
    }()
    
    lazy var loadingView = LoadView()
    
    required init(delegate: HomeViewDelegate) {
        super.init(frame: .zero)
        addSubviews()
        makeConstraints()
        table.dataSource = delegate
        table.delegate = delegate
        self.delegate = delegate
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(headerView)
        addSubview(table)
        addSubview(loadingView)
    }
    
    private func makeConstraints() {
        loadingView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).inset(0)
            $0.bottom.leading.trailing.equalTo(0)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(120)
        }
        
        table.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.bottom.equalTo(0)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
}


