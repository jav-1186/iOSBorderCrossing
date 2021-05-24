//
//  shopTableViewController.swift
//  jveit-finalAppiOSII
//
//  Created by Jeffrey Veit on 5/24/21.
//

import UIKit

class shopTableViewController: UITableViewController {

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
        return shops.count
    }

    // Populates the table with the data from the tacos class
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let shop = shops[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: shop.type.rawValue, for: indexPath)
        
        // Configure the cell...
        
        cell.textLabel?.text = shop.name
        cell.detailTextLabel?.text = shop.shortDescription
        
        return cell
    }
    
    // Method to display data when accessory is selected
    override func tableView(_ tableView: UITableView,
        accessoryButtonTappedForRowWith indexPath: IndexPath)
    {
        let shop = shops[indexPath.row]
        let title = shop.name
        let message = shop.longDescription
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
        
        if let shopdetailViewController = segue.destination as? shopdetailViewController {
           if let indexPath = self.tableView.indexPathForSelectedRow {
               shopdetailViewController.shop = shops[indexPath.row]
           }
       }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
