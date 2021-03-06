//
//  AttendanceTableViewController.swift
//  Dorm Activity Tracker Admin
//
//  Created by Brian Wilkinson on 2/22/15.
//  Copyright (c) 2015 Brian Wilkinson. All rights reserved.
//

import UIKit

class AttendanceTableViewController: UITableViewController {
    
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
        return activity.participantsSignedUp.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("studentAttendance", forIndexPath: indexPath) as UITableViewCell
        
        var currentStudent: Student!
      
        Student.getObjectWithId(self.activity.participantsSignedUp[indexPath.row], {(student:AnyObject!, error:NSError!) -> () in
            if error == nil {
                currentStudent = student as Student
                cell.textLabel?.text = currentStudent.fullName
            } else {
                cell.textLabel?.text = "Can't retrieve student information"
            }
            
            for activityAttended in currentStudent.activities {
                if self.activity.objectId == activityAttended {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
            }
        })
    
        return cell
    }
    
    /* Called when a row is tapped. When attendance is taken, dorm faculty will tap the row. A checkmark will appear
    to indicate the student is present. The activity is then added to an array of activities the student has completed.
    If the row is tapped again, the checkmark is removed and that activity is deleted from the array of completed activities
    for that student
    */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!

        Student.getObjectWithId(activity.participantsSignedUp[indexPath.row], {(student:AnyObject!, error:NSError!) -> () in
            
            var studentRecord = student as Student
            
            if cell.accessoryType == UITableViewCellAccessoryType.Checkmark {
                
                for var x = 0; x < studentRecord.activities.count; ++x {
                    if studentRecord.activities[x] == self.activity.objectId {
                        studentRecord.activities.removeAtIndex(x)
                    }
                }
                cell.accessoryType = UITableViewCellAccessoryType.None
                
            } else {
                studentRecord.activities.append(self.activity.objectId)
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            
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
