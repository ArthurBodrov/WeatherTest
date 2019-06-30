//
//  DetailViewController.swift
//  WeatherTest
//
//  Created by  Arthur Bodrov on 30/06/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    var forecastCity: Forecast?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI(){
        cityLabel.text = forecastCity?.city
        tempLabel.text = "\((forecastCity?.temp) ?? 0)˚"
    }

    
}
