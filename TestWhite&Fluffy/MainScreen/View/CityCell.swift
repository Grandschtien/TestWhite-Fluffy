//
//  CityCell.swift
//  TestWhite&Fluffy
//
//  Created by Егор Шкарин on 31.08.2021.
//

import UIKit

class CityCell: UITableViewCell {
    var verticalStackView: UIStackView!
    var horizontalStackView: UIStackView!
    let nameLabel: UILabel = UILabel()
    let conditionLabel: UILabel = UILabel()
    let temperatureLabel: UILabel = UILabel()
    static let reuseId = "CityCell"
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        verticalStackView = UIStackView(arrangedSubviews: [nameLabel, conditionLabel])
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 20
        horizontalStackView = UIStackView(arrangedSubviews: [verticalStackView, temperatureLabel])
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .center
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.spacing = 100
    
        nameLabel.font = UIFont(name: "Kefa", size: 25)
        conditionLabel.font = UIFont(name: "Kefa", size: 17)
        temperatureLabel.font = UIFont(name: "Kefa", size: 30)
        
        self.contentView.addSubview(horizontalStackView)
        setupLayout()
    }
    private func setupLayout() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 8),
            horizontalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(greaterThanOrEqualTo: self.contentView.trailingAnchor, constant: -10)
            
        
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(nameOf city: String, weather: Weather) {
        nameLabel.text = city
        conditionLabel.text = checkCondition(condition: weather.fact?.condition ?? "") 
        temperatureLabel.text = "\(Int(weather.fact?.temp ?? 0)) °C"
    }

}


extension CityCell {
    private func checkCondition(condition: String) -> String {
        switch condition {
        case "clear":
            return "Ясно"
        case "partly-cloudy":
            return "Малооблачно"
        case "cloudy":
            return "Облачно с прояснениями"
        case "overcast":
            return "Пасмурно"
        case "drizzle":
            return "Морось"
        case "light-rain":
            return "Небольшой дождь"
        case "rain":
            return "Дождь"
        case "moderate-rain":
            return "Умеренно сильный дождь"
        case "heavy-rain":
            return "Сильный дождь"
        case "continuous-heavy-rain":
            return "Длительный сильный дождь"
        case "showers":
            return "Ливень"
        case "wet-snow":
            return "Дождь со снегом"
        case "light-snow":
            return "Небольшой снег"
        case "snow":
            return "Снег"
        case "snow-showers":
            return "Снегопад"
        case "hail":
            return "Град"
        case "thunderstorm":
            return "Гроза"
        case "thunderstorm-with-rain":
            return "Дождь с грозой"
        case "thunderstorm-with-hail":
            return "Гроза с градом"
        default:
            print("undefinded condition")
            return "undefinded condition"
        }
    }
}
