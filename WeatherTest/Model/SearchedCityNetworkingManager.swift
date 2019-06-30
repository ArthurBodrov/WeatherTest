//
//  SearchedCityNetworkingManager.swift
//  WeatherTest
//
//  Created by  Arthur Bodrov on 30/06/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SearchedCityNetworkingManager {
    
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
    
    func downloadForecastForSearchedCity(completed: @escaping () -> () ){
        Alamofire.request(URL_CITY()).responseJSON { (responce) in
            let result = responce.result
            result.ifSuccess {
                let json = JSON(result.value)
//                print(json)
                self._cityName = json["name"].stringValue
                let kalvinTemp = json["main"]["temp"].double
                let codeStatus = json["cod"]
                if codeStatus != "404" || codeStatus != "400" {
                    self._currentTemp = (kalvinTemp! - 273.15).rounded(toPlaces: 0)
                } else {
                    print("Error")
                }
            }
            
            result.ifFailure {
                print("Responce is failure")
            }
            completed()
        }
    }
    
}
