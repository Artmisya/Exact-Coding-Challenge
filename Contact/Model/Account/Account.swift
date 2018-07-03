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
    init(accountId:String) {
        
        self.accountId=accountId
    }
    
    /* this fuction merge the current account with a similar account object.
    (two account objects consider similar if their accountId field have a same value)
     note: that this function should not merge editable values
     */
    func merge(_ account:Account){
        
        if account.businessEmail.count > 0 , self.businessEmail.contains(where:{$0.data == account.businessEmail[0].data})==false{
            
            self.businessEmail.append(account.businessEmail[0])
            //if there is more than one value for this key set selected to false (user decide which value is correct)
            if (self.businessEmail.count>1){
                
                account.businessEmail[0].selected=false
            }
        }
        if account.businessPhone.count > 0 , self.businessPhone.contains(where:{$0.data == account.businessPhone[0].data})==false{
            
            self.businessPhone.append(account.businessPhone[0])
            //if there is more than one value for this key set selected to false (user decide which value is correct)
            if (self.businessPhone.count>1){
                
                account.businessPhone[0].selected=false
            }
        }
        if account.businessMobile.count > 0 ,self.businessMobile.contains(where:{$0.data == account.businessMobile[0].data})==false{
            
            self.businessMobile.append(account.businessMobile[0])
            //if there is more than one value for this key set selected to false (user decide which value is correct)
            if (self.businessMobile.count>1){
                
                account.businessPhone[0].selected=false
            }
        }
        if account.email.count > 0 ,self.email.contains(where:{$0.data == account.email[0].data})==false{
            
            self.email.append(account.email[0])
            //if there is more than one value for this key set selected to false (user decide which value is correct)
            if (self.email.count>1){
                
                account.email[0].selected=false
            }
        }
        if account.firstName.count > 0 ,self.firstName.contains(where:{$0.data == account.firstName[0].data})==false{
            
            self.firstName.append(account.firstName[0])
            //if there is more than one value for this key set selected to false (user decide which value is correct)
            if (self.firstName.count>1){
                
                account.firstName[0].selected=false
            }
        }
        if account.fullName.count > 0 ,self.fullName.contains(where:{$0.data == account.fullName[0].data})==false{
            
            self.fullName.append(account.fullName[0])
            //if there is more than one value for this key set selected to false (user decide which value is correct)
            if (self.fullName.count>1){
                
                account.fullName[0].selected=false
            }
        }
        if account.gender.count > 0 ,self.gender.contains(where:{$0.data == account.gender[0].data})==false{
            
            self.gender.append(account.gender[0])
            //if there is more than one value for this key set selected to false (user decide which value is correct)
            if (self.gender.count>1){
                
                account.gender[0].selected=false
            }
        }
        if account.id.count > 0 ,self.id.contains(where:{$0.data == account.id[0].data})==false{
            
            self.id.append(account.id[0])
            //if there is more than one value for this key set selected to false (user decide which value is correct)
            if (self.id.count>1){
                
                account.id[0].selected=false
            }
        }
        if account.jobTitleDescription.count > 0 ,self.jobTitleDescription.contains(where:{$0.data == account.jobTitleDescription[0].data})==false{
            
            self.jobTitleDescription.append(account.jobTitleDescription[0])
            //if there is more than one value for this key set selected to false (user decide which value is correct)
            if (self.jobTitleDescription.count>1){
                
                account.jobTitleDescription[0].selected=false
            }
        }
        if account.lastName.count > 0 ,self.lastName.contains(where:{$0.data == account.lastName[0].data})==false{
            
            self.lastName.append(account.lastName[0])
            //if there is more than one value for this key set selected to false (user decide which value is correct)
            if (self.lastName.count>1){
                account.lastName[0].selected=false
            }
        }
        if account.middleName.count > 0 ,self.middleName.contains(where:{$0.data == account.middleName[0].data})==false{
            
            self.middleName.append(account.middleName[0])
            //if there is more than one value for this key set selected to false (user decide which value is correct)
            if (self.middleName.count>1){
                account.middleName[0].selected=false
            }
        }
        if account.mobile.count > 0 ,self.mobile.contains(where:{$0.data == account.mobile[0].data})==false{
            
            self.mobile.append(account.mobile[0])
            //if there is more than one value for this key set selected to false (user decide which value is correct)
            if (self.mobile.count>1){
                
                account.mobile[0].selected=false
            }
        }
        if account.notes.count > 0 ,self.notes.contains(where:{$0.data == account.notes[0].data})==false{
            
            self.notes.append(account.notes[0])
            //if there is more than one value for this key set selected to false (user decide which value is correct)
            if (self.notes.count>1){
                
                account.notes[0].selected=false
            }
        }
        if account.phone.count > 0 ,self.phone.contains(where:{$0.data == account.phone[0].data})==false{
            
            self.phone.append(account.phone[0])
            //if there is more than one value for this key set selected to false (user decide which value is correct)
            if (self.phone.count>1){
                
                account.phone[0].selected=false
            }
        }
        
        if account.pictureThumbnailUrl.count > 0 ,self.pictureThumbnailUrl.contains(where:{$0.data == account.pictureThumbnailUrl[0].data})==false{
            
            self.pictureThumbnailUrl.append(account.pictureThumbnailUrl[0])
             //if there is more than one value for this key set selected to false (user decide which value is correct)
            if (self.pictureThumbnailUrl.count>1){
                
                account.pictureThumbnailUrl[0].selected=false
                
            }
        }
    }
    
    // this function check if a key doesnot have any value, add an user input value for that key, so later user can input data for that key
    func addUserInputValues(){
        
        if  businessEmail.count==0{
            
            let editableValue=Value(data: "")
            editableValue.isUserInput=true
            businessEmail.append(editableValue)
        }
        if  businessPhone.count==0{
            
            let editableValue=Value(data: "")
            editableValue.isUserInput=true
            businessPhone.append(editableValue)
        }
        if  businessMobile.count==0{
            
            let editableValue=Value(data: "")
            editableValue.isUserInput=true
            businessMobile.append(editableValue)
        }
        if  email.count==0{
            
            let editableValue=Value(data: "")
            editableValue.isUserInput=true
            email.append(editableValue)
        }
        if  firstName.count==0{
            
            let editableValue=Value(data: "")
            editableValue.isUserInput=true
            firstName.append(editableValue)
        }
        if  fullName.count==0{
            
            let editableValue=Value(data: "")
            editableValue.isUserInput=true
            fullName.append(editableValue)
        }
        if  gender.count==0{
            
            let editableValue=Value(data: "")
            editableValue.isUserInput=true
            gender.append(editableValue)
        }
        if  id.count==0{
            
            let editableValue=Value(data: "")
            editableValue.isUserInput=true
            id.append(editableValue)
        }
        if  jobTitleDescription.count==0{
            
            let editableValue=Value(data: "")
            editableValue.isUserInput=true
            jobTitleDescription.append(editableValue)
        }
        if  lastName.count==0{
            
            let editableValue=Value(data: "")
            editableValue.isUserInput=true
            lastName.append(editableValue)
        }
        if  middleName.count==0{
            
            let editableValue=Value(data: "")
            editableValue.isUserInput=true
            middleName.append(editableValue)
        }
        if  mobile.count==0{
            
            let editableValue=Value(data: "")
            editableValue.isUserInput=true
            mobile.append(editableValue)
        }
        if  notes.count==0{
            
            let editableValue=Value(data: "")
            editableValue.isUserInput=true
            notes.append(editableValue)
        }
        if  phone.count==0{
            
            let editableValue=Value(data: "")
            editableValue.isUserInput=true
            phone.append(editableValue)
        }
        if  pictureThumbnailUrl.count==0{
            
            let editableValue=Value(data: "")
            editableValue.isUserInput=true
            pictureThumbnailUrl.append(editableValue)
        }
        
    }
    func save() -> Result<Bool> {
        
        if (self.isIncomplete()){
            let error = NSError(domain: Constants.DomainError.account, code: 0, userInfo: [NSLocalizedDescriptionKey : Constants.Account.Message.accountCompulsoryFields])
            let result=Result<Bool>.failure(error)
            return result
        }
        // remove unselected values
        businessEmail=businessEmail.filter({ $0.selected == true })
        businessPhone=businessPhone.filter({ $0.selected == true })
        businessMobile=businessMobile.filter({ $0.selected == true })
        email=email.filter({ $0.selected == true })
        firstName=firstName.filter({ $0.selected == true })
        fullName=fullName.filter({ $0.selected == true })
        gender=gender.filter({ $0.selected == true })
        id=id.filter({ $0.selected == true })
        jobTitleDescription=jobTitleDescription.filter({ $0.selected == true })
        lastName=lastName.filter({ $0.selected == true })
        middleName=middleName.filter({ $0.selected == true })
        mobile=mobile.filter({ $0.selected == true })
        notes=notes.filter({ $0.selected == true })
        phone=phone.filter({ $0.selected == true })
        pictureThumbnailUrl=pictureThumbnailUrl.filter({ $0.selected == true })
        
        let result=Result.success(true)
        return result
    }
    
    func isMismatched()->Bool{
       
        if (businessEmail.count>1 ||
                businessPhone.count>1 ||
                businessMobile.count>1 ||
                email.count>1 ||
                firstName.count>1 ||
                gender.count>1 ||
                id.count>1 ||
                fullName.count>1 ||
                lastName.count>1 ||
                middleName.count>1 ||
                mobile.count>1 ||
                notes.count>1 ||
                phone.count>1 ||
                pictureThumbnailUrl.count>1){
            
            return true
        }
        
        return false
    }
    
    func isIncomplete()->Bool{
        //First name, Last name, Picture, Phone and Email
        if (isArrayEmpty(firstName) || isArrayEmpty(lastName)
            || isArrayEmpty(phone) || isArrayEmpty(email)
            || (isArrayEmpty(pictureThumbnailUrl))){
            
            return true
        }
        return false
    }
    
    func search (searchKeyword:String)->Bool{
        
        if (accountId.lowercased().contains(searchKeyword.lowercased())
            || businessEmail.contains(where:{$0.data.lowercased().range(of:searchKeyword.lowercased()) != nil})
            || businessPhone.contains(where:{$0.data.lowercased().range(of:searchKeyword.lowercased()) != nil})
            || businessMobile.contains(where:{$0.data.lowercased().range(of:searchKeyword.lowercased()) != nil})
            || email.contains(where:{$0.data.lowercased().range(of:searchKeyword.lowercased()) != nil})
            || firstName.contains(where:{$0.data.lowercased().range(of:searchKeyword.lowercased()) != nil})
            || gender.contains(where:{$0.data.lowercased().range(of:searchKeyword.lowercased()) != nil})
            || id.contains(where:{$0.data.lowercased().range(of:searchKeyword.lowercased()) != nil})
            || fullName.contains(where:{$0.data.lowercased().range(of:searchKeyword.lowercased()) != nil})
            || lastName.contains(where:{$0.data.lowercased().range(of:searchKeyword.lowercased()) != nil})
            || middleName.contains(where:{$0.data.lowercased().range(of:searchKeyword.lowercased()) != nil})
            || mobile.contains(where:{$0.data.lowercased().range(of:searchKeyword.lowercased()) != nil})
            || notes.contains(where:{$0.data.lowercased().range(of:searchKeyword.lowercased()) != nil})
            || phone.contains(where:{$0.data.lowercased().range(of:searchKeyword.lowercased()) != nil})){
            
            return true
        }
        return false
    }
    
    func getKeys()->[String]{
        return Constants.Account.Keys.KeyNames
    }
    func isKeyCompulsory(key:String)->Bool{
        switch key {
            case "firstName":
                return true
            case "lastName":
                return true
            case "phone":
                return true
            case "email":
                return true
            case "pictureThumbnailUrl":
                return true
            default:
                return false
        }
    }
    
    func getValues(forKey:String)->[Value]{
        
        switch forKey {
            
        case "businessEmail":
            return businessEmail
        case "businessPhone":
            return self.businessPhone
        case "businessMobile":
            return self.businessMobile
        case "email":
            return self.email
        case "firstName":
            return self.firstName
        case "middleName":
            return self.middleName
        case "lastName":
            return self.lastName
        case "fullName":
            return self.fullName
        case "gender":
            return self.gender
        case "id":
            return self.id
        case "jobTitleDescription":
            return self.jobTitleDescription
        case "mobile":
            return self.mobile
        case "phone":
            return self.phone
        case "notes":
            return self.notes
        case "pictureThumbnailUrl":
            return self.pictureThumbnailUrl
            
        default:
            
            // invalid key
            return []
        }
        
    }
    
 // MARK:- private functions
    private func isArrayEmpty(_ inputArray:[Value])->Bool{
        
        if inputArray.contains(where:{($0.isUserInput==false && $0.selected == true ) || ($0.isUserInput==true && ($0.data != "" || $0.imageData != nil))}){
            // has one  value with selected==true
            return false
        }
        // either the array is empty or has no value object with selected==true
        return true
    }
}

// MARK:- Expose Account private functions for unit test
#if DEBUG
extension Account {
    
    public func exposePrivateIsArrayEmpty(_ inputArray:[Value])->Bool {
        return self.isArrayEmpty(inputArray)
    }
    
}
#endif
