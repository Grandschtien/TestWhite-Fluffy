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
    //private let longitudeAndLatitudeArray = []()
    private var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        MainNetworkService.shared.fetchWeather(lon: 55.75396, lat: 37.620393) {weather in
            DispatchQueue.main.async {
                print(weather)
            }
        }
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
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CityCell")
        return cell
    }
    
    
}
//MARK:- TableView delegate
extension MainViewController: UITableViewDelegate {
    
}

//MARK:- Search delegate
extension MainViewController: UISearchControllerDelegate {
    
}

