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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //query data from the database
        //issue is in here.. list is still empty at the end of query
        let query = PFQuery(className:"Job")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in if objects != nil {
            print("OBJECTS != NIL")
            self.jobs = objects!
            print(self.jobs.count)
            self.tableView.reloadData()
            print(self.jobs.count)
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return a number of rows. Also can be used as an iterator I guess
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //getting each individual cell
        //for each row, give me a particular cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobTableViewCell") as! JobTableViewCell
        
        //READING FROM THE DATABASE WRONG - LOOK AT QUERY
        //jobs.count is 0 right now
        let job = jobs[indexPath.row] //section or something else?

        //now we can set information in each cell
        cell.JobNameLabel.text = job["name"] as! String
        cell.AssignedNameLabel.text = job["assigned_to"] as! String
        cell.DateLabel.text = job["due_date"] as! String

        //add some logic for the status button image here
        //if is complete = 1 green
        //if not, yellow?
        let status = job["status"] as! String
        if status == "not_started" {
            //not started. make color red
            cell.StatusImage.image = UIImage(named: "not_started_status_image")
        } else if status == "in_progress" {
            //in progress. make color yellow
            cell.StatusImage.image = UIImage(named: "in_progress_status_image")
        } else if status == "completed" {
            //completed. make color green
            cell.StatusImage.image = UIImage(named: "completed_status_image")
        }

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
