//
//  AddActivityViewController.swift
//  Dorm Activity Tracker Admin
//
//  Created by Brian Wilkinson on 2/7/15.
//  Copyright (c) 2015 Brian Wilkinson. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController {


    @IBOutlet weak var activityName: UITextField!
    
    @IBOutlet weak var maxParticipants: UITextField!
    
    @IBOutlet weak var activityBeginTime: UIDatePicker!
    
    @IBOutlet weak var activityStartTime: UIDatePicker!
    @IBOutlet weak var activityEndTime: UIDatePicker!
    
    @IBOutlet weak var activityDescription: UITextView!
    
    @IBOutlet weak var resultLabel: UILabel!
    var newActivity: Activity!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init(coder aDecoder: (NSCoder!))  {
        
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newActivity = Activity()
        resultLabel.text = ""

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addNewActivity(sender: UIButton) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        let calendar = NSCalendar.currentCalendar()
        let startingTime = calendar.components((.HourCalendarUnit | .MinuteCalendarUnit), fromDate: activityStartTime.date)
        let endingTime = calendar.components((.HourCalendarUnit | .MinuteCalendarUnit), fromDate: activityEndTime.date)
 
        newActivity.name = activityName.text
        newActivity.maximum = maxParticipants.text.toInt()!
        
        newActivity.activityDescription = activityDescription.text
        
        newActivity.eventDate = dateFormatter.stringFromDate(activityBeginTime.date)
        
        newActivity.startTime = String(startingTime.hour) + ":" + String(startingTime.minute)
        
        newActivity.endTime = String(endingTime.hour) + ":" + String(endingTime.minute)
        
        
        newActivity.saveObjectWithCompletion({(object:AnyObject!, error: NSError!) -> () in
            if (error == nil) {
                self.resultLabel.text = "Activity Added Successfully"
                self.clearData()
            } else {
                self.resultLabel.text = "There was a problem adding this activity"
            }
        })
    }
    
    @IBAction func clearFormData(sender: UIButton) {
        clearData()
    }
    
    func clearData() {
        activityName.text = ""
        maxParticipants.text = ""
        activityDescription.text = ""
    }
    
    @IBAction func returnToMainMenu(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
