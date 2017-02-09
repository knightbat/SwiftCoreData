//
//  ListViewController.swift
//  TestCoreSwift
//
//  Created by Bindu on 25/01/17.
//  Copyright © 2017 Xminds. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet var personTableView: UITableView!
    var result = [Person]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        let appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        
        let request : NSFetchRequest <Person>= Person.fetchRequest()
        
        do {
            result = try context.fetch(request)
            personTableView.reloadData()
            
        } catch let error {
            print(error)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableview Datasource and delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : PersonTableViewCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! PersonTableViewCell
        let person : Person = result[indexPath.row]
        cell.nameLabel.text = person.name
        cell.ageLabel.text = String(format: "%d", (person.age?.intValue)!)
        cell.jobLabel.text = person.job
        cell.userImageView.image = UIImage(data:person.image as! Data,scale:1.0)
        cell.addressLabel.text = "House No: \(person.address?.houseNumber ?? ""), \(person.address?.city ?? "")"
        
        return cell;
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "update", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDel.persistentContainer.viewContext
            context.delete(result[indexPath.row] as NSManagedObject)
            result.remove(at: indexPath.row)
            do {
                try context.save()
            } catch let error {
                // Handle error stored in *error* here
                print(error)
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
  
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delButton : UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete") { (IndexPath) in
            
        }
        delButton.backgroundColor=UIColor.black
        
        return [delButton]
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let vc :DetailsAddViewController = segue.destination as! DetailsAddViewController
        
        
        if(segue.identifier=="update") {
            
            let indexPath = personTableView.indexPathForSelectedRow;
            
            vc.arrayIndex=(indexPath?.row)!
        } else {
            
            vc.arrayIndex = -1
        }
    }
    
    
}
