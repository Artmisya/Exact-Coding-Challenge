//
//  ContactTests.swift
//  ContactTests
//
//  Created by Saeedeh on 27/06/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import XCTest
@testable import Contact

class ContactTests: XCTestCase {
    
    var accountUnderTest: Account!
    var companyContactUnderTest:CompanyContact!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        accountUnderTest=Account(accountId: "AccountUnderTest")
        companyContactUnderTest=CompanyContact.sharedInstance
    }
    
    override func tearDown() {

        // Put teardown code here. This method is called after the invocation of each test method in the class.
        accountUnderTest=nil
        companyContactUnderTest=nil
        super.tearDown()
    }
    
    func testAccountIsArrayEmpty(){
        
        //1. test with an empty array
        let emptyArr=[Value]()
        let result=accountUnderTest.exposePrivateIsArrayEmpty(emptyArr)
        XCTAssertTrue(result, "Expected true, received:\(result)")
        
        //2. test with none empty array that has no selected value
        let unselectedValue=Value(data:"test")
        unselectedValue.selected=false
        
        var noneEmptyArr=[Value]()
        noneEmptyArr.append(unselectedValue)
        
        let resultNoneEmptyArr=accountUnderTest.exposePrivateIsArrayEmpty(noneEmptyArr)
        XCTAssertTrue(resultNoneEmptyArr, "Expected true, received:\(resultNoneEmptyArr)")
        
        //3. test with none empty array that has a selected value
        let selectedValue=Value(data:"test")
        selectedValue.selected=true
        
        var noneEmptyArr_2=[Value]()
        noneEmptyArr_2.append(selectedValue)
        
        let resultNoneEmptyArr_2=accountUnderTest.exposePrivateIsArrayEmpty(noneEmptyArr_2)
        XCTAssertFalse(resultNoneEmptyArr_2, "Expected false, received:\(resultNoneEmptyArr_2)")
 
    }
    
    func testAccountIsIncomplete(){
        
         //1. test with an incomplete account
        let incompleteAcc=Account(accountId: "incompleteAccount")
        let resultIncompAcc=incompleteAcc.isIncomplete()
        XCTAssertTrue(resultIncompAcc, "Expected true, received:\(resultIncompAcc)")

        //2. test with an complete account
        let completeAcc=Account(accountId: "completeAccount")
            // create a selected value
        let selectedValue=Value(data:"test")
        selectedValue.selected=true
            // fill the compulsory fields for account object
        completeAcc.firstName.append(selectedValue)
        completeAcc.lastName.append(selectedValue)
        completeAcc.email.append(selectedValue)
        completeAcc.phone.append(selectedValue)
        completeAcc.pictureThumbnailUrl.append(selectedValue)
        
        let resultCompAcc=completeAcc.isIncomplete()
        XCTAssertFalse(resultCompAcc, "Expected false, received:\(resultCompAcc)")
    }
    
    func testAccountMerge(){
        
        let originalAcc=Account(accountId: "account")
        let similarAccWithSameValues=Account(accountId: "account")
        let similarAccWithDiffValues=Account(accountId: "account")
        
        // create an array of value
        let value=Value(data:"originalValue")
        
        // fill up the original account
        originalAcc.businessEmail.append(value)
        originalAcc.businessPhone.append(value)
        originalAcc.businessMobile.append(value)
        originalAcc.email.append(value)
        originalAcc.firstName.append(value)
        originalAcc.fullName.append(value)
        originalAcc.gender.append(value)
        originalAcc.id.append(value)
        originalAcc.jobTitleDescription.append(value)
        originalAcc.lastName.append(value)
        originalAcc.middleName.append(value)
        originalAcc.mobile.append(value)
         originalAcc.notes.append(value)
        originalAcc.phone.append(value)
        originalAcc.pictureThumbnailUrl.append(value)
        
        //1. test merge with an empty account
        originalAcc.merge(similarAccWithSameValues)
        let resultNotMismatch=originalAcc.isMismatched()
        XCTAssertFalse(resultNotMismatch, "Expected false, received:\(resultNotMismatch)")
        
        XCTAssertEqual(originalAcc.businessEmail.count,1, "Expected 1, received:\(originalAcc.businessEmail.count)")
        XCTAssertEqual(originalAcc.businessPhone.count,1, "Expected 1, received:\(originalAcc.businessPhone.count)")
        XCTAssertEqual(originalAcc.businessMobile.count,1, "Expected 1, received:\(originalAcc.businessMobile.count)")
        XCTAssertEqual(originalAcc.email.count,1, "Expected 1, received:\(originalAcc.email.count)")
        XCTAssertEqual(originalAcc.firstName.count,1, "Expected 1, received:\(originalAcc.firstName.count)")
        XCTAssertEqual(originalAcc.fullName.count,1, "Expected 1, received:\(originalAcc.fullName.count)")
        XCTAssertEqual(originalAcc.gender.count,1, "Expected 1, received:\(originalAcc.gender.count)")
        XCTAssertEqual(originalAcc.id.count,1, "Expected 1, received:\(originalAcc.id.count)")
        XCTAssertEqual(originalAcc.jobTitleDescription.count,1, "Expected 1, received:\(originalAcc.jobTitleDescription.count)")
        XCTAssertEqual(originalAcc.lastName.count,1, "Expected 1, received:\(originalAcc.lastName.count)")
        XCTAssertEqual(originalAcc.middleName.count,1, "Expected 1, received:\(originalAcc.middleName.count)")
        XCTAssertEqual(originalAcc.mobile.count,1, "Expected 1, received:\(originalAcc.mobile.count)")
        XCTAssertEqual(originalAcc.notes.count,1, "Expected 1, received:\(originalAcc.notes.count)")
        XCTAssertEqual(originalAcc.phone.count,1, "Expected 1, received:\(originalAcc.phone.count)")
        XCTAssertEqual(originalAcc.pictureThumbnailUrl.count,1, "Expected 1, received:\(originalAcc.pictureThumbnailUrl.count)")
        
        //2. test merge with a none empty account whitch has same values with original account
        
        let similatValue=Value(data:"originalValue")
        
            // fill up the similar account with with similar of values
        similarAccWithSameValues.businessEmail.append(similatValue)
        similarAccWithSameValues.businessPhone.append(similatValue)
        similarAccWithSameValues.businessMobile.append(similatValue)
        similarAccWithSameValues.email.append(similatValue)
        similarAccWithSameValues.firstName.append(similatValue)
        similarAccWithSameValues.fullName.append(similatValue)
        similarAccWithSameValues.gender.append(similatValue)
        similarAccWithSameValues.id.append(similatValue)
        similarAccWithSameValues.jobTitleDescription.append(similatValue)
        similarAccWithSameValues.lastName.append(similatValue)
        similarAccWithSameValues.middleName.append(similatValue)
        similarAccWithSameValues.mobile.append(similatValue)
        similarAccWithSameValues.notes.append(similatValue)
        similarAccWithSameValues.phone.append(similatValue)
        similarAccWithSameValues.pictureThumbnailUrl.append(similatValue)
            // go for merge
        originalAcc.merge(similarAccWithSameValues)
        let resultNotMismatch2=originalAcc.isMismatched()
        XCTAssertFalse(resultNotMismatch2, "Expected false, received:\(resultNotMismatch2)")
        
        XCTAssertEqual(originalAcc.businessEmail.count,1, "Expected 1, received:\(originalAcc.businessEmail.count)")
        XCTAssertEqual(originalAcc.businessPhone.count,1, "Expected 1, received:\(originalAcc.businessPhone.count)")
        XCTAssertEqual(originalAcc.businessMobile.count,1, "Expected 1, received:\(originalAcc.businessMobile.count)")
        XCTAssertEqual(originalAcc.email.count,1, "Expected 1, received:\(originalAcc.email.count)")
        XCTAssertEqual(originalAcc.firstName.count,1, "Expected 1, received:\(originalAcc.firstName.count)")
        XCTAssertEqual(originalAcc.fullName.count,1, "Expected 1, received:\(originalAcc.fullName.count)")
        XCTAssertEqual(originalAcc.gender.count,1, "Expected 1, received:\(originalAcc.gender.count)")
        XCTAssertEqual(originalAcc.id.count,1, "Expected 1, received:\(originalAcc.id.count)")
        XCTAssertEqual(originalAcc.jobTitleDescription.count,1, "Expected 1, received:\(originalAcc.jobTitleDescription.count)")
        XCTAssertEqual(originalAcc.lastName.count,1, "Expected 1, received:\(originalAcc.lastName.count)")
        XCTAssertEqual(originalAcc.middleName.count,1, "Expected 1, received:\(originalAcc.middleName.count)")
        XCTAssertEqual(originalAcc.mobile.count,1, "Expected 1, received:\(originalAcc.mobile.count)")
        XCTAssertEqual(originalAcc.notes.count,1, "Expected 1, received:\(originalAcc.notes.count)")
        XCTAssertEqual(originalAcc.phone.count,1, "Expected 1, received:\(originalAcc.phone.count)")
        XCTAssertEqual(originalAcc.pictureThumbnailUrl.count,1, "Expected 1, received:\(originalAcc.pictureThumbnailUrl.count)")
        
        //3. test merge with none empty account with has different values with original account
        
            // create of different value
        let diffValue=Value(data:"newValue")
 
            // fill up the similar account with different of values
        
        similarAccWithDiffValues.businessEmail.append(diffValue)
        similarAccWithDiffValues.businessPhone.append(diffValue)
        similarAccWithDiffValues.businessMobile.append(diffValue)
        similarAccWithDiffValues.email.append(diffValue)
        similarAccWithDiffValues.firstName.append(diffValue)
        similarAccWithDiffValues.fullName.append(diffValue)
        similarAccWithDiffValues.gender.append(diffValue)
        similarAccWithDiffValues.id.append(diffValue)
        similarAccWithDiffValues.jobTitleDescription.append(diffValue)
        similarAccWithDiffValues.lastName.append(diffValue)
        similarAccWithDiffValues.middleName.append(diffValue)
        similarAccWithDiffValues.mobile.append(diffValue)
        similarAccWithDiffValues.notes.append(diffValue)
        similarAccWithDiffValues.phone.append(diffValue)
        similarAccWithDiffValues.pictureThumbnailUrl.append(diffValue)
        
            // go for merge
        originalAcc.merge(similarAccWithDiffValues)
        let resultMismatch=originalAcc.isMismatched()
        XCTAssertTrue(resultMismatch, "Expected true, received:\(resultMismatch)")
        
        XCTAssertEqual(originalAcc.businessEmail.count,2, "Expected 2, received:\(originalAcc.businessEmail.count)")
        XCTAssertEqual(originalAcc.businessPhone.count,2, "Expected 2, received:\(originalAcc.businessPhone.count)")
        XCTAssertEqual(originalAcc.businessMobile.count,2, "Expected 2, received:\(originalAcc.businessMobile.count)")
        XCTAssertEqual(originalAcc.email.count,2, "Expected 0, received:\(originalAcc.email.count)")
        XCTAssertEqual(originalAcc.firstName.count,2, "Expected 2, received:\(originalAcc.firstName.count)")
        XCTAssertEqual(originalAcc.fullName.count,2, "Expected 2, received:\(originalAcc.fullName.count)")
        XCTAssertEqual(originalAcc.gender.count,2, "Expected 2, received:\(originalAcc.gender.count)")
        XCTAssertEqual(originalAcc.id.count,2, "Expected 2, received:\(originalAcc.id.count)")
        XCTAssertEqual(originalAcc.jobTitleDescription.count,2, "Expected 0, received:\(originalAcc.jobTitleDescription.count)")
        XCTAssertEqual(originalAcc.lastName.count,2, "Expected 2, received:\(originalAcc.lastName.count)")
        XCTAssertEqual(originalAcc.middleName.count,2, "Expected 2, received:\(originalAcc.middleName.count)")
        XCTAssertEqual(originalAcc.mobile.count,2, "Expected 2, received:\(originalAcc.mobile.count)")
        XCTAssertEqual(originalAcc.notes.count,2, "Expected 2, received:\(originalAcc.notes.count)")
        XCTAssertEqual(originalAcc.phone.count,2, "Expected 2, received:\(originalAcc.phone.count)")
        XCTAssertEqual(originalAcc.pictureThumbnailUrl.count,2, "Expected 2, received:\(originalAcc.pictureThumbnailUrl.count)")
        
    }
   
    func testAccountSave(){
        
        //1. test with an incomplete account :save should fail
        
        let incompleteAcc=Account(accountId: "incompleteAccount")
            // go for save
        let resultIncompleteAcc=incompleteAcc.save()
            // save should fail
        XCTAssert(try resultIncompleteAcc.assertIsFailure())
        
        //2. test with a complete account:save should be success
        
        let completeAcc=Account(accountId: "completeAccount")
        
            // create object values
        let selectedValue=Value(data:"selectedValue")
        selectedValue.selected=true
        
        let unselectedValue=Value(data:"unselectedValue")
        unselectedValue.selected=false
        
            // fill the account with selected values
        completeAcc.businessEmail.append(selectedValue)
        completeAcc.businessPhone.append(selectedValue)
        completeAcc.businessMobile.append(selectedValue)
        completeAcc.email.append(selectedValue)
        completeAcc.firstName.append(selectedValue)
        completeAcc.fullName.append(selectedValue)
        completeAcc.gender.append(selectedValue)
        completeAcc.id.append(selectedValue)
        completeAcc.jobTitleDescription.append(selectedValue)
        completeAcc.lastName.append(selectedValue)
        completeAcc.middleName.append(selectedValue)
        completeAcc.mobile.append(selectedValue)
        completeAcc.notes.append(selectedValue)
        completeAcc.phone.append(selectedValue)
        completeAcc.pictureThumbnailUrl.append(selectedValue)
        
        // fill the account with unselected values
        completeAcc.businessEmail.append(unselectedValue)
        completeAcc.businessPhone.append(unselectedValue)
        completeAcc.businessMobile.append(unselectedValue)
        completeAcc.email.append(unselectedValue)
        completeAcc.firstName.append(unselectedValue)
        completeAcc.fullName.append(unselectedValue)
        completeAcc.gender.append(unselectedValue)
        completeAcc.id.append(unselectedValue)
        completeAcc.jobTitleDescription.append(unselectedValue)
        completeAcc.lastName.append(unselectedValue)
        completeAcc.middleName.append(unselectedValue)
        completeAcc.mobile.append(unselectedValue)
        completeAcc.notes.append(unselectedValue)
        completeAcc.phone.append(unselectedValue)
        completeAcc.pictureThumbnailUrl.append(unselectedValue)
        
         // confirm that before save the account contain both selected and unselected values
        XCTAssertEqual(completeAcc.businessEmail.count,2, "Expected 2, received:\(completeAcc.businessEmail.count)")
        XCTAssertEqual(completeAcc.businessPhone.count,2, "Expected 2, received:\(completeAcc.businessPhone.count)")
        XCTAssertEqual(completeAcc.businessMobile.count,2, "Expected 2, received:\(completeAcc.businessMobile.count)")
        XCTAssertEqual(completeAcc.email.count,2, "Expected 2, received:\(completeAcc.email.count)")
        XCTAssertEqual(completeAcc.firstName.count,2, "Expected 2, received:\(completeAcc.firstName.count)")
        XCTAssertEqual(completeAcc.fullName.count,2, "Expected 2, received:\(completeAcc.fullName.count)")
        XCTAssertEqual(completeAcc.gender.count,2, "Expected 2, received:\(completeAcc.gender.count)")
        XCTAssertEqual(completeAcc.id.count,2, "Expected 2, received:\(completeAcc.id.count)")
        XCTAssertEqual(completeAcc.jobTitleDescription.count,2, "Expected 2, received:\(completeAcc.jobTitleDescription.count)")
        XCTAssertEqual(completeAcc.lastName.count,2, "Expected 2, received:\(completeAcc.lastName.count)")
        XCTAssertEqual(completeAcc.middleName.count,2, "Expected 2, received:\(completeAcc.middleName.count)")
        XCTAssertEqual(completeAcc.mobile.count,2, "Expected 2, received:\(completeAcc.mobile.count)")
        XCTAssertEqual(completeAcc.notes.count,2, "Expected 2, received:\(completeAcc.notes.count)")
        XCTAssertEqual(completeAcc.phone.count,2, "Expected 2, received:\(completeAcc.phone.count)")
        XCTAssertEqual(completeAcc.pictureThumbnailUrl.count,2, "Expected 2, received:\(completeAcc.pictureThumbnailUrl.count)")

            // go for save
        let resultCompleteAcc=completeAcc.save()
            // save should be success
        XCTAssert(try resultCompleteAcc.assertIsSuccess())
        
            // after save all unselected values shoule be removed
        XCTAssertEqual(completeAcc.businessEmail.count,1, "Expected 1, received:\(completeAcc.businessEmail.count)")
        XCTAssertEqual(completeAcc.businessPhone.count,1, "Expected 1, received:\(completeAcc.businessPhone.count)")
        XCTAssertEqual(completeAcc.businessMobile.count,1, "Expected 1, received:\(completeAcc.businessMobile.count)")
        XCTAssertEqual(completeAcc.email.count,1, "Expected 1, received:\(completeAcc.email.count)")
        XCTAssertEqual(completeAcc.firstName.count,1, "Expected 1, received:\(completeAcc.firstName.count)")
        XCTAssertEqual(completeAcc.fullName.count,1, "Expected 1, received:\(completeAcc.fullName.count)")
        XCTAssertEqual(completeAcc.gender.count,1, "Expected 1, received:\(completeAcc.gender.count)")
        XCTAssertEqual(completeAcc.id.count,1, "Expected 1, received:\(completeAcc.id.count)")
        XCTAssertEqual(completeAcc.jobTitleDescription.count,1, "Expected 1, received:\(completeAcc.jobTitleDescription.count)")
        XCTAssertEqual(completeAcc.lastName.count,1, "Expected 1, received:\(completeAcc.lastName.count)")
        XCTAssertEqual(completeAcc.middleName.count,1, "Expected 1, received:\(completeAcc.middleName.count)")
        XCTAssertEqual(completeAcc.mobile.count,1, "Expected 1, received:\(completeAcc.mobile.count)")
        XCTAssertEqual(completeAcc.notes.count,1, "Expected 1, received:\(completeAcc.notes.count)")
        XCTAssertEqual(completeAcc.phone.count,1, "Expected 1, received:\(completeAcc.phone.count)")
        XCTAssertEqual(completeAcc.pictureThumbnailUrl.count,1, "Expected 1, received:\(completeAcc.pictureThumbnailUrl.count)")
    }
    
    func testAccountDecodeFromData(){
        
        let jsonString="{\"Account\": \"accountUnderTest\",\"BusinessEmail\": \"maul.mm@mail.com\",\"BusinessPhone\": \"+60123456789\",\"BusinessMobile\": null,\"Email\": \"personalmaul.mm@mail.com\", \"FirstName\": \"Anton\",\"FullName\": \"Anton De Boer\",\"Gender\": \"M\",\"ID\": \"1415c43e-00d5-4640-aada-0759c297b3a9\",\"JobTitleDescription\": \"Controller\",\"LastName\": \"Boer\",\"MiddleName\": \"De\",\"Mobile\": \"+60123456779\", \"Notes\": \"new notes\",\"Phone\": \"+60123456799\",\"PictureThumbnailUrl\": null}"
        
        // create Data from string
        guard let data=jsonString.data(using:.utf8) else{
            XCTAssert(false, "Expected Data, received nil")
            return
        }
        // go for decode
        let jsonDecoder = JSONDecoder()
        
        do{
            let account=try jsonDecoder.decode(Account.self, from: data as Data)
            XCTAssertNotNil(account, "Expected Account object, received : nil")
            
                // size null values should be 0 and size none null values should be 1
            XCTAssertEqual(account.businessEmail.count,1, "Expected 1, received:\(account.businessEmail.count)")
            XCTAssertEqual(account.businessPhone.count,1, "Expected 1, received:\(account.businessPhone.count)")
            XCTAssertEqual(account.businessMobile.count,0, "Expected 0, received:\(account.businessMobile.count)")
            XCTAssertEqual(account.email.count,1, "Expected 1, received:\(account.email.count)")
            XCTAssertEqual(account.firstName.count,1, "Expected 1, received:\(account.firstName.count)")
            XCTAssertEqual(account.fullName.count,1, "Expected 1, received:\(account.fullName.count)")
            XCTAssertEqual(account.gender.count,1, "Expected 1, received:\(account.gender.count)")
            XCTAssertEqual(account.id.count,1, "Expected 1, received:\(account.id.count)")
            XCTAssertEqual(account.jobTitleDescription.count,1, "Expected 1, received:\(account.jobTitleDescription.count)")
            XCTAssertEqual(account.lastName.count,1, "Expected 1, received:\(account.lastName.count)")
            XCTAssertEqual(account.middleName.count,1, "Expected 1, received:\(account.middleName.count)")
            XCTAssertEqual(account.mobile.count,1, "Expected 1, received:\(account.mobile.count)")
            XCTAssertEqual(account.notes.count,1, "Expected 1, received:\(account.notes.count)")
            XCTAssertEqual(account.phone.count,1, "Expected 1, received:\(account.phone.count)")
            XCTAssertEqual(account.pictureThumbnailUrl.count,0, "Expected 0, received:\(account.pictureThumbnailUrl.count)")

                // check account values if they are same as jason
            XCTAssertEqual(account.accountId, "accountUnderTest")
            XCTAssertEqual(account.businessEmail[0].data, "maul.mm@mail.com")
            XCTAssertEqual(account.businessPhone[0].data, "+60123456789")
            XCTAssertEqual(account.email[0].data, "personalmaul.mm@mail.com")
            XCTAssertEqual(account.firstName[0].data, "Anton")
            XCTAssertEqual(account.fullName[0].data, "Anton De Boer")
            XCTAssertEqual(account.gender[0].data, "M")
            XCTAssertEqual(account.id[0].data, "1415c43e-00d5-4640-aada-0759c297b3a9")
            XCTAssertEqual(account.jobTitleDescription[0].data, "Controller")
            XCTAssertEqual(account.lastName[0].data, "Boer")
            XCTAssertEqual(account.middleName[0].data, "De")
            XCTAssertEqual(account.mobile[0].data, "+60123456779")
            XCTAssertEqual(account.notes[0].data, "new notes")
            XCTAssertEqual(account.phone[0].data, "+60123456799")
        }
        catch let error{
            XCTAssert(false, "Expected Account object, received :\(error)")
        }
    }
    

}

// MARK: Helpers
private extension Result {
    
    func assertIsSuccess() throws -> Bool {
        switch self {
        case .success(_):
            return true
        case .failure(_):
            
            throw ErrorType.generalError(message: "Expected .success, received :\(self)")
        }
    }
    func assertIsFailure() throws -> Bool {
        switch self {
        case .success(_):
            throw ErrorType.generalError(message: "Expected .failure, received :\(self)")
        case .failure(_):
            return true
        }
    }
}


