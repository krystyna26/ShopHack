//
//  StoreListVC.swift
//  ShopShopShop
//
//  Created by Krystyna Swider on 11/15/17.
//  Copyright © 2017 Krystyna Swider. All rights reserved.
//

import UIKit
import CoreLocation

class StoreListVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var shoppingList:[String] = ["Pineapple", "Apple"]
    var storeList:[NSDictionary] = []
    
    let locationManager = CLLocationManager()
    var location: CLLocation?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let authStatus = CLLocationManager.authorizationStatus()
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        if authStatus == .denied || authStatus == .restricted {
            // add any alert or inform the user to to enable location services
        }
        startLocationManager()
    }
    
    func getStoresByLocation() {
        if let coordinate = location?.coordinate {
            stopLocationManager()
            let long = coordinate.longitude
            let lat = coordinate.latitude
            let url = URL(string: "http://api.walmartlabs.com/v1/stores?apiKey=ybap52xu892pcbpu3a898kcd&lon=\(long)&lat=\(lat)&format=json")
            let session = URLSession.shared
            // create a "data task" to make the request and run completion handler
            let task = session.dataTask(with: url!, completionHandler: {
                // see: Swift closure expression syntax
                data, response, error in
                // data -> JSON data, response -> headers and other meta-information, error-> if one occurred
                // "do-try-catch" blocks execute a try statement and then use the catch statement for errors
                do {
                    // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        print(jsonResult)
                    }
                } catch {
                    print(error)
                }
            })
            // execute the task and then wait for the response
            // to run the completion handler. This is async!
            task.resume()
        }
    }
    
    
    
}

extension StoreListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath) as! StoreCell
        
        return cell
    }
    
}

extension StoreListVC:  CLLocationManagerDelegate{
    func startLocationManager() {
        // always good habit to check if locationServicesEnabled
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    func stopLocationManager() {
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // print the error to see what went wrong
        print("didFailwithError\(error)")
        // stop location manager if failed
        stopLocationManager()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // if you need to get latest data you can get locations.last to check it if the device has been moved
        let latestLocation = locations.last!
        
        // here check if no need to continue just return still in the same place
        if latestLocation.horizontalAccuracy < 0 {
            return
        }
        // if it location is nil or it has been moved
        if location == nil || location!.horizontalAccuracy > latestLocation.horizontalAccuracy {
            location = latestLocation
            // stop location manager
            stopLocationManager()
        }
    }
}
