//
//  CountryDetailCell.swift
//  Countries
//
//  Created by 703177707 on 2/11/19.
//  Copyright © 2019 Aniket K. All rights reserved.
//

import UIKit

class CountryDetailCell: UITableViewCell {
    
    @IBOutlet weak var fieldName: UILabel!
    @IBOutlet weak var fieldValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
