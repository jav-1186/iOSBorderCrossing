//
//  detailViewController.swift
//  jveit-finalAppiOSII
//
//  Created by Jeffrey Veit on 5/24/21.
//

import UIKit

class detailViewController: UIViewController {

    @IBOutlet weak var tacoName: UILabel!
    @IBOutlet weak var tacoPic: UIImageView!
    @IBOutlet weak var tacoDetail: UILabel!
    var taco: Tacos?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Method to populate this view controller with tacos class information
    override func viewWillAppear(_ animated: Bool)
    {
        if let t = taco {
            tacoPic.image = UIImage(named:t.name)
            tacoName.text = t.name
            tacoDetail.text = t.longDescription
        }
    }
    

}
