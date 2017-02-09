//
//  DetailsAddViewController.swift
//  TestCoreSwift
//
//  Created by Bindu on 25/01/17.
//  Copyright © 2017 Xminds. All rights reserved.
//

import UIKit
import CoreData

class DetailsAddViewController: UIViewController, UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var scrlContainer: UIScrollView!
    @IBOutlet var jobTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var userIamgeView: UIImageView!
    @IBOutlet var houseNoTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    
    var arrayIndex : NSInteger = NSInteger()
    var person : Person = Person()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupKeyboard()
        
        userIamgeView.layer.cornerRadius = userIamgeView.frame.size.width/2
        
        if arrayIndex > -1 {
            
            let appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context : NSManagedObjectContext = appDel.persistentContainer.viewContext
            let request : NSFetchRequest <Person>= Person.fetchRequest()
            
            do {
                let result = try context.fetch(request)
                person  = result[arrayIndex]
                
                nameTextField.text = person.name
                jobTextField.text = person.job
                ageTextField.text = person.age?.stringValue
                cityTextField.text=person.address?.city
                houseNoTextField.text=person.address?.houseNumber
                userIamgeView.image=UIImage(data:person.image as! Data,scale:1.0)
                
            } catch let error {
                print(error)
            }
            
        }
    }
    
    // MARK: - Button Actions
    
    @IBAction func imageTapped(_ sender: UIButton) {
        
        let actionSheet = UIAlertController (title: "Choose Photo", message: "Choose An Option", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { action in
            
            let picker = UIImagePickerController()
            picker.sourceType=UIImagePickerControllerSourceType.camera
            picker.allowsEditing=true
            picker.delegate=self
            self.present(picker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Choose From Gallery", style: UIAlertActionStyle.default, handler: { action in
            
            let picker = UIImagePickerController()
            picker.sourceType=UIImagePickerControllerSourceType.photoLibrary
            picker.allowsEditing=true
            picker.delegate=self
            self.present(picker, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { action in
            
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func saveClicked(_ sender: UIButton) {
        
        let appDelegate :AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        if (arrayIndex > -1) {
            
            let age :NSDecimalNumber = NSDecimalNumber.init(string: ageTextField.text)
            person.name = nameTextField.text
            person.age=age;
            person.job=jobTextField.text
            
            let addressManager = NSEntityDescription.entity(forEntityName: "Address", in: context)
            let data = UIImagePNGRepresentation(userIamgeView.image!)
            person.address = Address (entity: addressManager!, insertInto: context)
            
            person.address?.houseNumber=houseNoTextField.text
            person.address?.city = cityTextField.text
            person.image=data as NSData?
            do {
                try context.save()
            } catch let error {
                print(error)
            }
            _ = self.navigationController?.popViewController(animated: true)
            
        } else {
            
            if ((nameTextField.text?.characters.count)!>0 && (ageTextField.text?.characters.count)!>0 && (jobTextField.text?.characters.count)!>0) {
                
                
                let personManager = NSEntityDescription.entity(forEntityName: "Person", in: context)
                
                let person = Person (entity: personManager!, insertInto: context)
                let age :NSDecimalNumber = NSDecimalNumber.init(string: ageTextField.text)
                let data = UIImagePNGRepresentation(userIamgeView.image!)
                person.name = nameTextField.text
                person.age=age;
                person.job=jobTextField.text
                person.image=data as NSData?
                let addressManager = NSEntityDescription.entity(forEntityName: "Address", in: context)
                
                person.address = Address (entity: addressManager!, insertInto: context)
                
                
                person.address?.houseNumber=houseNoTextField.text
                person.address?.city = cityTextField.text
                
                do {
                    try context.save()
                } catch let error {
                    print(error)
                }
                _ = self.navigationController?.popViewController(animated: true)
            } else {
                
                let alert : UIAlertController = UIAlertController.init(title: "Error !", message: "Enter all data", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction : UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.cancel, handler: { (data) in
                    print("ok clicked")
                });
                alert.addAction(okAction)
                
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
    }
    // MARK: - Methods
    
    func setupKeyboard() {
        
        let keyboardToolbar = UIToolbar.init()
        keyboardToolbar.sizeToFit()
        
        let flexBarButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneBarButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action:#selector(keyboardDoneClicked(sender:)));
        
        keyboardToolbar.items=[flexBarButton,doneBarButton]
        
        self.ageTextField.inputAccessoryView=keyboardToolbar
        
    }
    func keyboardDoneClicked (sender: UIBarButtonItem) {
        self.jobTextField.becomeFirstResponder()
    }

    
    // MARK: - UIImagePickerViewControllerDelegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let pickedImage : UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        userIamgeView.image=pickedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - UItextField Delegates
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrlContainer.contentOffset.y=textField.frame.origin.y-20
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrlContainer.contentOffset.y=0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (textField.isEqual(nameTextField)) {
            ageTextField.becomeFirstResponder()
        } else if (textField.isEqual(ageTextField)) {
            jobTextField.becomeFirstResponder()
        } else if (textField.isEqual(jobTextField)) {
            cityTextField.becomeFirstResponder()
        } else if (textField.isEqual(cityTextField)) {
            houseNoTextField.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
        }
        
        return true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
