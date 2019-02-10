//
//  CountryCell.swift
//  Countries
//
//  Created by Aniket K on 2/9/19.
//  Copyright © 2019 Aniket K. All rights reserved.
//

import UIKit
import SVGKit
protocol CountryCellDelegate {
    func saveForOfflineTapped(_ cell: CountryCell)
}

class CountryCell: UITableViewCell {
    
    var delegate: CountryCellDelegate?
    
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryImageView: SVGKFastImageView!    
    @IBOutlet weak var saveOfflineButton: UIButton!
    
    @IBAction func saveForOfflineTapped(_ sender: AnyObject) {
        delegate?.saveForOfflineTapped(self)
    }
    
    func populateData(countryInfo: Country) {
        countryNameLabel.text = countryInfo.name;
    }
}

