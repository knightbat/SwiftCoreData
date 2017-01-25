//
//  DetailsAddViewController.swift
//  TestCoreSwift
//
//  Created by Bindu on 25/01/17.
//  Copyright © 2017 Xminds. All rights reserved.
//

import UIKit
import CoreData

class DetailsAddViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveClicked(_ sender: UIButton) {
        
        if ((nameTextField.text?.characters.count)!>0) {
            
            let appDelegate :AppDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let context : NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            
            let personManager = NSEntityDescription.entity(forEntityName: "Person", in: context)
            
            let person = Person (entity: personManager!, insertInto: context)
            
            person.name = nameTextField.text
            
            do {
                try context.save()
            } catch let error {
                print(error)
            }
            _ = self.navigationController?.popViewController(animated: true)
        } else {
            
            let alert : UIAlertController = UIAlertController.init(title: "Error !", message: "Enter a name", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction : UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.cancel, handler: { (data) in
                print("ok clicked")
            });
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
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
