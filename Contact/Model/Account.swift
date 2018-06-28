//
//  Contact.swift
//  Contact
//
//  Created by Saeedeh on 27/06/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import Foundation


class Account:Codable {
    
    let account:String
    var businessEmail:[Value]
    var businessPhone:[Value]
    var businessMobile:[Value]
    var email:[Value]
    var firstName:[Value]
    var fullName:[Value]
    var gender:[Value]
    var id:[Value]
    var jobTitleDescription:[Value]
    var lastName:[Value]
    var middleName:[Value]
    var mobile:[Value]
    var notes:[Value]
    var phone:[Value]
    var pictureThumbnailUrl:[Value]
    
    private var incomplete:Bool=false
    private var mismatched:Bool=false

    
    init(account:String,businessEmail:[Value],businessPhone:[Value],
         businessMobile:[Value],email:[Value],firstName:[Value],
         fullName:[Value],gender:[Value],id:[Value],
         jobTitleDescription:[Value],lastName:[Value],
         middleName:[Value],mobile:[Value],notes:[Value],
         phone:[Value],pictureThumbnailUrl:[Value]){
        
        self.account=account
        self.businessEmail=businessEmail
        self.businessPhone=businessPhone
        self.businessMobile=businessMobile
        self.email=email
        self.firstName=firstName
        self.fullName=fullName
        self.gender=gender
        self.id=id
        self.jobTitleDescription=jobTitleDescription
        self.lastName=lastName
        self.middleName=middleName
        self.mobile=mobile
        self.notes=notes
        self.phone=phone
        self.pictureThumbnailUrl=pictureThumbnailUrl
        
    }
    
    func merge(contact:Contact){
        
        if self.businessEmail.contains(where:{$0.data == contact.businessEmail[0].data})==false{
            
            self.businessEmail.append(contact.businessEmail[0])
            self.mismatched=true
            
        }
        if self.businessPhone.contains(where:{$0.data == contact.businessPhone[0].data})==false{
            
            self.businessPhone.append(contact.businessPhone[0])
            self.mismatched=true
            
        }
        if self.businessMobile.contains(where:{$0.data == contact.businessMobile[0].data})==false{
            
            self.businessMobile.append(contact.businessMobile[0])
            self.mismatched=true
            
        }
        if self.email.contains(where:{$0.data == contact.email[0].data})==false{
            
            self.email.append(contact.email[0])
            self.mismatched=true
            
        }
        if self.firstName.contains(where:{$0.data == contact.firstName[0].data})==false{
            
            self.firstName.append(contact.firstName[0])
            self.mismatched=true
            
        }
        if self.fullName.contains(where:{$0.data == contact.fullName[0].data})==false{
            
            self.fullName.append(contact.fullName[0])
            self.mismatched=true
            
        }
        if self.gender.contains(where:{$0.data == contact.gender[0].data})==false{
            
            self.gender.append(contact.gender[0])
            self.mismatched=true
            
        }
        if self.id.contains(where:{$0.data == contact.id[0].data})==false{
            
            self.id.append(contact.id[0])
            self.mismatched=true
            
        }
        if self.jobTitleDescription.contains(where:{$0.data == contact.jobTitleDescription[0].data})==false{
            
            self.jobTitleDescription.append(contact.jobTitleDescription[0])
            self.mismatched=true
            
        }
        if self.lastName.contains(where:{$0.data == contact.lastName[0].data})==false{
            
            self.lastName.append(contact.lastName[0])
            self.mismatched=true
            
        }
        if self.middleName.contains(where:{$0.data == contact.middleName[0].data})==false{
            
            self.middleName.append(contact.middleName[0])
            self.mismatched=true
            
        }
        if self.mobile.contains(where:{$0.data == contact.mobile[0].data})==false{
            
            self.mobile.append(contact.mobile[0])
            self.mismatched=true
            
        }
        if self.notes.contains(where:{$0.data == contact.notes[0].data})==false{
            
            self.notes.append(contact.notes[0])
            self.mismatched=true
            
        }
        if self.phone.contains(where:{$0.data == contact.phone[0].data})==false{
            
            self.phone.append(contact.phone[0])
            self.mismatched=true
            
        }
        
        if self.pictureThumbnailUrl.contains(where:{$0.data == contact.pictureThumbnailUrl[0].data})==false{
            
            self.pictureThumbnailUrl.append(contact.pictureThumbnailUrl[0])
            self.mismatched=true
            
        }
        
    }
    
    func isMismatched()->Bool{
    
        return self.mismatched
    }
    
    func isIncomplete()->Bool{
        
        return self.incomplete
    }
    
}
