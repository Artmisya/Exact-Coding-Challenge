//
//  ContactData.swift
//  Contact
//
//  Created by Saeedeh on 27/06/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import Foundation

/* isUserInput indicates an userinput value, in case a key doesnot have any value
 code generate an userinput value for that key so later user can fill it
 */
class Value:Codable{
    
    var data:String
    var selected:Bool
   
    var isUserInput:Bool
    // in case user select an image
    var imageData:Data?
    
    init(data:String) {
        self.data=data
        selected=true
        isUserInput=false
    }
}
// in case user select an image
//class ImageValue:Value{
//
//    var imageData:Data?
//
//
//}
