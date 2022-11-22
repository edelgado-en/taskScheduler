//
//  CommentsViewController.swift
//  TaskScheduler
//
//  Created by Izayah Hewell  on 11/12/22.
//

import UIKit
import Parse
import MessageInputBar

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
    
    @IBOutlet weak var jobNameLabel: UILabel!
    let commentBar = MessageInputBar()
    var showsCommentBar = false
    var comments:PFObject?
    var jobId:String?
    var jobName:String?
    var user = PFUser.current()
    var a = [String]()
    var b = [String]()


    @IBOutlet weak var AddCommentField: UITextField!
    
    @IBAction func SendButton(_ sender: Any) {
        
        let username = user?["username"] as! String
        let query = PFQuery(className:"Comments")
        query.whereKey("jobId", equalTo: jobId!)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {

                if(objects.isEmpty){ //If comment object doesn't exist create new object
                    var a = [String]()
                    var b = [String]()
                    a.append(username)
                    b.append(self.AddCommentField.text!)
                    let comment = PFObject(className:"Comments")
                    comment["name"] = a
                    comment["comment"] = b
                    comment["jobId"] = self.jobId
                    comment.saveInBackground { (succeeded, error)  in
                        if (succeeded) {
                            print("Comment addded")
                        } else {
                            print("Error")
                        }
                    }
                } else{ //Else update existing comment object with new comment

                    for object in objects {
                        query.getObjectInBackground(withId: object.objectId!) { (comment: PFObject?, error: Error?) in
                            if let error = error {
                                print(error.localizedDescription)
                            } else if let comment = comment {
                                var a = [String]()
                                var b = [String]()
                                a = comment["name"] as! [String]
                                b = comment["comment"] as! [String]
                                a.append(username)
                                b.append(self.AddCommentField.text!)
                                comment["name"] = a
                                comment["comment"] = b
                                comment.saveInBackground()
                                self.table.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
        
    @IBOutlet weak var table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return a.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Loads comments if available
        let query = PFQuery(className: "Comments")
        query.whereKey("jobId", equalTo: jobId!)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
                    self.a += object["name"] as! [String]
                    self.b += object["comment"] as! [String]
                }
                self.table.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell

        if(a.count == 0){
            cell.userNameLabel.text = ""
            cell.commentLabel.text = ""
            return cell
        } else{
            let name = a[indexPath.row]
            let comment = b[indexPath.row]
            cell.userNameLabel.text = name
            cell.commentLabel.text = comment
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobNameLabel.text = jobName
        table.delegate = self
        table.dataSource = self
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

