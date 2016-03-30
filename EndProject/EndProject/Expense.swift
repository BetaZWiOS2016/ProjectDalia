//
//  Expense.swift
//  EndProject
//
//  Created by Alexis Von Doom on 29/03/16.
//  Copyright © 2016 Alexis Von Doom. All rights reserved.
//

import Foundation
import UIKit

class Expense : NSObject, NSCoding {
    
    //MARK: Properties
    
    var amount: Double
    var date: String
    var rating: Int
    var photo: UIImage?
    var title: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
    static let ArchiveURL = DocumentsDirectory?.URLByAppendingPathComponent("expenses")
    
    //MARK: Types
    //string value
    struct PropertyKey {
        
        static let titleKey = "title"
        static let photoKey = "photo"
        static let dateKey = "date"
        static let amountKey = "amount"
        static let ratingKey = "rating"
    
    
    }
    
    //MARK: Initialization
    init?(title: String, amount: Double, rating: Int, photo: UIImage?, date: String){
        
        //initialize the amount
        self.photo = photo
        self.title = title
        self.amount = amount
        self.date = date
        self.rating = rating
        
        super.init()
        
        
        //initialization should fail if there is no title nor rating is negative
        
        if title.isEmpty || rating < 0 {
            
            return nil
         
    
        }
    
    }
    
    //MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeObject(amount, forKey: PropertyKey.amountKey)
        aCoder.encodeObject(date, forKey: PropertyKey.dateKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let title = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        
        //optional property
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        
        let date = aDecoder.decodeObjectForKey(PropertyKey.dateKey) as? String
        
        let amount = aDecoder.decodeObjectForKey(PropertyKey.amountKey) as! Double
        
        let rating = aDecoder.decodeObjectForKey(PropertyKey.ratingKey) as! Int
        
        //Required init
        self.init(title: title, amount: amount, rating: rating, photo: photo, date: date!)
        
    }

    
}
