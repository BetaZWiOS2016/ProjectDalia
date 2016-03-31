//
//  RatingControll.swift
//  EndProject
//
//  Created by Alexis Von Doom on 29/03/16.
//  Copyright © 2016 Alexis Von Doom. All rights reserved.
//

import UIKit

class RatingControll: UIView {
    
    //MARK: Properties
    
    // added a property observer
    //observes and respond to changes in a property value
    //called everytime a property's value is set and can be used to perform work immediatly or after
    //didSet is called immediately
    //setNeedsLayout will trigger and update everytime the rating changes, ensure an accurate UI representation
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    let spacing = 7
    let starCount = 5
    
    
    

    //MARK: initialization
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledImage = UIImage(named: "filledStar")
        let emptyImage = UIImage(named: "emptyStar")
        
        
        for _ in 0..<5{
            
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 32))
            button.setImage(emptyImage, forState: .Normal)
            button.setImage(filledImage, forState: .Selected)
            button.setImage(filledImage, forState: [.Highlighted, .Selected])
            
            
            //this line was for define position of the buttons
       // button.backgroundColor = UIColor.blueColor()
            
            
            // diesnt add an additional highlight during the change state
            button.adjustsImageWhenHighlighted = false
        
        //adding an action methode just like in in normal controller view except shorter
        button.addTarget(self,action: "ratingButtonTapped:", forControlEvents: .TouchDown)
        //adds the button in the view object
        ratingButtons += [button]
        addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        
        let buttonSize = Int(frame.size.height)
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        //offset each button's origin by the length of the button + spacing
        for(index, button) in ratingButtons.enumerate(){
            buttonFrame.origin.x=CGFloat(index*(32+spacing))
            button.frame = buttonFrame
        
        }
        updateButtonSelectionStates()
        
    }
    
    
    //sets up the size of the buttons, tell the stackView how to layout the button or others stuff
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * starCount) + (spacing * (starCount-1))
        return CGSize(width: width, height: buttonSize)
    }
    
    //MARK: Button Action
    func ratingButtonTapped(button: UIButton){
        //print("Button pressed 👍")
        
        //returns the selected button in an array
        //here it is forced unwrapped
        rating = ratingButtons.indexOf(button)! + 1
        
        updateButtonSelectionStates()
        
        
    }
    
    func updateButtonSelectionStates(){
        
        //if the index of a button is less selected than the rating, that button should be selected
        for(index, button) in ratingButtons.enumerate(){
            button.selected = index < rating
        
        }
    
    }


}
