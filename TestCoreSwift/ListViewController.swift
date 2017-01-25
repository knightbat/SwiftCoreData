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
        
        cell.nameLabel.text=result[indexPath.row].name
        
        return cell;
        
        
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