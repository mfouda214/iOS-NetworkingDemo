//
//  ViewController.swift
//  NetworkingDemo
//
//  Created by Mohamed Sobhi  Fouda on 5/21/18.
//  Copyright © 2018 Mohamed Sobhi Fouda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBAction func getTempButtonTapped(_ sender: AnyObject) {
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
        let url = URL(string: urlString)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                self.setLabel(weatherData: data!)
            })
        }
        
        task.resume()
        
    }
    
    func setLabel(weatherData: Data) {
        do {
            let json = try JSONSerialization.jsonObject(with: weatherData, options: []) as! Dictionary<String, AnyObject>
            
            if let main = json["main"] as? Dictionary<String, AnyObject> {
                if let temp = main["temp"] as? Double {
                    temperatureLabel.text = String(format: "%.1f", temp)
                }
            }
        } catch {
            print("Error fetching data")
        }
    }
    

}

