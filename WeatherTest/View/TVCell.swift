//
//  TVCell.swift
//  WeatherTest
//
//  Created by  Arthur Bodrov on 28/06/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import UIKit

class TVCell: UITableViewCell {

    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func cofigureRow(name: String, temp: Int){
        cityLabel.text = name
        tempLabel.text = "\(temp)˚"
    }
}
