//
//  currencyViewController.swift
//  jveit-finalAppiOSII
//
//  Created by Jeffrey Veit on 5/19/21.
//

import UIKit

class currencyViewController: UIViewController
{
    @IBOutlet weak var exR: UILabel!
    @IBOutlet weak var dollarEnt: UITextField!
    @IBOutlet weak var pesoEnt: UITextField!
    @IBOutlet weak var pesoConvert: UILabel!
    @IBOutlet weak var dollarConvert: UILabel!
    
    let baseURL = "https://openexchangerates.org/api/latest.json?app_id=0f82e3a7c5fe4ce185d85093c7768a39"
    
    var feed = ""
    let appKey = "0f82e3a7c5fe4ce185d85093c7768a39"
    var rateD: Double = 0.0
    
    // Class to hold JSON data for trains
    class currency
    {
        var rate: String = ""
    }
    
    // Error catching
    enum SerializationError: Error
    {
        case missing(String)
        case invalid(String, Any)
    }
    
    var dataAvailable = false
    var records: [currency] = []
    var timer = Timer()
    
    // Dynamically sets URL from segue and starts timer so data is refreshed in background
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        feed = baseURL
        loadData()
        
    }
    
    @IBAction func calculateRate(_ sender: UIButton)
    {
        loadData()
        
        if let dlr = Double(dollarEnt.text!)
        {
            var dlr2peso = dlr * rateD
            let doubleStr = String(format: "%.2f", dlr2peso)
            pesoConvert.text = "= " + doubleStr + " pesos"
        }
        
        if let pso = Double(pesoEnt.text!)
        {
            var pso2dlr = pso/rateD
            let doubleStr2 = String(format: "%.2f", pso2dlr)
            dollarConvert.text = "= " + doubleStr2 + " dollars"
        }
        
        
        
    }
    
    @IBAction func backgroundTouch(_ sender: UIControl)
    {
        dollarEnt.resignFirstResponder()
        pesoEnt.resignFirstResponder()
    }
    
    @IBAction func keyboardReturn(_ sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    
    @IBAction func keyboardReturn2(_ sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    
    
    
    // Function that starts URL session and makes API call. Parses JSON
func loadData()
    {
        guard let feedURL = URL(string: feed) else
        {
            return
        }
        
        let request = URLRequest(url: feedURL)
        let session = URLSession.shared
        
        session.dataTask(with: request)
        { data, response, error in
            guard error == nil else
            {
                print(error!.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                if let json =
                    try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                   
                    print(json)
                    print("ghere")
                    
                    guard let entries = json["rates"] as? [String:Any] else
                    {
                        throw SerializationError.missing("rates")
                    }
                    
                    guard let test = entries["MXN"] else
                    {
                        throw SerializationError.missing("MXN")
                    }
                    print(test)
                    self.rateD = test as! Double
                    
                    //print(entries)
                    print("wtf")
                                
                    // Main thread
                    DispatchQueue.main.async
                        {
                            self.exR.text = "Exchange Rate: " + "\(test)"
                        }
                    
                }
            } catch SerializationError.missing(let msg) {
                print("Missing \(msg)")
            } catch SerializationError.invalid(let msg, let data) {
                print("Invalid \(msg): \(data)")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    // Helper function to determine arrival time in minutes between date objects from JSON
    func getMinutes(start: String, end: String) -> Int
       {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let startD = dateFormatter.date(from:start)!
            let endD = dateFormatter.date(from:end)!

            let diff = Int(endD.timeIntervalSince1970 - startD.timeIntervalSince1970)

            let hours = diff / 3600
            let minutes = (diff - hours * 3600) / 60
            return minutes
       }

}
