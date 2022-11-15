//
//  TasksViewController.swift
//  TaskScheduler
//
//  Created by Enrique Delgado on 10/20/22.
//

import UIKit
import Parse

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var jobs = [PFObject]() //an array to hold jobs
    var rowNum:Int? //an array to hold jobs

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

        
    }
     
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Job")
        
        query.findObjectsInBackground { (jobs, error) in
            if jobs != nil {
                self.jobs = jobs!
                self.tableView.reloadData()
            }
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobTableViewCell") as! JobTableViewCell
        let job = jobs[indexPath.row]

        let jobName = job["name"] as! String
        let assignedTo = job["assigned_to"] as! PFUser
        let assignedUsername = assignedTo.objectId as! String
        
        // TODO: this formatting is not working. Figure out how to format the date and bind it to DateLable.text
        var dueDate = job["due_date"] as! Date
        let dateFormatter = DateFormatter()

        
        print(dateFormatter.string(from: dueDate))
        
        //now we can set information in each cell
        cell.JobNameLabel.text = jobName
        cell.AssignedNameLabel.text = assignedUsername
        cell.DateLabel.text = dateFormatter.string(from: dueDate)

        
        //add some logic for the status button image here
        //if is complete = 1 green
        //if not, yellow?
        
        //let status = job["status"] as! String
        //if status == "not_started" {
            //not started. make color red
          //  cell.StatusImage.image = UIImage(named: "not_started_status_image")
        //} else if status == "in_progress" {
            //in progress. make color yellow
          //  cell.StatusImage.image = UIImage(named: "in_progress_status_image")
        //} else if status == "completed" {
            //completed. make color green
          //  cell.StatusImage.image = UIImage(named: "completed_status_image")
        //}

        return cell
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginViewController
    
    }
    
    
    //Performs segue when a job is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowNum = indexPath.row
        performSegue(withIdentifier: "jobDetails", sender: self)
   }
    
    
    // MARK: - Navigation
    //Passes data from task view controller to tab bar controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "jobDetails"){
            let job = jobs[rowNum!]
            let vc = segue.destination as! TabBarController
            vc.name = job["name"] as? String
            vc.assignedTo = job["assigned_to"] as? String
            vc.assignedBy = job["assigned_by"] as? String
            vc.desc = job["description"] as? String
            vc.dueDate = job["due_date"] as? String
            vc.status = job["status"] as? String
            vc.isCompleted = job["is_completed"] as? Bool
        }

    }
    

}
