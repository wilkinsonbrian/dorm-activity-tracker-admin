//
//  LoginViewController.swift
//  Dorm Activity Tracker Admin
//
//  Created by Brian Wilkinson on 2/7/15.
//  Copyright (c) 2015 Brian Wilkinson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let client = BAAClient.sharedClient()
    
    required init(coder aDecoder: (NSCoder!))  {
        
        super.init(coder: aDecoder)
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        usernameField.placeholder = "Username"
        
        passwordField.placeholder = "Password"
        
        spinner.hidesWhenStopped = true
        
        errorLabel.text = ""
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginTapped(sender: UIButton) {
        loginButton.enabled = false
        
        signupButton.enabled = false
        
        spinner.startAnimating()
        
        client.authenticateUser(usernameField.text, password:passwordField.text, { (success: Bool, error: NSError!) -> () in
            
            self.spinner.stopAnimating()
            
            self.loginButton.enabled = true
            
            self.signupButton.enabled = true
            
            if (success) {
                println("logged")
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                
                self.errorLabel.text = error.localizedDescription
                
            }
            
        })
        
    }
    

    @IBAction func signupTapped(sender: UIButton) {
        loginButton.enabled = false
        
        signupButton.enabled = false
        
        spinner.startAnimating()
        
        client.createUserWithUsername(usernameField.text, password:passwordField.text, completion: { (success: Bool, error: NSError!) -> () in
            
            self.loginButton.enabled = true
            
            self.signupButton.enabled = true
            
            self.spinner.stopAnimating()
            
            
            if (success) {
                
                println("created")
                
                self.usernameField.resignFirstResponder()
                
                self.passwordField.resignFirstResponder()
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            } else {
                
                self.errorLabel.text = error.localizedDescription
                
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
