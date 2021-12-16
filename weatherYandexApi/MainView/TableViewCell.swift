//
//  TableViewCell.swift
//  weatherYandexApi
//
//  Created by fedot on 13.12.2021.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    static let identifier = "Cell"
    let nameCity = UILabel()
    let status   = UILabel()
    let degree   = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.addSubview(nameCity)
        contentView.addSubview(status)
        contentView.addSubview(degree)
        
        makeConstraints()
    }
    func makeConstraints() {
        nameCity.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
        }
        status.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(degree.snp.left).inset(-10)
        }
        degree.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
    }
    
    func configure(model: Weather) {
        self.nameCity.text = model.name
        self.status.text = "\(Int(model.main.tempMax)) C"
        self.degree.text = "\(Int(model.main.temp)) C"
    }

}
