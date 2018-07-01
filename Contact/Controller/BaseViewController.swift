//
//  BaseViewController.swift
//  Contact
//
//  Created by Saeedeh on 01/07/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func handleError(error: Error) {
        
        let alert = UIAlertController(title: "Message", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
  
    }

}
