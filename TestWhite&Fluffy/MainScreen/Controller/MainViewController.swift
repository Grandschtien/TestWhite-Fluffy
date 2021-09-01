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
    private var longitudeAndLatitudeArray:[(name: String, lat: Double, lon: Double, weather: Weather?)] = [("Москва",55.75, 37.62, nil),("Абакан",53.72, 91.43, nil),("Адлер",43.43, 39.92, nil),("Азов",47.11, 39.42, nil),("Александров",56.4, 38.71, nil),("Алексин",54.51, 37.07, nil),("Альметьевск",54.9,  52.32, nil),("Анадырь",64.73, 177.51, nil),("Анапа",44.89, 37.32, nil),("Ангарск",52.54, 103.89, nil),("Астрахань",46.3497, 48.0408, nil)]
    private var filteredCities = [(name: String, lat: Double, lon: Double, weather: Weather?)]()
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction(sender: )))
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите город"
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
        MainNetworkService.shared.fetchWeather(lon: lon, lat: lat) {[weak self] weather in
            DispatchQueue.main.async {
                self?.longitudeAndLatitudeArray[indexPath.row].weather = weather
                cell.configure(nameOf: name, weather: weather)
            }
        }
        return cell
    }
    
    
}
//MARK:- TableView delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = CityWeatherViewController()
        if isFiltering {
            nextVC.nameOfCity = filteredCities[indexPath.row].name
            nextVC.lat = filteredCities[indexPath.row].lat
            nextVC.lon = filteredCities[indexPath.row].lon
            nextVC.weather = filteredCities[indexPath.row].weather
        }else {
            nextVC.nameOfCity = longitudeAndLatitudeArray[indexPath.row].name
            nextVC.lat = longitudeAndLatitudeArray[indexPath.row].lat
            nextVC.lon = longitudeAndLatitudeArray[indexPath.row].lon
            nextVC.weather = longitudeAndLatitudeArray[indexPath.row].weather
        }
        navigationController?.pushViewController(nextVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc private func addAction(sender: UIBarButtonItem) {
        let alerController = UIAlertController(title: "Введите данные о городе", message: "Пожалуйста, заполните все поля", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Ok", style: .default) {[weak self] _ in
            DispatchQueue.main.async {
                let buffTuple: (name: String, lat: Double, lon: Double, weather: Weather?)
                guard let name = alerController.textFields?[0].text,
                      let lat = alerController.textFields?[1].text,
                      let lon = alerController.textFields?[2].text
                else { return }
                buffTuple.name = name
                guard let lat = Double(lat), let lon = Double(lon) else { return }
                buffTuple.lat = lat
                buffTuple.lon = lon
                buffTuple.weather = nil
                self?.longitudeAndLatitudeArray.append(buffTuple)
                self?.tableView.reloadData()
            }
            
        }
        alerController.addTextField { tf in
            tf.placeholder = "Название города"
        }
        alerController.addTextField { tf in
            tf.placeholder = "Широта"
        }
        alerController.addTextField { tf in
            tf.placeholder = "Долгота"
        }
        alerController.addAction(cancelAction)
        alerController.addAction(okAction)
        self.present(alerController, animated: true, completion: nil)
    }
}

//MARK:- Search delegate
extension MainViewController{
    private func filterContentOfSearchText(searchText: String) {
        filteredCities = longitudeAndLatitudeArray.filter({ (name: String, lat: Double, lon: Double, weather: Weather?) in
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
