//
//  LoginViewController.swift
//  TaskScheduler
//
//  Created by Enrique Delgado on 10/20/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSignIn(_ sender: Any) {
    
    }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        // TODO: in the signup view, add a radio buttons to select manager or employee
        // and use that value here
        user["manager"] = true
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                
            } else {
                // TODO: show an actual message in the view
                print("Error: \(error?.localizedDescription)")
            }
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
