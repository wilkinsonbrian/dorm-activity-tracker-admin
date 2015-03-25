//
//  AttendanceTableViewController.swift
//  Dorm Activity Tracker Admin
//
//  Created by Brian Wilkinson on 2/22/15.
//  Copyright (c) 2015 Brian Wilkinson. All rights reserved.
//

import UIKit

class AttendanceTableViewController: UITableViewController {
    
    var students: [String]!
    var BAStudents: [BAAUser] = []
    var activity: Activity!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return students.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("studentAttendance", forIndexPath: indexPath) as UITableViewCell
        
        var currentStudent: Student!
        var currentActivityID = activity.objectId
        
        Student.getObjectWithId(self.students[indexPath.row], {(student:AnyObject!, error:NSError!) -> () in
            if error == nil {
                currentStudent = student as Student
                cell.textLabel?.text = currentStudent.fullName
            } else {
                cell.textLabel?.text = "Can't retrieve student information"
            }
            
            for activityAttended in currentStudent.activities {
                if currentActivityID == activityAttended {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
            }
        })
    
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        let parameters = ["where": "fullName='\(students[indexPath.row])'"]
        Student.getObjectsWithParams(parameters, {(student: [AnyObject]!, error:NSError!) -> () in
            
            var studentRecord = student[0] as Student
            var currentUserActvityList:[String] = []
            var originalActvityList:[String] = []
            originalActvityList = studentRecord.activities
            
            if cell.accessoryType == UITableViewCellAccessoryType.Checkmark {
                
                currentUserActvityList.removeLast()
                cell.accessoryType = UITableViewCellAccessoryType.None
                
            } else {
                currentUserActvityList.append(self.activity.objectId)
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            
            studentRecord.activities = currentUserActvityList
            
            studentRecord.saveObjectWithCompletion({(object: AnyObject!, error: NSError!) -> () in
                if (error == nil) {
                    println("Student record updated")
                } else {
                    println("Error updating student record")
                }
                })
            })
        
    }
    

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

    

}
