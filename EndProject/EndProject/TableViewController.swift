//
//  TableViewController.swift
//  EndProject
//
//  Created by Alexis Von Doom on 29/03/16.
//  Copyright © 2016 Alexis Von Doom. All rights reserved.
//

import UIKit

class TableViewController: UITableView {
    
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
    




}
