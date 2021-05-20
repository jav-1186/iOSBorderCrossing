//
//  ViewController.swift
//  jveit-finalAppiOSII
//
//  Created by Jeffrey Veit on 5/19/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // Hitting return resigns the keyboard
    @IBAction func keyboardReturn(_ sender: UITextField)
    {
        sender.resignFirstResponder()
    }
    
    
    @IBAction func backgroundTouch(_ sender: UIControl)
    {
        userEmail.resignFirstResponder()
    }
    
    
}

