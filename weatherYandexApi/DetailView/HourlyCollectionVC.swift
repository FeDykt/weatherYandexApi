//
//  CollectionViewController.swift
//  weatherYandexApi
//
//  Created by fedot on 16.12.2021.
//

import UIKit
import SnapKit

class HourlyCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    //CollectionView
    var collView:     UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 80)
        
        collView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collView.delegate   = self
        collView.dataSource = self
        collView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        collView.backgroundColor = #colorLiteral(red: 0.09713674337, green: 0.1021232381, blue: 0.1191481873, alpha: 1)
    
        view.addSubview(collView)
        collView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ViewController.hourWeather.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        weak var cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell
        let hour = ViewController.hourWeather[indexPath.row]
        cell?.confHour(model: hour)
        return cell!
    }

}
