//
//  FruitListViewController.swift
//  abel6000_a4
//
//  Created by Adriana Abella on 2020-02-29.
//  Copyright © 2020 wlu. All rights reserved.
//

import Foundation
import UIKit

class FruitListViewController: UITableViewController{
    
    var sharedFruitCollection : FruitCollection?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sharedFruitCollection = SharingFruitCollection.sharedFruitCollection.fruitCollection
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = SharingFruitCollection()
        SharingFruitCollection.sharedFruitCollection.fruitCollection = FruitCollection()
        SharingFruitCollection.sharedFruitCollection.loadFruitCollection()
        sharedFruitCollection = SharingFruitCollection.sharedFruitCollection.fruitCollection
    }
    
    @IBAction func unwindToTableView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddTabViewController
        {
            let fruit = sourceViewController.getFruit()
           
            // Add a new fruit
           let newIndexPath = IndexPath(row: sharedFruitCollection!.getCount(), section: 0)
            
           sharedFruitCollection?.addFruit(fruit: fruit)
           tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedFruitCollection!.collection.count // tells the table view that the data comes from tableData
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let fruit = sharedFruitCollection?.getFruitAtIndex(index: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        cell.setFruit(fruit: fruit!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //Delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            //Delete
            self.sharedFruitCollection?.collection.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])

        return swipeConfiguration
    } // trailingSwipeActions
        
        //MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        if (segue.destination is DetailViewController) {
            guard let selectedFruitCell = sender as? CustomTableViewCell
                else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedFruitCell) else {
                fatalError("Selected cell will not display in table")
            }
            sharedFruitCollection?.setCurrentIndex(to: indexPath.row)
        } //
            
    }// prepare for segue
    
}
    
    
