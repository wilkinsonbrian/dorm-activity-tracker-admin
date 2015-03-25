//
//  HomeViewController.swift
//  Dorm Activity Tracker Admin
//
//  Created by Brian Wilkinson on 2/7/15.
//  Copyright (c) 2015 Brian Wilkinson. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let client = BAAClient.sharedClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool)  {
        
        super.viewDidAppear(animated)
        
        if !client.isAuthenticated() {
            navigationController?.performSegueWithIdentifier("showLogin", sender: nil)
            
        }
        
    }
    
    @IBAction func addNewActivity(sender: UIButton) {
        navigationController?.performSegueWithIdentifier("addNewActivity", sender: nil)
    }
    
    @IBAction func viewActivities(sender: UIButton) {
        navigationController?.performSegueWithIdentifier("viewActivities", sender: nil)
    }
    
    @IBAction func viewListOfStudents(sender: UIButton) {
        navigationController?.performSegueWithIdentifier("showStudentList", sender: nil)
        
    }
    
    @IBAction func logoutTapped(sender: UIButton) {
        
        client.logoutWithCompletion({(success: Bool, error: NSError!) -> () in
            
            if (success) {
                self.navigationController?.performSegueWithIdentifier("showLogin", sender: nil)
            } else {
                println(error)
            }
        })
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
