//
//  MainVCTableViewExtension.swift
//  WeatherTest
//
//  Created by  Arthur Bodrov on 28/06/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfForecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TVCell
        
        let forecastObject = arrayOfForecasts[indexPath.row]
        
//        print(arrayOfForecasts)
        
        cell.cofigureRow(name: forecastObject.city, temp: forecastObject.temp)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
