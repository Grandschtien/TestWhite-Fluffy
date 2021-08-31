//
//  ViewController.swift
//  TestWhite&Fluffy
//
//  Created by Егор Шкарин on 31.08.2021.
//

import UIKit
//89e57fa5-5c13-469c-86fe-3982efd73007

class MainViewController: UIViewController {

    private let searchController = UISearchController()
    private let longitudeAndLatitudeArray:[(lat: Double, lon: Double)] = [(43.02, 44.67),(55.75396, 37.620393),(55.0166667, 82.9333333),(55.4727, 49.0652),(59.57, 30.19),(43.3507, 39.4313),(55.4727, 49.0652),(55.4727, 49.0652),(55.4727, 49.0652),(55.4727, 49.0652),(55.4727, 49.0652)]
    private var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        title = "Города"
        navigationItem.searchController = searchController
        searchController.delegate = self
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.reuseId)
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        NSLayoutConstraint.activate([tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])

    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CityCell(style: .default, reuseIdentifier: CityCell.reuseId)
        let lat = longitudeAndLatitudeArray[indexPath.row].lat
        let lon = longitudeAndLatitudeArray[indexPath.row].lon
        MainNetworkService.shared.fetchWeather(lon: lon, lat: lat) {weather in
            DispatchQueue.main.async {
                cell.configure(weather: weather)
            }
        }
        return cell
    }
    
    
}
//MARK:- TableView delegate
extension MainViewController: UITableViewDelegate {
    
}

//MARK:- Search delegate
extension MainViewController: UISearchControllerDelegate {
    
}

