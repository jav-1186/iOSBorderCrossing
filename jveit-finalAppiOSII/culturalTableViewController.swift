//
//  culturalTableViewController.swift
//  jveit-finalAppiOSII
//
//  Created by Jeffrey Veit on 5/24/21.
//

import UIKit

class culturalTableViewController: UITableViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    // Only one section for this program
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // Returns number of items in the array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return cult.count
    }

    // Populates the table with the data from the tacos class
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cul = cult[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cul.type.rawValue, for: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = cul.name
        cell.detailTextLabel?.text = cul.shortDescription
        
        return cell
    }
    
    // Method to display data when accessory is selected
    override func tableView(_ tableView: UITableView,
        accessoryButtonTappedForRowWith indexPath: IndexPath)
    {
        let cul = cult[indexPath.row]
        let title = cul.name
        let message = cul.longDescription
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Method to send data to the detail view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let culturaldetailViewController = segue.destination as? culturaldetailViewController {
           if let indexPath = self.tableView.indexPathForSelectedRow {
               culturaldetailViewController.cul = cult[indexPath.row]
           }
       }
    }
    
}
