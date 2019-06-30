//
//  MainVCLocationExtension.swift
//  WeatherTest
//
//  Created by  Arthur Bodrov on 28/06/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import UIKit
import CoreLocation

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = manager.location
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
}
