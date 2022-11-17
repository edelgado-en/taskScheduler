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

    @IBOutlet weak var jobName: UILabel!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var managerNameLabel: UILabel!
    
    @IBOutlet weak var JobStatusImage: UIImageView!
    
    @IBOutlet weak var AssignedToProfileImage: UIImageView!
    
    @IBOutlet weak var AssignedByProfileImage: UIImageView!
    
    @IBOutlet weak var JobDescriptionLabel: UILabel!
    
    @IBOutlet weak var DueDateLabel: UILabel!
    
    
    var name:String?
    var assignedTo:PFUser? //was String?
    var createdBy:PFUser? //was String?
    var dueDate:Date? //was String?
    var isCompleted:Bool?
    var status:String?
    var desc:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //formatting date value
        var dueDate = dueDate!
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
