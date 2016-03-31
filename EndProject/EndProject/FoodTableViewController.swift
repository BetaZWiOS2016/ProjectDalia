//
//  FoodTableViewController.swift
//  EndProject
//
//  Created by Alexis Von Doom on 31/03/16.
//  Copyright © 2016 Alexis Von Doom. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var foodExpenses = [Expense]()
    
    @IBOutlet weak var btnReturnButton: UIBarButtonItem!
    
    func loadSampleFoodExpense(){
        
        let photo1 = UIImage(named:"icon1")
        let foodExpense1 = Expense(title: "Grocery 1", amount: 123.56, rating: 1, photo: photo1, date: "5/02/2016")!
  
        let foodExpense2 = Expense(title: "Grocery 2", amount: 99.56, rating: 1, photo: photo1, date: "5/02/2016")!
        
        let foodExpense3 = Expense(title: "Grocery 3", amount: 45.56, rating: 1, photo: photo1, date: "5/02/2016")!
        
        foodExpenses += [foodExpense1, foodExpense2, foodExpense3]
    
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // allos the use of the editbutton provided by the navigationcontrolller
        navigationItem.leftBarButtonItem = editButtonItem()
        
        /*//load the hardcoded data
        loadSampleExpense() */
        
        if let savedExpenses = loadExpenses() {
            
            foodExpenses += savedExpenses
            
            
        } else {
            
            //load the hardcoded data
            loadSampleFoodExpense()
            
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
        return foodExpenses.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIndentifier = "ExpenseCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIndentifier, forIndexPath: indexPath) as! ExpenseViewTableViewCell
        
        // gets the correct expense for the data source layout
        let expense = foodExpenses[indexPath.row]
        
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
            
            foodExpenses.removeAtIndex(indexPath.row)
            
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
                let selectedExpense = foodExpenses[indexPath.row]
                ExpenseDetailViewController.expense = selectedExpense
                
            }
            
        }
        else if segue.identifier == "AddItem" {
            
            //log some stuff for check see if it works
            print("Adding new expense")
            
            
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
                foodExpenses[selectedIndexPath.row] = expense
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                
                
            }
            else {
                
                //adding a new expense
                let newIndexPath = NSIndexPath(forItem: foodExpenses.count, inSection: 0)
                foodExpenses.append(expense)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                
            }
            saveExpenses()
            
            
        }
        
    }
    
    
    @IBAction func returnAction(sender: UIBarItem){
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    //MARK: NSCoding
    
    func saveExpenses(){
        
        let isSuccesfullSave = NSKeyedArchiver.archiveRootObject(foodExpenses, toFile: Expense.ArchiveURLFood!.path!)
        
        if !isSuccesfullSave {
            
            print("Failed to save expenses......")
            
        }
        
    }
    
    func loadExpenses() -> [Expense]? {
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(Expense.ArchiveURLFood!.path!) as? [Expense]
        
    }
    
    
    
}