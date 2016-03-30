//
//  ExpenseTableViewController.swift
//  EndProject
//
//  Created by Alexis Von Doom on 29/03/16.
//  Copyright © 2016 Alexis Von Doom. All rights reserved.
//

import UIKit

class ExpenseTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var expenses = [Expense]()
    
    
    
    
    func loadSampleExpense(){
        
        let photo1 = UIImage(named:"game1")
        let expense1 = Expense(title: "Game 1", amount: 45.00, rating: 3, photo: photo1, date: "15/10/2015")!
        
        let photo2 = UIImage(named:"game2")
        let expense2 = Expense(title: "Game 3", amount: 32.99, rating: 4, photo: photo2, date: "15/10/2015")!
        
        let photo3 = UIImage(named:"game3")
        let expense3 = Expense(title: "Game 3", amount: 19.99, rating: 4, photo: photo3, date: "15/10/2015")!
        
        let photo4 = UIImage(named:"game4")
        let expense4 = Expense(title: "Game 4", amount: 65.00, rating: 2, photo: photo4, date: "15/10/2015")!
        
        let photo5 = UIImage(named:"game6")
        let expense5 = Expense(title: "Game 5", amount: 45.00, rating: 3, photo: photo5, date: "15/10/2015")!
        expenses += [expense1, expense2, expense3, expense4, expense5]
        
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // allos the use of the editbutton provided by the navigationcontrolller
        navigationItem.leftBarButtonItem = editButtonItem()
        
        /*//load the hardcoded data
        loadSampleExpense() */
        
        if let savedExpenses = loadExpenses() {
            
            expenses += savedExpenses
        
        
        } else {
            
            //load the hardcoded data
            loadSampleExpense()
        
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return expenses.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIndentifier = "ExpenseCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIndentifier, forIndexPath: indexPath) as! ExpenseViewTableViewCell

        // gets the correct expense for the data source layout
        let expense = expenses[indexPath.row]
        
        var tmp:String;
        tmp = "\(expense.amount)"
        cell.txtTitleLabel.text = expense.title + " " + tmp
        cell.txtDateLabel.text = expense.date
        cell.imPhotoImage.image = expense.photo
        cell.ratingControl.rating = expense.rating

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            expenses.removeAtIndex(indexPath.row)
            
            saveExpenses()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowDetail"{
            
            let ExpenseDetailViewController = segue.destinationViewController as! ViewController
            
            if let selectedExpenseCell = sender as? ExpenseViewTableViewCell {
                
                let indexPath = tableView.indexPathForCell(selectedExpenseCell)!
                let selectedExpense = expenses[indexPath.row]
                ExpenseDetailViewController.expense = selectedExpense
            
            }
        
        }
        else if segue.identifier == "AddItem" {
            
            //log some stuff for check
            print("Adding new meal")
            
        
        }
        
    }
    
    
    @IBAction func unwindToExpenseList(sender: UIStoryboardSegue){
        
        // old code
        
       /* if let sourceViewController = sender.sourceViewController as? ViewController, expense = sourceViewController.expense {
            // add a new expense
            let newIndexPath = NSIndexPath(forRow: expenses.count, inSection: 0)
            expenses.append(expense)
            tableView.insertRowsAtIndexPaths([newIndexPath],withRowAnimation: .Bottom)
            
        }*/
        
        if let sourceViewController = sender.sourceViewController as? ViewController, expense = sourceViewController.expense {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                //update existing expense
                expenses[selectedIndexPath.row] = expense
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
  
            
            }
            else {
                
                //adding a new expense
                let newIndexPath = NSIndexPath(forItem: expenses.count, inSection: 0)
                expenses.append(expense)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            
            }
            saveExpenses()
        
        
        }
        
    }
    
    //MARK: NSCoding
    
    func saveExpenses(){
        
        let isSuccesfullSave = NSKeyedArchiver.archiveRootObject(expenses, toFile: Expense.ArchiveURL!.path!)
        
        if !isSuccesfullSave {
            
            print("Failed to save expenses......")
        
        }
       
    }
    
    func loadExpenses() -> [Expense]? {
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Expense.ArchiveURL!.path!) as? [Expense]
    
    }
    
    

}
