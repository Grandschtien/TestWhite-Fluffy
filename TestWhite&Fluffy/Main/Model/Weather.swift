//
//  CityModel.swift
//  TestWhite&Fluffy
//
//  Created by Егор Шкарин on 31.08.2021.
//

import Foundation
// MARK: - Weather
struct Weather: Codable {
    let now: Double?
    let nowDt: String?
    let info: Info?
    let geoObject: GeoObject?
    let yesterday: Yesterday?
    let fact: Fact?

    enum CodingKeys: String, CodingKey {
        case now
        case nowDt = "now_dt"
        case info
        case geoObject = "geo_object"
        case yesterday, fact
    }
}

// MARK: - Fact
struct Fact: Codable {
    let obsTime, uptime, temp, feelsLike: Double?
    let icon, condition: String?
    let cloudness, precType, precProb, precStrength: Double?
    let isThunder: Bool?
    let windSpeed: Double?
    let windDir: String?
    let pressureMm, pressurePa, humidity: Double?
    let daytime: String?
    let polar: Bool?
    let season, source: String?
    let accumPrec: [String: Double]?
    let soilMoisture: Double?
    let soilTemp, uvIndex: Double?
    let windGust: Double?

    enum CodingKeys: String, CodingKey {
        case obsTime = "obs_time"
        case uptime, temp
        case feelsLike = "feels_like"
        case icon, condition, cloudness
        case precType = "prec_type"
        case precProb = "prec_prob"
        case precStrength = "prec_strength"
        case isThunder = "is_thunder"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case pressureMm = "pressure_mm"
        case pressurePa = "pressure_pa"
        case humidity, daytime, polar, season, source
        case accumPrec = "accum_prec"
        case soilMoisture = "soil_moisture"
        case soilTemp = "soil_temp"
        case uvIndex = "uv_index"
        case windGust = "wind_gust"
    }
}

// MARK: - Parts
struct Parts: Codable {
    let morning, nightShort, dayShort, night: Day?
    let evening, day: Day?

    enum CodingKeys: String, CodingKey {
        case morning
        case nightShort = "night_short"
        case dayShort = "day_short"
        case night, evening, day
    }
}

// MARK: - Day
struct Day: Codable {
    let source: String?
    let tempMin, tempAvg, tempMax: Double?
    let windSpeed, windGust: Double?
    let windDir: String?
    let pressureMm, pressurePa, humidity, soilTemp: Double?
    let soilMoisture, precMm: Double?
    let precProb, precPeriod: Double?
    let cloudness: Double?
    let precType: Double?
    let precStrength: Double?
    let icon, condition: String?
    let uvIndex, feelsLike: Double?
    let daytime: String?
    let polar: Bool?
    let temp: Double?

    enum CodingKeys: String, CodingKey {
        case source = "_source"
        case tempMin = "temp_min"
        case tempAvg = "temp_avg"
        case tempMax = "temp_max"
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDir = "wind_dir"
        case pressureMm = "pressure_mm"
        case pressurePa = "pressure_pa"
        case humidity
        case soilTemp = "soil_temp"
        case soilMoisture = "soil_moisture"
        case precMm = "prec_mm"
        case precProb = "prec_prob"
        case precPeriod = "prec_period"
        case cloudness
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case icon, condition
        case uvIndex = "uv_index"
        case feelsLike = "feels_like"
        case daytime, polar, temp
    }
}

// MARK: - GeoObject
struct GeoObject: Codable {
    let district, locality, province, country: Country?
}

// MARK: - Country
struct Country: Codable {
    let id: Double?
    let name: String?
}

// MARK: - Info
struct Info: Codable {
    let n: Bool?
    let geoid: Double?
    let url: String?
    let lat, lon: Double?
    let tzinfo: Tzinfo?
    let defPressureMm, defPressurePa: Double?
    let slug: String?
    let zoom: Double?
    let nr, ns, nsr, p: Bool?
    let f, h: Bool?

    enum CodingKeys: String, CodingKey {
        case n, geoid, url, lat, lon, tzinfo
        case defPressureMm = "def_pressure_mm"
        case defPressurePa = "def_pressure_pa"
        case slug, zoom, nr, ns, nsr, p, f
        case h = "_h"
    }
}

// MARK: - Tzinfo
struct Tzinfo: Codable {
    let name, abbr: String?
    let dst: Bool?
    let offset: Double?
}

// MARK: - Yesterday
struct Yesterday: Codable {
    let temp: Double?
}


