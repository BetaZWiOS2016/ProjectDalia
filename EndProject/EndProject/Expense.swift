//
//  Expense.swift
//  EndProject
//
//  Created by Alexis Von Doom on 29/03/16.
//  Copyright © 2016 Alexis Von Doom. All rights reserved.
//

import Foundation
import UIKit

class Expense {
    
    var amount: Double
    var date: String
    var rating: Int
    var photo: UIImage?
    var title: String
    
    //MARK: Initialization
    init?(title: String, amount: Double, rating: Int, photo: UIImage?, date: String){
        
        //initialize the amount
        self.photo = photo
        self.title = title
        self.amount = amount
        self.date = date
        self.rating = rating
        
        
        //initialization should fail if there is no title nor rating is negative
        
        if title.isEmpty || rating < 0 {
            
            return nil
         
    
        }
    
    }

    
}
