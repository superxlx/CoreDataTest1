//
//  ViewController.swift
//  CoreDataTest1
//
//  Created by xlx on 15/4/15.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet weak var showTextView: UITextView!
    @IBOutlet weak var addTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addButton(sender: AnyObject) {
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity = NSEntityDescription.entityForName("Test", inManagedObjectContext:
            managedContext)
        let test = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        //3
        let name = self.addTextField.text
        test.setValue(name, forKey: "name")
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)") 
        }
    }
    @IBAction func showButton(sender: AnyObject) {
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        //2
        let fetchRequest = NSFetchRequest(entityName:"Test")
        //3
        var error: NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]?
        if let results = fetchedResults {
            for each in results{
                let name:String = each.valueForKey("name") as! String
                self.showTextView.text = self.showTextView.text + name + "\n"
            }
        }else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }


}

