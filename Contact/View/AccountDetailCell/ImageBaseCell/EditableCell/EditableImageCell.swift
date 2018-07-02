//
//  EditableImageCell.swift
//  Contact
//
//  Created by Saeedeh on 02/07/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import UIKit

class EditableImageCell: UITableViewCell {

    @IBOutlet var holderView: UIView!
    @IBOutlet var selectImageBtn: UIButton!

    @IBOutlet var valueImage: UIImageView!
    
    var delegate: ImagePickerDelegate! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func selectImageClicked(_ sender: Any) {
        
        delegate.pickImage(cell: self)
    }
}
