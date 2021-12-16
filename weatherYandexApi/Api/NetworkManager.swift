//
//  NetworkManager.swift
//  weatherYandexApi
//
//  Created by fedot on 16.12.2021.
//

import Alamofire

struct NetworkManager {
    let headers: HTTPHeaders = [
        "X-Yandex-API-Key": "938e1f72-f28f-4a63-8b09-ea2ab8fbb16f",
        "Accept": "application/json"
    ]
    let url = "https://api.weather.yandex.ru/v2/forecast?lat=59.927925&lon=30.266809&lang=en_US&limit=7&hours=true"

    func getRequest(completion: @escaping (Weather) -> Void) {
        AF.request(url, headers: headers).validate().responseDecodable(of: Weather.self) { result in
            guard let value = result.value else { return }
            completion(value)
        }
    }

}
