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
    
    var companyContactUnderTest:CompanyContact!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        companyContactUnderTest=CompanyContact.sharedInstance
    }
    
    override func tearDown() {

        // Put teardown code here. This method is called after the invocation of each test method in the class.
        companyContactUnderTest=nil
        super.tearDown()
    }
    
//****** MARK: NetworkService  tests:
    func testNetworkService(){
        
        let urlStringUnderTest="https://firebasestorage.googleapis.com/v0/b/contacts-8d05b.appspot.com/o/contacts.json?alt=media&token=431c2754-b3f9-4485-8c5d-0365d5f8f0e5"
        let e = expectation(description: "complationHandler handler invoked")
        let url=URL(string:urlStringUnderTest)!
        
        NetworkService.request(url: url) { (reply) in
            switch reply{
            case .success(let data):
                XCTAssertNotNil(data, "Expected Data, received :nil")
            case .failure(let error):
                XCTAssert(false, "Expected Data, received :\(error)")
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 15.0, handler: nil)

    }
    
    func testNetworkServiceWithUnreachableUrl(){
        
        let unreachableUrlStringUnderTest="http://doesNotExsiturl.org"
        let e = expectation(description: "complationHandler handler invoked")
        let url=URL(string:unreachableUrlStringUnderTest)!
        
        NetworkService.request(url: url) { (reply) in
            switch reply{
            case .success(let data):
                 XCTAssert(false, "Expected error, received :\(data)")
            case .failure(let error):
                XCTAssertNotNil(error, "Expected error, received :nil")
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 15.0, handler: nil)
        
    }
    
    /**turn OFF your internet connection to perform this test**/
    func testNetworkServiceWithNoInternetConnection(){
        
        let notChachedUrlStrinUnderTest="http://musicbrainz.org/ws/2/place/?query=notCached&limit=20&offset=0&fmt=json"
        let e = expectation(description: "complationHandler handler invoked")
        let url=URL(string:notChachedUrlStrinUnderTest)!
        
        NetworkService.request(url: url) { (reply) in
            switch reply{
            case .success(let data):
                XCTAssert(false, "Expected error, received :\(data)")
            case .failure(let error):
                XCTAssertNotNil(error, "Expected error, received :nil")
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 30.0, handler: nil)
        
    }
//****** MARK: Account Class tests:
    func testAccountIsArrayEmpty(){
        
        let accountUnderTest=Account(accountId: "AccountUnderTest")
        //1. test with an empty array
        let emptyArr=[Value]()
        let result=accountUnderTest.exposePrivateIsArrayEmpty(emptyArr)
        XCTAssertTrue(result, "Expected true, received:\(result)")
        
        //2. test with a none empty array that has no selected value
        let unselectedValue=Value(data:"test")
        unselectedValue.selected=false
        
        var noneEmptyArr=[Value]()
        noneEmptyArr.append(unselectedValue)
        
        let resultNoneEmptyArr=accountUnderTest.exposePrivateIsArrayEmpty(noneEmptyArr)
        XCTAssertTrue(resultNoneEmptyArr, "Expected true, received:\(resultNoneEmptyArr)")
        
        //3. test with a none empty array that has a selected value
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

        //2. test with a complete account
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
        
        // confirm that the account contain both selected and unselected values before save getting called:
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
        
        //confirm that the save function has removed all unselected values:
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
    
//****** MARK: CompanyContact Class tests:
    
    func testCompanyContactDecodeContactsFromData(){
        
        //1. test it with a valid json (in a format that we expect to get from api)
        let jsonString="{\"d\": {\"results\": [{\"Account\": \"accountUnderTest\",\"BusinessEmail\": \"maul.mm@mail.com\",\"BusinessPhone\": \"+60123456789\",\"BusinessMobile\": null,\"Email\": \"personalmaul.mm@mail.com\", \"FirstName\": \"Anton\",\"FullName\": \"Anton De Boer\",\"Gender\": \"M\",\"ID\": \"1415c43e-00d5-4640-aada-0759c297b3a9\",\"JobTitleDescription\": \"Controller\",\"LastName\": \"Boer\",\"MiddleName\": \"De\",\"Mobile\": \"+60123456779\", \"Notes\": \"new notes\",\"Phone\": \"+60123456799\",\"PictureThumbnailUrl\": null},{\"Account\": \"accountUnderTest2\",\"BusinessEmail\": \"maul.mm2@mail.com\",\"BusinessPhone\": \"+60123456782\",\"BusinessMobile\": \"0123456793\",\"Email\": \"personalmaul.mm2@mail.com\", \"FirstName\": \"Anton2\",\"FullName\": \"Anton De Boer2\",\"Gender\": \"F\",\"ID\": \"1415c43e-00d5-4640-aada-0759c297b3a92\",\"JobTitleDescription\": \"Controller2\",\"LastName\": \"Boer2\",\"MiddleName\": \"De2\",\"Mobile\": \"+60123456772\", \"Notes\": \"new notes2\",\"Phone\": \"+60123456792\",\"PictureThumbnailUrl\": \"https://firebasestorage.googleapis.com/v0/b/contacts-8d05b.appspot.com/o/contact-thumb.png?alt=media&token=d68298eb-9879-4c9a-8319-5ef0a9eb3c57\"}]}}"
        
        
        guard let data=jsonString.data(using:.utf8) else{
            XCTAssert(false, "Expected Data, received nil")
            return
        }
   
        let resultFromValidData=companyContactUnderTest.exposePrivateDecodeContactsData(data: data)
        // expect it to success
        XCTAssert(try resultFromValidData.assertIsSuccess())
        
        switch resultFromValidData {
            
        case .success(let contactList):
            XCTAssertEqual(2, contactList.count)
            let account1=contactList[0]
            let account2=contactList[1]
            // check account values if they are same as jason
            XCTAssertEqual(account1.accountId, "accountUnderTest")
            XCTAssertEqual(account1.businessEmail[0].data, "maul.mm@mail.com")
            XCTAssertEqual(account1.businessPhone[0].data, "+60123456789")
            XCTAssertEqual(account1.email[0].data, "personalmaul.mm@mail.com")
            XCTAssertEqual(account1.firstName[0].data, "Anton")
            XCTAssertEqual(account1.fullName[0].data, "Anton De Boer")
            XCTAssertEqual(account1.gender[0].data, "M")
            XCTAssertEqual(account1.id[0].data, "1415c43e-00d5-4640-aada-0759c297b3a9")
            XCTAssertEqual(account1.jobTitleDescription[0].data, "Controller")
            XCTAssertEqual(account1.lastName[0].data, "Boer")
            XCTAssertEqual(account1.middleName[0].data, "De")
            XCTAssertEqual(account1.mobile[0].data, "+60123456779")
            XCTAssertEqual(account1.notes[0].data, "new notes")
            XCTAssertEqual(account1.phone[0].data, "+60123456799")
            
            XCTAssertEqual(account2.accountId, "accountUnderTest2")
            XCTAssertEqual(account2.businessEmail[0].data, "maul.mm2@mail.com")
            XCTAssertEqual(account2.businessPhone[0].data, "+60123456782")
            XCTAssertEqual(account2.businessMobile[0].data, "0123456793")
            XCTAssertEqual(account2.email[0].data, "personalmaul.mm2@mail.com")
            XCTAssertEqual(account2.firstName[0].data, "Anton2")
            XCTAssertEqual(account2.fullName[0].data, "Anton De Boer2")
            XCTAssertEqual(account2.gender[0].data, "F")
            XCTAssertEqual(account2.id[0].data, "1415c43e-00d5-4640-aada-0759c297b3a92")
            XCTAssertEqual(account2.jobTitleDescription[0].data, "Controller2")
            XCTAssertEqual(account2.lastName[0].data, "Boer2")
            XCTAssertEqual(account2.middleName[0].data, "De2")
            XCTAssertEqual(account2.mobile[0].data, "+60123456772")
            XCTAssertEqual(account2.notes[0].data, "new notes2")
            XCTAssertEqual(account2.phone[0].data, "+60123456792")
            XCTAssertEqual(account2.pictureThumbnailUrl[0].data, "https://firebasestorage.googleapis.com/v0/b/contacts-8d05b.appspot.com/o/contact-thumb.png?alt=media&token=d68298eb-9879-4c9a-8319-5ef0a9eb3c57")
            
        case .failure(let error):
            XCTAssert(false, "Expected [Account], received :\(error)")
        }
    
        //2. test  with a not valid json (d is missing from the input json), this will covert emty string as well
        let wrongJsonString="{\"results\": [{\"Account\": \"accountUnderTest\",\"BusinessEmail\": \"maul.mm@mail.com\",\"BusinessPhone\": \"+60123456789\",\"BusinessMobile\": null,\"Email\": \"personalmaul.mm@mail.com\", \"FirstName\": \"Anton\",\"FullName\": \"Anton De Boer\",\"Gender\": \"M\",\"ID\": \"1415c43e-00d5-4640-aada-0759c297b3a9\",\"JobTitleDescription\": \"Controller\",\"LastName\": \"Boer\",\"MiddleName\": \"De\",\"Mobile\": \"+60123456779\", \"Notes\": \"new notes\",\"Phone\": \"+60123456799\",\"PictureThumbnailUrl\": null},{\"Account\": \"accountUnderTest2\",\"BusinessEmail\": \"maul.mm2@mail.com\",\"BusinessPhone\": \"+60123456782\",\"BusinessMobile\": \"0123456793\",\"Email\": \"personalmaul.mm2@mail.com\", \"FirstName\": \"Anton2\",\"FullName\": \"Anton De Boer2\",\"Gender\": \"F\",\"ID\": \"1415c43e-00d5-4640-aada-0759c297b3a92\",\"JobTitleDescription\": \"Controller2\",\"LastName\": \"Boer2\",\"MiddleName\": \"De2\",\"Mobile\": \"+60123456772\", \"Notes\": \"new notes2\",\"Phone\": \"+60123456792\",\"PictureThumbnailUrl\": \"https://firebasestorage.googleapis.com/v0/b/contacts-8d05b.appspot.com/o/contact-thumb.png?alt=media&token=d68298eb-9879-4c9a-8319-5ef0a9eb3c57\"}]}"
        
        guard let wrongData=wrongJsonString.data(using:.utf8) else{
            XCTAssert(false, "Expected Data, received nil")
            return
        }
        let resultFromNotValidData=companyContactUnderTest.exposePrivateDecodeContactsData(data: wrongData)
        // expect it to fail
        XCTAssert(try resultFromNotValidData.assertIsFailure())
        
        switch resultFromNotValidData {
            
        case .success(let contactList):
            XCTAssert(false, "Expected error, received :\(contactList)")
        case .failure(let error):
            XCTAssertNotNil(error,"Expected error, received :nil")
          
        }
        
        //3. test when the results array receiving from api is empty
        
        let emptyResultjsonString="{\"d\": {\"results\": []}}"
        guard let emptyResultData=emptyResultjsonString.data(using:.utf8) else{
            XCTAssert(false, "Expected Data, received nil")
            return
        }
        
        let resultFromEmptyResult=companyContactUnderTest.exposePrivateDecodeContactsData(data: emptyResultData)
        // expect it to success with an empty array
        XCTAssert(try resultFromEmptyResult.assertIsSuccess())
        
        switch resultFromEmptyResult {
            
        case .success(let contactList):
            XCTAssertEqual(contactList.count, 0,"Expected 0, received :\(contactList.count)")
        case .failure(let error):
              XCTAssert(false, "Expected [Account], received :\(error)")
        }
        
    }

    func testCompanyContactMergeSimilarAccounts(){

        let account=Account(accountId: "similarAccount")
        let similarAccount=Account(accountId: "similarAccount")
        let differentAccount=Account(accountId: "differentAccount")
        
        // 1. test with an empty list
        let emptyList=[Account]()
        let mergedEmptyList=companyContactUnderTest.exposePrivateMergeSimilarAccounts(accountsList:emptyList)

        XCTAssertEqual(mergedEmptyList.count, 0,"Expected 0, received :\(mergedEmptyList.count)")

         // 2. test when the original list does not contain any similar account objects
        var listWithNoSimilarAccount=[Account]()
            // fill the array with two different account
        listWithNoSimilarAccount.append(account)
        listWithNoSimilarAccount.append(differentAccount)
        
        let mergedListWithNoSimilarAcc=companyContactUnderTest.exposePrivateMergeSimilarAccounts(accountsList: listWithNoSimilarAccount)
        XCTAssertEqual(mergedListWithNoSimilarAcc.count, 2,"Expected 2, received :\(mergedListWithNoSimilarAcc.count)")
        
        // 3. test when the original list contains  similar account objects
        var listWithSimilarAccount=[Account]()
        // fill the array with same account objects
        listWithSimilarAccount.append(account)
        listWithSimilarAccount.append(similarAccount)
        
        let mergedListWithSimilarAccount=companyContactUnderTest.exposePrivateMergeSimilarAccounts(accountsList:listWithSimilarAccount)
        XCTAssertEqual(mergedListWithSimilarAccount.count, 1,"Expected 1, received :\(mergedListWithSimilarAccount.count)")

    }
    /**turn ON your internet connection to perform this test**/
    func testCompanyContactFetchContacts(){
        
        let e = expectation(description: "complationHandler handler invoked")
        companyContactUnderTest.fetchContacts() { (reply) in
            
            switch reply{
            case .success(let data):
                let accountListSize=data.count
                XCTAssertTrue(accountListSize>0,"Expected an [Account] with a size > 0, received [Account] with size:\(accountListSize)")
            case .failure(let error):
                XCTAssert(false, "Expected [Account], received :\(error)")
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 30.0, handler: nil)
        
    }
    
    /**turn OFF your internet connection to perform this test**/
    func testCompanyContactFetchContactsWithNoInternet(){
        
        let e = expectation(description: "complationHandler handler invoked")
        companyContactUnderTest.fetchContacts() { (reply) in
            
            switch reply{
            case .success(let data):
                XCTAssert(false, "Expected error, received :\(data)")
            case .failure(let error):
                XCTAssertNotNil(error, "Expected error, received :nil")
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 30.0, handler: nil)
    }
}

//****** MARK: Helpers
private extension Result {
    
    func assertIsSuccess() throws -> Bool {
        switch self {
        case .success(_):
            return true
        case .failure(_):
            let error = NSError(domain: "Result", code: 0, userInfo: [NSLocalizedDescriptionKey :"Expected .success, received :\(self)"])
            throw error
        }
    }
    func assertIsFailure() throws -> Bool {
        switch self {
        case .success(_):
            let error = NSError(domain: "Result", code: 0, userInfo: [NSLocalizedDescriptionKey :"Expected .failure, received :\(self)"])
            throw error
        case .failure(_):
            return true
        }
    }
}


