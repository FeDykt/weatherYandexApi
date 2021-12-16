//
//  CollectionViewCell.swift
//  weatherApp
//
//  Created by fedot on 15.12.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "Cell"
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var dateHourly = String()
    var dateWeek   = String()
    let weather = Weather?.self
    
    static func nib() -> UINib {
           return UINib(nibName: "CollectionViewCell", bundle: nil)
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func convertDateHours(model: Hour) {
        let dateHour = NSDate(timeIntervalSince1970: TimeInterval(model.hourTs))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "HH:mm"
        let dateHourlyString = dayTimePeriodFormatter.string(from: dateHour as Date)
        self.dateHourly = dateHourlyString
    }
    
    func convertDateWeek(model: Forecast) {
        let dateWeek = NSDate(timeIntervalSince1970: TimeInterval(model.dateTs))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd/MM"
        let dateHourlyString = dayTimePeriodFormatter.string(from: dateWeek as Date)
        self.dateWeek = dateHourlyString
    }
    func checkHourIcon(model: Hour) {
        switch model.condition {
        case .overcast:
            self.iconImage.tintColor = .darkGray
            self.iconImage.image = UIImage(systemName: "cloud.heavyrain.fill") //overcast
        case .thunderstorm:
            self.iconImage.tintColor = .darkGray
            self.iconImage.image = UIImage(systemName: "cloud.heavyrain.fill") //thunderstorm
        case .drizzle:
            self.iconImage.tintColor = .darkGray
            self.iconImage.image = UIImage(systemName: "cloud.drizzle.fill") // drizzle
        case .rain:
            self.iconImage.tintColor = .gray
            self.iconImage.image = UIImage(systemName: "cloud.rain.fill") //rain
        case .snow:
            self.iconImage.tintColor = .white
            self.iconImage.image = UIImage(systemName: "cloud.snow.fill") //snow
        case .clear:
            self.iconImage.tintColor = .yellow
            self.iconImage.image = UIImage(systemName: "sun.max.fill") //clear
        default: break
        }
    }
    func checkWeekIcon(model: Forecast) {
        switch model.parts.day.condition {
        case .lightSnow:
            self.iconImage.tintColor = .white
            self.iconImage.image = UIImage(systemName: "cloud.snow.fill") //snow
        case .overcast:
            self.iconImage.tintColor = .darkGray
            self.iconImage.image = UIImage(systemName: "cloud.heavyrain.fill") //overcast
        case .snow:
            self.iconImage.tintColor = .white
            self.iconImage.image = UIImage(systemName: "cloud.snow.fill") //snow
        case .wetSnow:
            self.iconImage.tintColor = .white
            self.iconImage.image = UIImage(systemName: "cloud.snow.fill") //snow
        }
    }
    
    func confHour(model: Hour) {
        convertDateHours(model: model)
        checkHourIcon(model: model)
        self.timeLabel.text = self.dateHourly
        self.days.text = String(model.temp)
    }
    
    func confWeek(forecast: Forecast) {
        convertDateWeek(model: forecast)
        checkWeekIcon(model: forecast)
        guard let temp = forecast.parts.dayShort.temp else { return }
        self.days.text = "\(temp)"
        self.timeLabel.text = self.dateWeek
    }

}

