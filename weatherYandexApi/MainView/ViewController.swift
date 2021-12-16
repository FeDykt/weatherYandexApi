//
//  ViewController.swift
//  weatherApp
//
//  Created by fedot on 14.12.2021.
//

import UIKit
import CoreLocation
import SnapKit


class ViewController: UIViewController {
    //ChildVC
    var collectionViewHourly    = HourlyCollectionVC()
    var collectionViewWeek      = WeekCollectionVC()
    //Network
    let networkManager    = NetworkManager()
    var currentWeather:                [Weather] = []
    static var forecastWeather:        [Forecast] = []
    static var hourWeather:            [Hour] = []
    //Location
    let locationManager   = CLLocationManager()
    var locationLat       = Double()
    var locationLong      = Double()
    
    //Cackground image
    var weatherIconId     = Int()
    let backgroundImage   = UIImageView()
    var backButton:         UIImageView {
        let backButton    = UIImageView()
        backButton.image  = UIImage(named: "back.png")
        backButton.tintColor = .white
        return backButton
    }
    
    //StackView
    let stackViewVertical = UIStackView()
    var labelTemp         = UILabel()
    var labelCondition    = UILabel()
    var labelNameCity     = UILabel()
    
    //SegmentedControl
    var segmentedControl  = UISegmentedControl()
    let segmentArray      = ["TODAY","TOMMOROW","NEXT 7 DAYS"]
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settingStackViewLabels()
//        settingBackButton()
        settingSegment()
        
        //MARK: StackViewSetting
        stackViewVertical.axis = .vertical
        stackViewVertical.contentMode = .center
        
        //MARK: View addsubviews
        view.addSubview(backgroundImage)
        view.addSubview(stackViewVertical)
        stackViewVertical.addArrangedSubview(labelTemp)
        stackViewVertical.addArrangedSubview(labelCondition)
        view.addSubview(labelNameCity)
        view.addSubview(segmentedControl)
        
        addChildWeekVC()
        addChildHourlyVC()
        collectionViewWeek.collView?.isHidden = true
        //MARK: Setting constrains
        settingContraints()
        
   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getRequest { [weak self] result in
            guard let self = self else { return }
            self.currentWeather = [result]
            self.currentWeather.forEach { result in
                self.labelTemp.text = "\(result.fact.temp)"
                self.labelCondition.text = "\(result.fact.condition)"
                self.labelNameCity.text = "\(result.geoObject.locality.name)"
                
                switch result.fact.condition {
                case .overcast:
                    self.backgroundImage.image = UIImage(named: "cloud.png") //rain
                case .thunderstorm:
                    self.backgroundImage.image = UIImage(named: "rain.png") //thunderstorm
                case .drizzle:
                    self.backgroundImage.image = UIImage(named: "rain.png") // drizzle
                case .rain:
                    self.backgroundImage.image = UIImage(named: "rain.png") //rain
                case .snow:
                    self.backgroundImage.image = UIImage(named: "snow.png") //snow
                case .clear:
                    self.backgroundImage.image = UIImage(named: "sunny.png") //clear
                default: break
                }
            }
            DispatchQueue.main.async {
                ViewController.forecastWeather = result.forecasts
                ViewController.hourWeather = result.forecasts.first!.hours
                self.collectionViewHourly.collView.reloadData()
                self.collectionViewWeek.collView.reloadData()
            }
            
        }

    }
    
    private func settingSegment() {
        //MARK: SegmentedControl
        segmentedControl = UISegmentedControl(items: segmentArray)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(segmentSelected), for: .valueChanged)
        segmentedControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        segmentedControl.setBackgroundImage(UIImage(named: "border.png"), for: .selected, barMetrics: .default)
    }
    
    private func addChildHourlyVC() {
        addChild(collectionViewHourly)
        view.addSubview(collectionViewHourly.view)
        collectionViewHourly.didMove(toParent: self)
        childViewConstraint(view: collectionViewHourly)
    }
    
    private func addChildWeekVC() {
        addChild(collectionViewWeek)
        view.addSubview(collectionViewWeek.view)
        collectionViewWeek.didMove(toParent: self)
        childViewConstraint(view: collectionViewWeek)
    }
    
    @objc func segmentSelected(target: UISegmentedControl) {
        switch target.selectedSegmentIndex {
        case 0:
            addChildHourlyVC()
            collectionViewHourly.collView.isHidden = false
            collectionViewWeek.collView.isHidden = true
        case 1:
            addChildHourlyVC()
            collectionViewHourly.collView.isHidden = false
            collectionViewWeek.collView.isHidden = true
        case 2:
            addChildWeekVC()
            collectionViewHourly.collView.isHidden = true
            collectionViewWeek.collView.isHidden = false
        default: break
        }
    }
    
    private func settingLabelsInstrucionFont(_ label: UILabel, text: String?, size: CGFloat?) {
        label.text = text?.uppercased()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Instruction", size: size!)
    }
    
    private func settingLabelsAvenirFont(_ label: UILabel, text: String?, size: CGFloat?) {
        label.text = text?.uppercased()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next", size: size!)
    }
    
    private func settingStackViewLabels() {
        settingLabelsInstrucionFont(labelTemp, text: nil, size: 146)
        settingLabelsAvenirFont(labelCondition, text: nil, size: 46)
        settingLabelsAvenirFont(labelNameCity, text: "Загружаем данные",size: 26)
    }
    
    private func settingBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButton.image, style: .plain, target: self, action: #selector(modal))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc func modal() {
        let nextVC = ViewController()
        nextVC.modalPresentationStyle = .pageSheet
        if let sheet = nextVC.sheetPresentationController {
            sheet.detents = [.medium()]

        }
        present(nextVC, animated: true, completion: nil)
    }
    
    private func settingContraints() {
        backgroundImage.snp.makeConstraints { make in
            make.right.top.equalTo(self.view).inset(-20)
        }
        stackViewVertical.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        labelNameCity.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(stackViewVertical.snp.bottom).offset(10)
        }
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(labelNameCity.snp.bottom).offset(30)
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(10)
        }
    }
    func childViewConstraint(view: UIViewController) {
        view.view.snp.makeConstraints { make in
            make.width.equalTo(self.view.safeAreaLayoutGuide.snp.width)
            make.height.equalTo(100)
            make.left.right.equalToSuperview()
            make.top.equalTo(segmentedControl.snp.bottom).offset(10)
        }
    }

}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.locationLong = location.coordinate.longitude
            self.locationLat = location.coordinate.latitude
            locationManager.stopUpdatingLocation()
        }
    }
}

