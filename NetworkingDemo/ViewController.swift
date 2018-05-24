//
//  ViewController.swift
//  NetworkingDemo
//
//  Created by Mohamed Sobhi  Fouda on 5/21/18.
//  Copyright © 2018 Mohamed Sobhi Fouda. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON

class ViewController: UIViewController {
    
    // MARK: Variables
    var weather: Weather?

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBAction func getTempButtonTapped(_ sender: AnyObject) {
        
        if let city = cityNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) {
            if let encodedString = city.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                getWeatherData(urlString: "http://api.openweathermap.org/data/2.5/weather?q=\(encodedString)&appid=6c20f50475503fab68506043e715a59e")
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getWeatherData(urlString: "http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=6c20f50475503fab68506043e715a59e")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getWeatherData(urlString: String) {

        Alamofire.request(urlString)
            .validate()
            .responseJSON { response in
                if response.result.isSuccess {
                    if let weatherJSON = response.result.value {
                        let parsedData = JSON(weatherJSON)

                        let id = parsedData["id"].int
                        let cityName = parsedData["name"].string
                        let temperature = parsedData["main", "temp"].double
                        let description = parsedData["weather", 0, "description"].string

                        self.weather = Weather(id: id!, cityName: cityName!, temperature: temperature!, weatherDescription: description!)
                        self.setLabel()
                    }
                } else {
                    print(response.result.error.debugDescription)
                }
        }

    }

    func setLabel() {

        if let temp = self.weather?.temperature {
            if let desc = self.weather?.weatherDescription {
                temperatureLabel.text = "Temp: \(String(format: "%.1f", temp)) Desc: \(desc)"
            }
        }
        
    }
    

}

