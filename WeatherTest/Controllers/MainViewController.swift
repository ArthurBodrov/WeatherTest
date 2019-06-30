//
//  ViewController.swift
//  WeatherTest
//
//  Created by  Arthur Bodrov on 28/06/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    // IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    
    // IBAction
    @IBAction func addButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Add new city", message: "Please, write city here", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Write city here"
            
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [weak alertController] _ in
            if let textField = alertController?.textFields?.first {
                
                SearchedCity.sharedIntance.cityName = (textField.text?.localizedCapitalized)!
                print((textField.text?.localizedCapitalized)!)
                
                
                DispatchQueue.main.async {
                    self.searchedCityNetworkingManager.downloadForecastForSearchedCity {
                        let searchedCityObject: Forecast = Forecast(city: self.searchedCityNetworkingManager.cityName, temp: Int(self.searchedCityNetworkingManager.currentTemp))
                        self.arrayOfForecasts.append(searchedCityObject)
                        
                        self.tableView.reloadData()
                        print(self.arrayOfForecasts)
                    }
                    
                }
                
//                print(API_URL_CITY)
                print(SearchedCity.sharedIntance)
            }
        }
        
        alertController.addAction(confirmAction)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        self.present(alertController, animated: true)
        
        
    
    }
    
    // arrayOfObject
    var arrayOfForecasts: [Forecast] = []
    
    // Constains
    let locationManager = CLLocationManager()
    
    // Variables
    var currentLocation: CLLocation!
    var currentWeather: CurrentWeather!
    var searchedCityNetworkingManager: SearchedCityNetworkingManager!
    
    // MARK: - View functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
        callDelegates()
        currentWeather = CurrentWeather()
        searchedCityNetworkingManager = SearchedCityNetworkingManager()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        locationAuthCheck()
    }
    
    //MARK: - Location
    
    func callDelegates(){
        // Delegate locationManager to this class
        locationManager.delegate = self
    }
    
    func setupLocation(){
        // Set the best accuracy location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Request a permission
        locationManager.requestWhenInUseAuthorization()
        // Update data if location changes
        locationManager.startMonitoringSignificantLocationChanges()
        
    }
    
    func locationAuthCheck(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // Get the location from device
            guard locationManager.location != nil else { return print("Location is nil, you need configure location, go to Simulator -> Top menu -> 'Debug' -> 'Location'") }
            
            currentLocation = locationManager.location
            
//            print(currentLocation.coordinate.latitude)
//            print(currentLocation.coordinate.longitude)
            
            // Set coordinates to class "Location" and then pass the Location's coordinate to our API
            Location.sharedIntance.longitude = currentLocation.coordinate.longitude
            Location.sharedIntance.latitude = currentLocation.coordinate.latitude
            
            // GCD rule, update UI in main queue
            DispatchQueue.main.async {
                // Download the API Data
                self.currentWeather.downloadCurrentWeather {
                    //
                    let currentCityWeather: Forecast = Forecast(city: self.currentWeather.cityName, temp: Int(self.currentWeather.currentTemp))
                    if self.arrayOfForecasts.count == 0 {
                                self.arrayOfForecasts.append(currentCityWeather)
                                self.tableView.reloadData()
                            
                        }
                
                    print(self.arrayOfForecasts)
            }
        }
        } else {
            // If stasus not "authorizedWhenInUse", ask a permission, and recursive call self function
            locationManager.requestWhenInUseAuthorization()
            locationAuthCheck()
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let detailVC = segue.destination as! DetailViewController
                detailVC.forecastCity = arrayOfForecasts[indexPath.row]
            }
        }
    }
}

