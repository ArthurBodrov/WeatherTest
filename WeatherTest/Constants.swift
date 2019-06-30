//
//  Constants.swift
//  WeatherTest
//
//  Created by  Arthur Bodrov on 29/06/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import Foundation

let API_KEY = "49115142670d56dbd9a5e737ca018e45"

let BASE_URL = "https://api.openweathermap.org/data/2.5/weather"

let API_URL = "\(BASE_URL)?lat=\(Location.sharedIntance.latitude!)&lon=\(Location.sharedIntance.longitude!)&appid=\(API_KEY)"


func URL_CITY() -> String {
 return "\(BASE_URL)?q=\(SearchedCity.sharedIntance.cityName!)&appid=\(API_KEY)"
}
