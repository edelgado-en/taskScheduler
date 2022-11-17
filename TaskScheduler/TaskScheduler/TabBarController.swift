//
//  TabBarController.swift
//  TaskScheduler
//
//  Created by Izayah Hewell  on 11/12/22.
//

import UIKit
import Parse

class TabBarController: UITabBarController {

    var name:String?
    var assignedTo:PFUser? //was String?
    var createdBy:PFUser? //was String?
    var dueDate:Date? //was String?
    var isCompleted:Bool?
    var status:String?
    var desc:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let viewControllers = viewControllers else {
            return
        }
        
        //Passes data from tab bar controller to view controller
        for viewController in viewControllers {
            if let nc = viewController as? JobDetailsNavigationController {
                if let vc = nc.viewControllers.first as? JobDetailsViewController {
                    vc.name = name
                    vc.assignedTo = assignedTo
                    vc.createdBy = createdBy
                    vc.desc = desc
                    vc.dueDate = dueDate
                    vc.status = status
                    vc.isCompleted = isCompleted        
                }
            }
        }

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
