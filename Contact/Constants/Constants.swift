//
//  Constants.swift
//  Contact
//
//  Created by Saeedeh on 27/06/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import Foundation

struct Constants {
    
    struct ApiUrl{
        static let getContactsUrl:String="https://firebasestorage.googleapis.com/v0/b/contacts-8d05b.appspot.com/o/contacts.json?alt=media&token=431c2754-b3f9-4485-8c5d-0365d5f8f0e5"
    }

    struct ErrorMessage{
        
        static let badUrl:String="Bad Url"
        static let serverError:String="Server Error"
        static let unknownError="Whoops, something went wrong!"
 
    }
    struct DomainError{
        static let serverError:String="ServerError"
        static let httpError:String="HttpError"
        static let jsonError:String="jsonError"
    }
}
