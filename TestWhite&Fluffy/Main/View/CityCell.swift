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
    
    func configure(weather: Weather) {
        nameLabel.text = weather.info?.tzinfo?.name
        conditionLabel.text = weather.fact?.condition
        temperatureLabel.text = "\(weather.fact?.temp ?? 0) °C"
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//            super.setSelected(selected, animated: animated)
//        }
}
