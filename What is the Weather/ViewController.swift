//
//  ViewController.swift
//  What is the Weather
//
//  Created by Khaled Rahman Ayon on 10/05/16.
//  Copyright © 2016 iosApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var enterCityField: UITextField!
    
    @IBOutlet var resultField: UILabel!
    
    @IBAction func searchCity(sender: AnyObject) {
        
        var wasSuccessfull = false
        
        let attemptedUrl = NSURL(string: "http://www.weather-forecast.com/locations/" + enterCityField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if let url = attemptedUrl {
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                let webSiteArray = webContent?.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if webSiteArray!.count > 1 {
                   
                    let weatherArray = webSiteArray![1].componentsSeparatedByString("</span>")
                    
                    if weatherArray.count > 1 {
                        
                        var wasSuccessfull = true
                        
                        let weatherSummery = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            self.resultField.text = weatherSummery
                            
                        })
                        
                    }
                }
                
                
            }
            
            if wasSuccessfull == false {
                
                self.resultField.text = "Fuck youu motherfucker!!"
            }
            
            
        }
        task.resume()
        
        }else {
            
            self.resultField.text = "Well I dont know !!"
        
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

