//
//  WeatherModel.swift
//  weatherYandexApi
//
//  Created by fedot on 16.12.2021.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let nowDt: String
    let info: Info
    let geoObject: GeoObject
    let yesterday: Yesterday
    let fact: Fact
    let forecasts: [Forecast]

    enum CodingKeys: String, CodingKey {
        case nowDt = "now_dt"
        case info
        case geoObject = "geo_object"
        case yesterday, fact
        case forecasts = "forecasts"
    }
}

// MARK: - Info
struct Info: Codable {
    let lat, lon: Double

    enum CodingKeys: String, CodingKey {
        case lat, lon
    }
}

// MARK: - Fact
struct Fact: Codable {
    let temp: Int
    let condition: FactCondition

    enum CodingKeys: String, CodingKey {
        case temp, condition
    }
}

enum FactCondition: String, Codable {
    case clear = "clear" // ясно.
    case partlyCloudy = "partly-cloudy" // малооблачно.
    case cloudy = "cloudy" // облачно с прояснениями.
    case overcast = "overcast" // пасмурно.
    case drizzle = "drizzle" // морось.
    case lightRain = "light-rain" // небольшой дождь.
    case rain = "rain" // дождь.
    case moderateRain = "moderate-rain" // умеренно сильный дождь.
    case heavyRain = "heavy-rain" // сильный дождь.
    case continuousHeavyRain = "continuous-heavy-rain" // длительный сильный дождь.
    case showers = "showers" // ливень.
    case wetSnow = "wet-snow" // дождь со снегом.
    case lightSnow = "light-snow" // небольшой снег.
    case snow = "snow" // снег.
    case snowShowers = "snow-showers" // снегопад.
    case hail = "hail" // град.
    case thunderstorm = "thunderstorm" // гроза.
    case thunderstormWithRain = "thunderstorm-with-rain" // дождь с грозой.
    case thunderstormWithHail = "thunderstorm-with-hail" // гроза с градом.
}

// MARK: - Forecast
struct Forecast: Codable {
    let date: String
    let dateTs: Int
    let week: Int
    let parts: Parts
    let hours: [Hour]

    enum CodingKeys: String, CodingKey {
        case date, week
        case dateTs = "date_ts"
        case parts = "parts"
        case hours
    }
}

// MARK: - Hour
struct Hour: Codable {
    let hour: String
    let hourTs: Double
    let temp: Int
    let condition: FactCondition

    enum CodingKeys: String, CodingKey {
        case hour
        case hourTs = "hour_ts"
        case temp
        case condition
    }
}

// MARK: - Parts
struct Parts: Codable {
    let day, morning: Day
    let evening, dayShort: Day

    enum CodingKeys: String, CodingKey {
        case day, morning, evening
        case dayShort = "day_short"
    }
}

// MARK: - Day
struct Day: Codable {
    let temp: Int?
    let condition: DayCondition
    
    enum CodingKeys: String, CodingKey {
        case temp, condition
    }
}

enum DayCondition: String, Codable {
    case lightSnow = "light-snow"
    case overcast = "overcast"
    case snow = "snow"
    case wetSnow = "wet-snow"
}

// MARK: - GeoObject
struct GeoObject: Codable {
    let locality: Country
}

// MARK: - Country
struct Country: Codable {
    let id: Int
    let name: String
}


// MARK: - Yesterday
struct Yesterday: Codable {
    let temp: Int
}
