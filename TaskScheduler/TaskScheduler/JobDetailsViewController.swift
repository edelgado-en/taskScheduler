//
//  JobDetailsViewController.swift
//  TaskScheduler
//
//  Created by Izayah Hewell  on 11/12/22.
//

import UIKit
import Parse
import AlamofireImage

class JobDetailsViewController: UIViewController {
    public var completionHandler: ((Bool?) -> Void)?
    
    @IBOutlet weak var jobName: UILabel!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var managerNameLabel: UILabel!
    
    @IBOutlet weak var JobStatusImage: UIImageView!
    
    @IBOutlet weak var AssignedToProfileImage: UIImageView!
    
    @IBOutlet weak var AssignedByProfileImage: UIImageView!
    
    @IBOutlet weak var JobDescriptionLabel: UILabel!
    
    @IBOutlet weak var DueDateLabel: UILabel!
    
    @IBOutlet weak var showButton: UIButton!
    @IBAction func editButton(_ sender: Any) {
        
    let vc = storyboard?.instantiateViewController(withIdentifier: "newJobScreen") as! NewJobViewController
        vc.showEditButton = true
        vc.jobName = name
        vc.desc = desc
        vc.dueDate = dueDate
        vc.assignedTo = assignedTo
        vc.jobId = jobId
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    var name:String?
    var assignedTo:PFUser? //was String?
    var createdBy:PFUser? //was String?
    var dueDate:Date? //was String?
    var isCompleted:Bool?
    var status:String?
    var desc:String?
    var jobId:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //formatting date value
        let dueDate = dueDate!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"

        
        jobName.text = name
        jobName.sizeToFit()
        //assignedto and assignedby must be turned into string values
        employeeNameLabel.text = assignedTo?.username
        managerNameLabel.text = createdBy?.username
        JobDescriptionLabel.text = desc
        //probably get rid of this boarder stuff. Looks kind of ugly
        JobDescriptionLabel.layer.borderColor = UIColor.black.cgColor
        JobDescriptionLabel.layer.borderWidth = 0.5
        //turn date value into string
        DueDateLabel.text = dateFormatter.string(from: dueDate)
        
        //add some logic for the job status image - should be same as parent
        if status == "not_started" {
            //not started. make color red
            JobStatusImage.image = UIImage(named: "not_started_status_image")
        } else if status == "in_progress" {
            //in progress. make color yellow
            JobStatusImage.image = UIImage(named: "in_progress_status_image")
        } else if status == "completed" {
            //completed. make color green
            JobStatusImage.image = UIImage(named: "completed_status_image")
        }
        
        //Shows or hides the edit button
        let user = PFUser.current()
        let isManager = user?["manager"] as? Bool

        if(isManager == true){
            self.showButton.isHidden = false
        }
        else{
            self.showButton.isHidden = true
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className:"Job")
        query.includeKeys(["assigned_to", "created_by"])
        query.getObjectInBackground(withId: jobId!) { (job, error) in
            if error == nil {
                let employee = job?["assigned_to"] as? PFUser
                let manager = job?["created_by"] as? PFUser
                let date = job?["due_date"] as? Date
                let dueDate = date!
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/YYYY"
                
                self.jobName.text = job?["name"] as? String
                self.employeeNameLabel.text = employee?.username
                self.managerNameLabel.text = manager?.username
                self.DueDateLabel.text = dateFormatter.string(from: dueDate)

            } 
        }
    }

}
