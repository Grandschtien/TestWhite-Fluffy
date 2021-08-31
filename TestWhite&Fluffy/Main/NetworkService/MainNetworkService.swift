//
//  MainNetworkService.swift
//  TestWhite&Fluffy
//
//  Created by Егор Шкарин on 31.08.2021.
//

import Foundation
import Alamofire
//lat=55.75396&lon=37.620393
class MainNetworkService {
    private init () {}
    static let shared = MainNetworkService()
    
    func fetchWeather(lon: Double, lat: Double, completion: @escaping (Any)->()) {
        guard let url = URL(string: "https://api.weather.yandex.ru/v2/forecast?lat=\(lat)&lon=\(lon)&limit=1&hours=false&extra=false") else { return }
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["X-Yandex-API-Key": "89e57fa5-5c13-469c-86fe-3982efd73007"], interceptor: nil, requestModifier: nil).responseJSON {[weak self] response in
            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                guard let weather = self?.decoder(data: data) else { return }
                completion(weather)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func decoder(data: Data) -> Weather?{
        let decoder = JSONDecoder()
        let decoded = try! decoder.decode(Weather.self, from: data)
        return decoded
    }
}
