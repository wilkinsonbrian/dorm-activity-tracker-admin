//
//  StudentListTableViewController.swift
//  Dorm Activity Tracker Admin
//
//  Created by Brian Wilkinson on 3/20/15.
//  Copyright (c) 2015 Brian Wilkinson. All rights reserved.
//

import UIKit

class StudentListTableViewController: UITableViewController {

    var students: [Student] = []
    var currentStudent: Student!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        Student.getObjectsWithCompletion({(listOfStudents:[AnyObject]!, error: NSError!) -> () in
            
            if (error == nil) {
                self.students = listOfStudents as [Student]
                self.tableView.reloadData()
            } else {
                println("error loading Activites")
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return students.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("studentName", forIndexPath: indexPath) as UITableViewCell
        
        currentStudent = self.students[indexPath.row]
        cell.textLabel?.text = currentStudent.fullName
        cell.detailTextLabel?.text = "Class of " + String(currentStudent.graduationYear)
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "viewCompletedActivities" {
            let studentActivityController = segue.destinationViewController as StudentActivitiesCompletedTableViewController
            let myIndexPath = self.tableView.indexPathForSelectedRow()
            let row = myIndexPath?.row
            studentActivityController.studentActvities = self.students[row!].activities
        }
    }

//    override func prepareForSegue(segue: UIStoryboardSegue,
//        sender: AnyObject?) {
//            
//            if segue.identifier == "showStudentActivities" {
//                println("Got here")
//                let studentAvtivityViewController = segue.destinationViewController
//                    as StudentActivitiesCompletedTableViewController
//                
//                let myIndexPath = self.tableView.indexPathForSelectedRow()
//                let row = myIndexPath?.row
//                studentAvtivityViewController.studentActvities = self.students[row!].activities
//
//            }
//    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
