//
//  ContactListViewController.swift
//  Contact
//
//  Created by Saeedeh on 28/06/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import UIKit

class AccountListViewController: UIViewController {

    let companyContact = CompanyContact.sharedInstance
    var contactList=[Account]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        companyContact.fetchContacts(){ (result) in
            
            switch result{
                
            case .success(let data):
                print("*******",data)
                
                 for account in data{
                    
                    print(account.accountId)
                }
                
            case .failure(let error):
                
                print ("&&&&&&&",error)
               
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
