//
//  EditableLabelCell.swift
//  Contact
//
//  Created by Saeedeh on 02/07/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import UIKit



class EditableLabelCell: UITableViewCell,UITextFieldDelegate {

    @IBOutlet var inputLabel: UITextField!
    var delegate: EditableLabelCellDelegate! = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        
        inputLabel.delegate = self
        inputLabel.returnKeyType = .done
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate.textFieldDidEndEditing(cell: self, value: textField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
