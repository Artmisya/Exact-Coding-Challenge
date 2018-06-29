//
//  Contact.swift
//  Contact
//
//  Created by Saeedeh on 27/06/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import Foundation

class Account:Decodable {
    
    let accountId:String
    var businessEmail=[Value]()
    var businessPhone=[Value]()
    var businessMobile=[Value]()
    var email=[Value]()
    var firstName=[Value]()
    var fullName=[Value]()
    var gender=[Value]()
    var id=[Value]()
    var jobTitleDescription=[Value]()
    var lastName=[Value]()
    var middleName=[Value]()
    var mobile=[Value]()
    var notes=[Value]()
    var phone=[Value]()
    var pictureThumbnailUrl=[Value]()
    
    private var incomplete:Bool=false
    private var mismatched:Bool=false
    
    private enum CodingKeys: String, CodingKey {
        
        case accountId = "Account"
        case businessEmail = "BusinessEmail"
        case businessPhone = "BusinessPhone"
        case businessMobile = "BusinessMobile"
        case email = "Email"
        case firstName = "FirstName"
        case fullName = "FullName"
        case gender = "Gender"
        case id = "ID"
        case jobTitleDescription = "JobTitleDescription"
        case lastName = "LastName"
        case middleName = "MiddleName"
        case mobile = "Mobile"
        case notes = "Notes"
        case phone = "Phone"
        case pictureThumbnailUrl = "PictureThumbnailUrl"
    }
    

    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        accountId = try container.decode(String.self, forKey: .accountId)
        
        if let businessEmailData = try container.decodeIfPresent(String.self, forKey: .businessEmail)
              ,businessEmailData != ""  {
             businessEmail.append(Value(data:businessEmailData))
        }
        if let businessPhoneData = try container.decodeIfPresent(String.self, forKey: .businessPhone)
                ,businessPhoneData != ""  {
             businessPhone.append(Value(data: businessPhoneData))
        }
        if let businessMobileData  = try container.decodeIfPresent(String.self, forKey: .businessMobile)
                ,businessMobileData != ""  {
                businessMobile.append(Value(data: businessMobileData))
        }
        if let emailData = try container.decodeIfPresent(String.self, forKey: .email)
                ,emailData != ""  {
             email.append(Value(data: emailData))
        }
        if let firstNameData = try container.decodeIfPresent(String.self, forKey: .firstName)
                ,firstNameData != ""  {
                firstName.append(Value(data: firstNameData))
        }
        if let fullNameData = try container.decodeIfPresent(String.self, forKey: .fullName)
                ,fullNameData != ""  {

                fullName.append(Value(data: fullNameData))
        }
        if let idData = try container.decodeIfPresent(String.self, forKey: .id)
                ,idData != ""  {
                id.append(Value(data: idData))
        }
        if let genderData = try container.decodeIfPresent(String.self, forKey: .gender)
                ,genderData != ""  {
                gender.append(Value(data: genderData))
        }
        if let lastNameData = try container.decodeIfPresent(String.self, forKey: .lastName)
                ,lastNameData != ""  {
                lastName.append(Value(data: lastNameData))
        }
        if let middleNameData = try container.decodeIfPresent(String.self, forKey: .middleName)
                ,middleNameData != ""  {
                middleName.append(Value(data: middleNameData))
        }
        if let jobTitleDescriptionData = try container.decodeIfPresent(String.self,forKey: .jobTitleDescription)
                 ,jobTitleDescriptionData != ""  {
                jobTitleDescription.append(Value(data: jobTitleDescriptionData))
        }
        if let mobileData = try container.decodeIfPresent(String.self, forKey: .mobile)
                ,mobileData != ""  {
                mobile.append(Value(data: mobileData))
        }
        if let notesData = try container.decodeIfPresent(String.self, forKey: .notes)
                ,notesData != ""  {
                notes.append(Value(data: notesData))
        }
        if let phoneData = try container.decodeIfPresent(String.self, forKey: .phone)
                ,phoneData != ""  {
                phone.append(Value(data: phoneData))
        }
        if let pictureThumbnailUrlData = try container.decodeIfPresent(String.self, forKey: .pictureThumbnailUrl)
                ,pictureThumbnailUrlData != ""  {
                pictureThumbnailUrl.append(Value(data: pictureThumbnailUrlData))
        }
    }

//    init(account:String,businessEmail:[Value],businessPhone:[Value],
//         businessMobile:[Value],email:[Value],firstName:[Value],
//         fullName:[Value],gender:[Value],id:[Value],
//         jobTitleDescription:[Value],lastName:[Value],
//         middleName:[Value],mobile:[Value],notes:[Value],
//         phone:[Value],pictureThumbnailUrl:[Value]){
//
//        self.account=account
//        self.businessEmail=businessEmail
//        self.businessPhone=businessPhone
//        self.businessMobile=businessMobile
//        self.email=email
//        self.firstName=firstName
//        self.fullName=fullName
//        self.gender=gender
//        self.id=id
//        self.jobTitleDescription=jobTitleDescription
//        self.lastName=lastName
//        self.middleName=middleName
//        self.mobile=mobile
//        self.notes=notes
//        self.phone=phone
//        self.pictureThumbnailUrl=pictureThumbnailUrl
//
//    }
    
    /* this fuction merge two similar account objects into one.
        (two account objects consider similar if their accountId field have same value)
     */
    func merge(account:Account){
        
        if account.businessEmail.count > 0 , self.businessEmail.contains(where:{$0.data == account.businessEmail[0].data})==false{
            
            self.businessEmail.append(account.businessEmail[0])
            
            // set selected to false , let user decide which value is correct
            account.businessEmail[0].selected=false
            self.businessEmail[0].selected=false
            self.mismatched=true
            
        }
        if account.businessPhone.count > 0 , self.businessPhone.contains(where:{$0.data == account.businessPhone[0].data})==false{
            
            self.businessPhone.append(account.businessPhone[0])
            
             // set selected to false , let user decide which value is correct
            account.businessPhone[0].selected=false
            self.businessPhone[0].selected=false
            self.mismatched=true
            
        }
        if account.businessPhone.count > 0 ,self.businessMobile.contains(where:{$0.data == account.businessMobile[0].data})==false{
            
            self.businessMobile.append(account.businessMobile[0])
            
             // set selected to false , let user decide which value is correct
            account.businessMobile[0].selected=false
            self.businessMobile[0].selected=false
            self.mismatched=true
            
        }
        if account.email.count > 0 ,self.email.contains(where:{$0.data == account.email[0].data})==false{
            
            self.email.append(account.email[0])
            
             // set selected to false , let user decide which value is correct
            account.email[0].selected=false
            self.email[0].selected=false
            self.mismatched=true
            
        }
        if account.firstName.count > 0 ,self.firstName.contains(where:{$0.data == account.firstName[0].data})==false{
            
            self.firstName.append(account.firstName[0])
            
             // set selected to false , let user decide which value is correct
            account.firstName[0].selected=false
            self.firstName[0].selected=false
            self.mismatched=true
            
        }
        if account.fullName.count > 0 ,self.fullName.contains(where:{$0.data == account.fullName[0].data})==false{
            
            self.fullName.append(account.fullName[0])
            
             // set selected to false , let user decide which value is correct
            account.fullName[0].selected=false
            self.fullName[0].selected=false
            self.mismatched=true
            
        }
        if account.gender.count > 0 ,self.gender.contains(where:{$0.data == account.gender[0].data})==false{
            
            self.gender.append(account.gender[0])
            
             // set selected to false , let user decide which value is correct
            account.gender[0].selected=false
            self.gender[0].selected=false
            self.mismatched=true
            
        }
        if account.id.count > 0 ,self.id.contains(where:{$0.data == account.id[0].data})==false{
            
            self.id.append(account.id[0])
            
             // set selected to false , let user decide which value is correct
            account.id[0].selected=false
            self.id[0].selected=false
            self.mismatched=true
            
        }
        if account.jobTitleDescription.count > 0 , self.jobTitleDescription.contains(where:{$0.data == account.jobTitleDescription[0].data})==false{
            
            self.jobTitleDescription.append(account.jobTitleDescription[0])
            
             // set selected to false , let user decide which value is correct
            account.jobTitleDescription[0].selected=false
            self.jobTitleDescription[0].selected=false
            self.mismatched=true
            
        }
        if account.lastName.count > 0 ,self.lastName.contains(where:{$0.data == account.lastName[0].data})==false{
            
            self.lastName.append(account.lastName[0])
            
             // set selected to false , let user decide which value is correct
            account.lastName[0].selected=false
            self.lastName[0].selected=false
            self.mismatched=true
            
        }
        if account.middleName.count > 0 ,self.middleName.contains(where:{$0.data == account.middleName[0].data})==false{
            
            self.middleName.append(account.middleName[0])
            
             // set selected to false , let user decide which value is correct
            account.middleName[0].selected=false
            self.middleName[0].selected=false
            self.mismatched=true
            
        }
        if account.mobile.count > 0 ,self.mobile.contains(where:{$0.data == account.mobile[0].data})==false{
            
            self.mobile.append(account.mobile[0])
            
             // set selected to false , let user decide which value is correct
            account.mobile[0].selected=false
            self.mobile[0].selected=false
            self.mismatched=true
            
        }
        if account.notes.count > 0 ,self.notes.contains(where:{$0.data == account.notes[0].data})==false{
            
            self.notes.append(account.notes[0])
            
             // set selected to false , let user decide which value is correct
            account.notes[0].selected=false
            self.notes[0].selected=false
            self.mismatched=true
            
        }
        if account.phone.count > 0 ,self.phone.contains(where:{$0.data == account.phone[0].data})==false{
            
            self.phone.append(account.phone[0])
            
             // set selected to false , let user decide which value is correct
            account.phone[0].selected=false
            self.phone[0].selected=false
            self.mismatched=true
            
        }
        
        if account.pictureThumbnailUrl.count > 0 ,self.pictureThumbnailUrl.contains(where:{$0.data == account.pictureThumbnailUrl[0].data})==false{
            
            self.pictureThumbnailUrl.append(account.pictureThumbnailUrl[0])
            
             // set selected to false , let user decide which value is correct
            account.pictureThumbnailUrl[0].selected=false
            self.pictureThumbnailUrl[0].selected=false
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



