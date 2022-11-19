//
//  JobActivityCell.swift
//  TaskScheduler
//
//  Created by Enrique Delgado on 11/19/22.
//

import UIKit

class JobActivityCell: UITableViewCell {

    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
