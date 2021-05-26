//
//  culturaldetailViewController.swift
//  jveit-finalAppiOSII
//
//  Created by Jeffrey Veit on 5/24/21.
//

import UIKit

class culturaldetailViewController: UIViewController {

    var cul: Cultural?
    @IBOutlet weak var culName: UILabel!
    @IBOutlet weak var culPic: UIImageView!
    @IBOutlet weak var culDetail: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    // Method to populate this view controller with tacos class information
    override func viewWillAppear(_ animated: Bool)
    {
        if let t = cul {
            culPic.image = UIImage(named:t.name)
            culName.text = t.name
            culDetail.text = t.longDescription
        }
    }

}
