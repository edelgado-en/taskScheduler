//
//  NewJobViewController.swift
//  TaskScheduler
//
//  Created by Enrique Delgado on 11/10/22.
//

import UIKit
import Parse

class NewJobViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var showEditButton:Bool?
    var jobName:String?
    var desc:String?
    var dueDate:Date?
    var assignedTo:PFUser?
    var jobId:String?


    
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

    
    @IBAction func saveChanges(_ sender: Any) {
        
        let query = PFQuery(className:"Job")
        query.getObjectInBackground(withId: jobId!) { (job: PFObject?, error: Error?) in

            if let error = error {
                print(error.localizedDescription)
            } else if let job = job {
                job["name"] = self.NameInput.text
                job["description"] = self.DescriptionInput.text
                job["due_date"] = self.DueDatePicker.date
                let userIndex = self.AssignToPicker.selectedRow(inComponent:0)
                job["assigned_to"] = self.users[userIndex]
                //job["status"] = "not_started" //should change to int value
                job.saveInBackground()
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var showDismissButton: UIButton!

    @IBOutlet weak var editButton: UIButton!
    
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
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AssignToPicker.delegate = self
        self.AssignToPicker.dataSource = self

        
        //create a border for the description textView
        DescriptionInput.layer.borderWidth = 1
        DescriptionInput.layer.borderColor = UIColor.lightGray.cgColor
        NameInput.layer.borderColor = UIColor.lightGray.cgColor
        
        
        let query = PFUser.query()

        query?.findObjectsInBackground(block: { [self] users, error in
            if users != nil{
                self.users = users!
                //print(self.users[0].objectId)
                for user in self.users {
                    //print(user.objectId)
                    self.pickerData.append(user["username"] as! String)
                }
            }
        })
        
        NameInput.text = jobName
        DescriptionInput.text = desc
        if(dueDate != nil){
            DueDatePicker.date = dueDate!
        }
        

        if(showEditButton == nil){
            self.editButton.isHidden = true
            self.showDismissButton.isHidden = true
            self.saveButton.isHidden = false
        }
        else{
            self.editButton.isHidden = false
            self.showDismissButton.isHidden = false
            self.saveButton.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (assignedTo != nil){
            let username = assignedTo!["username"] as! String
            let index = pickerData.firstIndex(of: username)!
            self.AssignToPicker.reloadAllComponents()
            AssignToPicker.selectRow(index, inComponent:0, animated: true)
        }
        else{
            self.AssignToPicker.reloadAllComponents()
        }

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
        //dismiss the screen after creation
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
