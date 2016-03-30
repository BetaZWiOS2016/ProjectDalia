//
//  ViewController.swift
//  EndProject
//
//  Created by Alexis Von Doom on 18/03/16.
//  Copyright © 2016 Alexis Von Doom. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //MARK: Properties
    
    @IBOutlet weak var txtTitleField: UITextField!

    @IBOutlet weak var txtDateField: UITextField!
    
    @IBOutlet weak var txtAmountField: UITextField!
    
    @IBOutlet weak var lblNameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!

    @IBOutlet weak var ratingControl: RatingControll!
    
    @IBOutlet weak var btnCancelButton: UIBarButtonItem!
    
    @IBOutlet weak var btnSaveButton: UIBarButtonItem!
    
    
    
    //the value passed from the tableviewController or added as a new expense
    var expense: Expense?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Handle the textfield's user input through delegate callbacks
        txtTitleField.delegate = self
        
        //enables the saveButton if the textfield has a name
        checkValidExpenseName()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFielDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //auto hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        lblNameLabel.text = textField.text
        btnSaveButton.enabled = false
    }
    
    func checkValidExpenseName(){
        //Disable save button if there is nothing in the textfiels
        let title = txtTitleField.text ?? ""
        let date = txtDateField.text ?? ""
        let amount =  txtAmountField.text ?? ""
        
        btnSaveButton.enabled = !title.isEmpty
        btnSaveButton.enabled = !date.isEmpty
        btnSaveButton.enabled = !amount.isEmpty
        

    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidExpenseName()
        navigationItem.title = textField.text
    }
  
    
    
    
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        // dismiss the picker if the user canceled and adds an animation aswell
        dismissViewControllerAnimated(true, completion: nil)
    }
    //function for handeling selected images
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // info dictionary contains multiple representation of the image, and this uses the original 
        
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //Set photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        //Dismiss the Picker
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    //MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //=== means to check if the object refered savebutton
        if btnSaveButton === sender {
            
            let title = txtTitleField.text ?? " "
            let date = txtDateField.text ?? " "
            let amount = Double(txtAmountField.text!) ?? 0.0
            let photo = photoImageView.image
            let rating = ratingControl.rating
            
            //for the tableviewcontroller and unwind the segue
            expense = Expense(title: title, amount: amount,rating: rating, photo: photo, date: date)
        
        }
        
    }
    
    
    
    //MARK: Actions
    @IBOutlet var selectImageList: UITapGestureRecognizer!
    
    @IBOutlet weak var btnAddButton: UIButton!
    
    @IBAction func setDefaultLabelText(sender: UIButton){
        lblNameLabel.text = "Default text"
    
    }
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer){
        //hide the keyboard
        txtTitleField.resignFirstResponder()
        
        //UIImagePickerController is a viewController that lets a user pick a media from their photoLibrary
        let imagePickerController = UIImagePickerController()
        
        //Only allow photos to be picked, not taken
        imagePickerController.sourceType = .PhotoLibrary
        
        //Make sure ViewController is notified when the user picks an image
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func cancel(sender: UIBarItem){
        
        dismissViewControllerAnimated(true, completion: nil)
    
    }
    
    

    
    




}

