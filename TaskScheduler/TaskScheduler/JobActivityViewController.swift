//
//  JobActivityViewController.swift
//  TaskScheduler
//  Created by Enrique Delgado on 10/20/22.
//

import UIKit
import Parse

class JobActivityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var activities = [PFObject]() //an array to hold job activities
    
    // the job name being passed from the job list view when selecting a job
    var name:String?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"JobActivity")
        // TODO: only get the activity for the selected job. Fetch by name.
        query.includeKeys(["job_id", "user_id"])
        
        query.findObjectsInBackground { (activities, error) in
            if activities != nil {
                self.activities = activities!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobActivityCell") as! JobActivityCell
        let activity = activities[indexPath.row]
        print(activity)

        let activityType = activity["type"] as! String
        
        let user = activity["user_id"] as! PFUser
        let username = user["username"] as! String
        
        // createdAt is a property of PFObject, you need to access it directly using dot notation.
        let createdDate = activity.createdAt as! Date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        //now we can set information in each cell
        cell.statusLabel.text = activityType
        cell.userLabel.text = username
        cell.dateLabel.text = dateFormatter.string(from: createdDate)
    

        return cell
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
