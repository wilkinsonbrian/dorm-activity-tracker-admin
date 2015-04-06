//
//  AddANewActivityTableViewController.swift
//  Dorm Activity Tracker Admin
//
//  Created by Brian Wilkinson on 4/3/15.
//  Copyright (c) 2015 Brian Wilkinson. All rights reserved.
//

import UIKit

class AddANewActivityTableViewController: UITableViewController {

    @IBOutlet weak var activityName: UITextField!
    
    @IBOutlet weak var activityDescription: UITextView!
    
    @IBOutlet weak var maxParticipants: UITextField!
    
    
    @IBOutlet weak var activityStartTime: UIDatePicker!
    
    @IBOutlet weak var activityEndTime: UIDatePicker!
    var newActivity: Activity!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        newActivity = Activity()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func saveNewActivity(sender: UIBarButtonItem) {
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        //dateFormatter.dateFormat = "MMM d, yyyy"
        
        newActivity.name = activityName.text
        newActivity.maximum = maxParticipants.text.toInt()!
        
        newActivity.activityDescription = activityDescription.text
        
        newActivity.startTime = dateFormatter.stringFromDate(activityStartTime.date)
        
        newActivity.endTime = dateFormatter.stringFromDate(activityEndTime.date)
        
        newActivity.saveObjectWithCompletion({(object:AnyObject!, error: NSError!) -> () in
            if (error == nil) {
                println(self.newActivity.startTime)
                println("Activity added successfully")
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                println("There was a problem adding this activity")
            }
        })
    }
    
    
    @IBAction func returnToMainMenu(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
}


    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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

