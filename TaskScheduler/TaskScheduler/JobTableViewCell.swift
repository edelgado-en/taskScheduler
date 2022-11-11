//
//  JobTableViewCell.swift
//  TaskScheduler
//
//  Created by Kyle Frudakis on 11/11/22.
//

import UIKit

class JobTableViewCell: UITableViewCell {

    
    @IBOutlet weak var JobNameLabel: UILabel!
    
    @IBOutlet weak var AssignedToLabel: UILabel!
    
    @IBOutlet weak var DueDateLabel: UILabel!
    
    @IBOutlet weak var AssignedNameLabel: UILabel!
    
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var StatusImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
