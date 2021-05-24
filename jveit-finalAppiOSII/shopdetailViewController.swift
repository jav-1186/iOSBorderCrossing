//
//  shopdetailViewController.swift
//  jveit-finalAppiOSII
//
//  Created by Jeffrey Veit on 5/24/21.
//

import UIKit

class shopdetailViewController: UIViewController {

    var shop: Shopping?
    
    @IBOutlet weak var shopName: UILabel!
    
    @IBOutlet weak var shopPic: UIImageView!
    
    @IBOutlet weak var shopDetail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Method to populate this view controller with tacos class information
    override func viewWillAppear(_ animated: Bool)
    {
        if let t = shop {
            shopPic.image = UIImage(named:t.name)
            shopName.text = t.name
            shopDetail.text = t.longDescription
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
