//
//  CurrentWeather.swift
//  WeatherTest
//
//  Created by  Arthur Bodrov on 28/06/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrentWeather {
    
    private var _cityName: String!
    private var _currentTemp: Double!

    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    

    
    func downloadCurrentWeather(completed: @escaping () -> ()){
        Alamofire.request(API_URL).responseJSON { (response) in
            let result = response.result
            let json = JSON(result.value)
//                        print(json)
            self._cityName = json["name"].stringValue
            let downloadedTemp = json["main"]["temp"].double
            self._currentTemp = (downloadedTemp! - 273.15).rounded(toPlaces: 0)
            completed()
        }
    }
}
