//
//  DetailsViewController.swift
//  weatherYandexApi
//
//  Created by fedot on 13.12.2021.
//

import UIKit
import SnapKit

class DetailsViewController: UIViewController {
    let apiManager = ApiManager()
    var weather: [Weather] = []
    let backgroundImage   = UIImageView()
    var backButton:         UIImageView {
        let backButton = UIImageView()
        backButton.image = UIImage(named: "back.png")
        backButton.tintColor = .white
        return backButton
    }
    let stackViewVertical = UIStackView()
    var labelTemp         = UILabel()
    var labelCondition    = UILabel()
    var labelNameCity     = UILabel()
    let segmentController = UISegmentedControl()
    var weatherIconId     = Int()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingBackButton()
        
        stackViewVertical.axis = .vertical
        stackViewVertical.contentMode = .center
        
        view.addSubview(backgroundImage)
        view.addSubview(stackViewVertical)
        stackViewVertical.addArrangedSubview(labelTemp)
        stackViewVertical.addArrangedSubview(labelCondition)
        view.addSubview(labelNameCity)
        settingContraints()
        settingLabels()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.getRequest(city: "London") { [weak self] result in
            guard let self = self else { return }
            self.weather = [result]
            self.weather.forEach { weather in
                let _: [()] = weather.weather.map { element in
                    self.labelCondition.text = element.weatherDescription.uppercased()
                }
                self.labelTemp.text = String(Int(weather.main.temp))
                self.labelNameCity.text = String(weather.name)
            }
        }
        

    }
    private func settingLabels() {
        switch weatherIconId {
        case 200...232:
            backgroundImage.image = UIImage(named: "rain.png") //thunderstorm
        case 300...321:
            backgroundImage.image = UIImage(named: "rain.png") // drizzle
        case 500...531:
            backgroundImage.image = UIImage(named: "rain.png") //rain
        case 600...622:
            backgroundImage.image = UIImage(named: "snow.png") //show
        case 701...781:
            backgroundImage.image = UIImage(named: "cloud.png") //atmosphere
        case 800:
            backgroundImage.image = UIImage(named: "sunny.png") //clear
        case 801...804:
            backgroundImage.image = UIImage(named: "cloud.png") //clouds
        default:
            backgroundImage.image = UIImage(named: "rain.png")
        }
        labelTemp.textAlignment = .center
        labelTemp.textColor = .white
        labelTemp.font = UIFont(name: "Instruction", size: 126)
        
        labelCondition.textAlignment = .center
        labelCondition.textColor = .white
        labelCondition.font = UIFont(name: "Instruction", size: 26)
        
        labelNameCity.textAlignment = .center
        labelNameCity.textColor = .white
        labelNameCity.font = UIFont(name: "Instruction", size: 26)
    }
    
    private func settingBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButton.image, style: .plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func settingContraints() {
        backgroundImage.snp.makeConstraints { make in
            make.right.top.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        stackViewVertical.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        labelNameCity.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackViewVertical.snp.bottom).offset(30)
        }
    }

}
