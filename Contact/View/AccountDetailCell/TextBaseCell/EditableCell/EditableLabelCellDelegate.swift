//
//  EditableLabelCellDelegate.swift
//  Contact
//
//  Created by Saeedeh on 02/07/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import Foundation
import UIKit

protocol EditableLabelCellDelegate {
    func textFieldDidEndEditing(cell: EditableLabelCell, value: String) -> ()
}
