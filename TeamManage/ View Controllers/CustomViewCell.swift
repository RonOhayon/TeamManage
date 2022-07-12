//
//  CustomViewCell.swift
//  TeamManage
//
//  Created by user216780 on 7/9/22.
//

import UIKit

class CustomViewCell: UITableViewCell {

    @IBOutlet var taskLabel: UILabel!
    @IBOutlet var dateIssue: UILabel!
    @IBOutlet var dateTodo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
