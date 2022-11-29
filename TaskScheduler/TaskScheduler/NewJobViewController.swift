//
//  NewJobViewController.swift
//  TaskScheduler
//
//  Created by Enrique Delgado on 11/10/22.
//

import UIKit
import Parse

class NewJobViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var users = [PFObject]() //array to hold users
    //var usernames = [String]()
    var pickerData: [String] = [String]()
    //var pickerData: [Void] = [Void]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //print(users[row]["username"] as Any)
        return pickerData[row]
    }
    
    // Capture the picker view selection
   func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       // This method is triggered whenever the user makes a change to the picker selection.
       // The parameter named row and component represents what was selected.
   }

    
    @IBOutlet weak var JobTitle: UILabel!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var NameInput: UITextField!
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    @IBOutlet weak var DescriptionInput: UITextView!
    
    @IBOutlet weak var DueDateLabel: UILabel!
    
    @IBOutlet weak var DueDatePicker: UIDatePicker!
    
    @IBOutlet weak var AssignToLabel: UILabel!
    
    @IBOutlet weak var AssignToPicker: UIPickerView!
    
    @IBOutlet weak var TaskLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.AssignToPicker.delegate = self
        self.AssignToPicker.dataSource = self

        // Do any additional setup after loading the view.
        
        //create a border for the description textView
        DescriptionInput.layer.borderWidth = 1
        DescriptionInput.layer.borderColor = UIColor.black.cgColor
        
        let query = PFUser.query()
        query?.findObjectsInBackground(block: { users, error in
            if users != nil{
                self.users = users!
                //print(self.users[0].objectId)
                for user in self.users {
                    print(user.objectId)
                    self.pickerData.append(user["username"] as! String)
                }
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.AssignToPicker.reloadAllComponents()
    }

    
    @IBAction func NavLogoutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginViewController
    }
    
    @IBAction func NavBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //This is where we save information and store it into parse
    @IBAction func SaveButton(_ sender: Any) {
        let job = PFObject(className: "Job")
        
        //gather date
        job["name"] = NameInput.text
        job["description"] = DescriptionInput.text
        job["due_date"] = DueDatePicker.date
        //print(AssignToPicker.selectedRow(inComponent:0))
        let userIndex = AssignToPicker.selectedRow(inComponent:0)
        
        job["assigned_to"] = self.users[userIndex]
        job["created_by"] = PFUser.current()!
        job["status"] = "not_started" //should change to int value
        job["is_complete"] = false
        
        //save info into parse
        job.saveInBackground { success, error in
            if success {
                print("Information saved!")
            } else {
                print("Information not saved!")
            }
        }
        //dismiss the screen so that we return to main view
        dismiss(animated: true, completion: nil)
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
