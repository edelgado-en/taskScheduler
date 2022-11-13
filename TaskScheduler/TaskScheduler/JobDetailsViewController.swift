//
//  JobDetailsViewController.swift
//  TaskScheduler
//
//  Created by Izayah Hewell  on 11/12/22.
//

import UIKit
import Parse

class JobDetailsViewController: UIViewController {

    @IBOutlet weak var jobName: UILabel!
    
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var managerNameLabel: UILabel!
    
    @IBOutlet weak var jobDescriptionLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    var name:String?
    var assignedTo:String?
    var assignedBy:String?
    var dueDate:String?
    var isCompleted:Bool?
    var status:String?
    var desc:String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jobName.text = name
        employeeNameLabel.text = assignedTo
        managerNameLabel.text = assignedBy
        jobDescriptionLabel.text = desc
        statusLabel.text = status
        dueDateLabel.text = dueDate

        // Do any additional setup after loading the view.
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
