//
//  ImageCell.swift
//  Contact
//
//  Created by Saeedeh on 01/07/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet var holderView: UIView!
    @IBOutlet var selectImageBtn: UIButton!
    @IBOutlet var selectImageView: UIImageView!
    @IBOutlet var valueImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
