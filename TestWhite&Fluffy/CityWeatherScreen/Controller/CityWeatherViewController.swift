//
//  CityWeatherViewController.swift
//  TestWhite&Fluffy
//
//  Created by Егор Шкарин on 01.09.2021.
//

import UIKit

class CityWeatherViewController: UIViewController {
    var nameOfCity: String?
    var lon: Double?
    var lat: Double?
    var weather: Weather! = nil
    
    private let conditionImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Kefa", size: 70)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    private let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Kefa", size: 16)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Kefa", size: 29)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    private let pressureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Kefa", size: 29)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    private let additionalWeather: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Kefa", size: 29)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Kefa", size: 29)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    var additionalStackView: UIStackView!
    var firstVerticalStackView: UIStackView!
    var secondVerticalStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupVC()
        setupConstraints()
        self.setupDataToElements()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    private func setupVC() {
        title = nameOfCity
        self.view.backgroundColor = .white
        //second stackView
        self.secondVerticalStackView = UIStackView(arrangedSubviews: [tempLabel, feelsLikeLabel])
        self.secondVerticalStackView.spacing = 10
        self.secondVerticalStackView.alignment = .trailing
        self.secondVerticalStackView.axis = .vertical
        // fisrt stack view
        self.firstVerticalStackView = UIStackView(arrangedSubviews: [conditionImage, secondVerticalStackView])
        self.firstVerticalStackView.axis = .vertical
        self.firstVerticalStackView.alignment = .center
        self.firstVerticalStackView.distribution = .fill
        self.firstVerticalStackView.spacing = 10
        //additionalStackView
        self.additionalStackView = UIStackView(arrangedSubviews: [windSpeedLabel, pressureLabel, additionalWeather, dateLabel])
        self.additionalStackView.axis = .vertical
        self.additionalStackView.alignment = .leading
        self.additionalStackView.distribution = .fill
        self.view.addSubview(firstVerticalStackView)
        self.view.addSubview(additionalStackView)
    }
    private func setupDataToElements() {
        self.conditionImage.image = UIImage(systemName: checkConditionalImage())
        self.feelsLikeLabel.text = "Ощущается как \(Int(weather.fact?.feelsLike ?? 0)) °C"
        self.tempLabel.text = "\(Int(weather.fact?.temp ?? 0)) °C"
        self.additionalWeather.text = checkAdditionalWeather()
        self.windSpeedLabel.text = "Ветер: \(weather.fact?.windSpeed ?? 0) м/с"
        self.pressureLabel.text = "Давление: \(weather.fact?.pressureMm ?? 0) мм рт. ст."
        self.dateLabel.text = "Дата: \(fromatDate(date: Date()))"
    }
    
    
    private func setupConstraints() {
        firstVerticalStackView.translatesAutoresizingMaskIntoConstraints = false
        conditionImage.translatesAutoresizingMaskIntoConstraints = false
        additionalStackView.translatesAutoresizingMaskIntoConstraints = false
        let verticalSpace = NSLayoutConstraint(item: self.additionalStackView!, attribute: .bottom, relatedBy: .equal, toItem: self.firstVerticalStackView, attribute: .bottom, multiplier: 1, constant: 150)
        NSLayoutConstraint.activate([
            self.firstVerticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            self.firstVerticalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.conditionImage.widthAnchor.constraint(equalToConstant: 200),
            self.conditionImage.heightAnchor.constraint(equalToConstant: 200),
            self.additionalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.additionalStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 10),
            self.additionalStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            verticalSpace
        ])
    }
    
}
//Helpers
extension CityWeatherViewController {
    private func checkConditionalImage() -> String {
        switch weather.fact?.condition {
        case "thunderstorm","thunderstorm-with-rain", "thunderstorm-with-hail":
            conditionImage.tintColor = #colorLiteral(red: 0.07166468617, green: 0.5014688939, blue: 1, alpha: 1)
            return "cloud.bolt.rain.fill"
        case "drizzle", "light-rain":
            conditionImage.tintColor = #colorLiteral(red: 0.07166468617, green: 0.5014688939, blue: 1, alpha: 1)
            return "cloud.drizzle.fill"
        case "rain", "moderate-rain", "heavy-rain", "continuous-heavy-rain", "showers":
            conditionImage.tintColor = #colorLiteral(red: 0.07166468617, green: 0.5014688939, blue: 1, alpha: 1)
            return "cloud.rain.fill"
        case "wet-snow", "light-snow", "snow", "snow-showers":
            conditionImage.tintColor = #colorLiteral(red: 0.07166468617, green: 0.5014688939, blue: 1, alpha: 1)
            return "cloud.snow.fill"
        case "hail":
            conditionImage.tintColor = #colorLiteral(red: 0.07166468617, green: 0.5014688939, blue: 1, alpha: 1)
            return "cloud.hail.fill"
        case "clear":
            conditionImage.tintColor = #colorLiteral(red: 0.9994240403, green: 0.9075902983, blue: 0.124948792, alpha: 1)
            return "sun.min.fill"
        case "partly-cloudy", "cloudy", "overcast":
            conditionImage.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            return "cloud.fill"
        default:
            return "nosign"
        }
    }
    private func checkAdditionalWeather() -> String {
        switch weather.fact?.phenomCondition{
        case "fog":
            return "Туман"
        case "mist":
            return "Дымка"
        case "smoke":
            return "Смог"
        case "dust":
            return "Пыль"
        case "dust-suspension":
            return "Пылевая взвесь"
        case "duststorm":
            return "Пыльная буря"
        case "thunderstorm-with-duststorm":
            return "Пыльная буря с грозой"
        case "drifting-snow":
            return "Слабая метель"
        case "blowing-snow":
            return "Метель"
        case "ice-pellets":
            return "Ледяная крупа"
        case "freezing-rain":
            return "Ледяной дождь"
        case "tornado":
            return "Торнадо"
        case "volcanic-ash":
            return "Вулканический пепел"
        default:
            return ""
        }
    }
    private func fromatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = NSLocale(localeIdentifier: "en_US") as Locale?
        return formatter.string(from: date as Date)
    }
}


