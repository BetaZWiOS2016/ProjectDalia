//
//  ExpenseViewTableViewCell.swift
//  EndProject
//
//  Created by Alexis Von Doom on 29/03/16.
//  Copyright © 2016 Alexis Von Doom. All rights reserved.
//

import UIKit

class ExpenseViewTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var txtTitleLabel: UILabel!

    @IBOutlet weak var imPhotoImage: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControll!
    
    @IBOutlet weak var txtDateLabel: UILabel!
    
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
