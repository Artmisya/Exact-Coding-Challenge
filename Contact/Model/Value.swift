//
//  ContactData.swift
//  Contact
//
//  Created by Saeedeh on 27/06/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import Foundation


class Value:Codable{
    
    let data:String?
    var selected:Bool
    
    init(data:String?) {
        
        self.data=data
        selected=false
    }
    
}
