//
//  Constants.swift
//  Contact
//
//  Created by Saeedeh on 27/06/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct ApiUrl{
        static let getAccounts:String="https://firebasestorage.googleapis.com/v0/b/contacts-8d05b.appspot.com/o/contacts.json?alt=media&token=431c2754-b3f9-4485-8c5d-0365d5f8f0e5"
    }

    struct ErrorMessage{
        
        static let badUrl:String="Bad Url"
        static let serverError:String="Server Error"
        static let apiError:String="Data received from Api is not in a correct format."
        static let accountCompulsoryFields:String="Please make sure all compulsory fields are filled in."
        static let unknownError="Whoops, something went wrong!"
 
    }
    struct DomainError{
        static let server:String="ServerError"
        static let http:String="HttpError"
        static let json:String="jsonError"
        static let account:String="accountError"
        static let api:String="apiError"
    }
    
    
    struct Account {
        
        struct ColorIndicator{
            
            static let mismatch:UIColor = UIColor(red: 255.0/255, green: 206.0/255, blue: 91.0/255, alpha: 1.0)
            static let incomplete:UIColor = UIColor(red: 255.0/255, green: 38.0/255, blue: 0.0/255, alpha: 1.0)
            static let selectedValue:UIColor = UIColor(red: 143/255.0, green: 188.0/255.0, blue: 143.0/255.0, alpha: 1.0)
            static let unselectedValue:UIColor = UIColor.white
            static let compulsoryKey:UIColor = UIColor.red
        }
        
        struct Message {
            
            static let saveAccountSuccess="Saved Successfully!"
            static let deleteAccountSuccess="Removed Successfully!"
        }
        
        struct Keys{
            
            static let KeyNames = ["businessEmail","businessPhone","businessMobile","email","firstName","middleName","lastName","fullName","gender","id","jobTitleDescription","mobile","phone","notes","pictureThumbnailUrl"]
            
            static let ImageType="pictureThumbnailUrl"
        }
    }
    
}
