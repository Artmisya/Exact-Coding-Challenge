//
//  AccountCell.swift
//  Contact
//
//  Created by Saeedeh on 01/07/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {

    @IBOutlet var incompleteView: UIView!
    @IBOutlet var mismatchView: UIView!
    @IBOutlet var accountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
