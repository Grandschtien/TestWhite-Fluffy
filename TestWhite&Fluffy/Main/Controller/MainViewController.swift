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
    private let longitudeAndLatitudeArray:[(name: String, lat: Double, lon: Double)] = [("Москва",55.75, 37.62),("Абакан",53.72, 91.43),("Адлер",43.43, 39.92),("Азов",47.11, 39.42),("Александров",56.4, 38.71),("Алексин",54.51, 37.07),("Альметьевск",54.9,  52.32),("Анадырь",64.73, 177.51),("Анапа",44.89, 37.32),("Ангарск",52.54, 103.89),("Астрахань",46.3497, 48.0408)]
    private var filteredCities = [(name: String, lat: Double, lon: Double)]()
    private var tableView: UITableView!
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        title = "Города"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите город"
        //searchController.delegate = self
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
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
        if isFiltering {
            return filteredCities.count
        }
        return longitudeAndLatitudeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CityCell(style: .default, reuseIdentifier: CityCell.reuseId)
        var lat: Double = 0
        var lon: Double = 0
        var name = ""
        if isFiltering {
            lat = filteredCities[indexPath.row].lat
            lon = filteredCities[indexPath.row].lon
            name = filteredCities[indexPath.row].name
        } else {
             lat = longitudeAndLatitudeArray[indexPath.row].lat
             lon = longitudeAndLatitudeArray[indexPath.row].lon
             name = longitudeAndLatitudeArray[indexPath.row].name
        }
        MainNetworkService.shared.fetchWeather(lon: lon, lat: lat) {weather in
            DispatchQueue.main.async {
                cell.configure(nameOf: name, weather: weather)
            }
        }
        return cell
    }
    
    
}
//MARK:- TableView delegate
extension MainViewController: UITableViewDelegate {
    
}

//MARK:- Search delegate
extension MainViewController{
    private func filterContentOfSearchText(searchText: String) {
        filteredCities = longitudeAndLatitudeArray.filter({ (name: String, _: Double, _: Double) in
            return name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentOfSearchText(searchText: searchController.searchBar.text ?? "")
    }
}
