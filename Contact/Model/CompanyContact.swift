//
//  ContactList.swift
//  Contact
//
//  Created by Saeedeh on 27/06/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import Foundation


final class CompanyContact{
    
    static let sharedInstance=CompanyContact()
    private init() {}
    
    private(set) var contactsList=[Account]()
    
    func fetchContacts(complationHandler:@escaping (Result<[Account]>) -> Void){
        
        guard let url=URL(string: Constants.ApiUrl.getContacts) else {
            
            let error=NSError(domain: Constants.DomainError.http, code: 0, userInfo: [NSLocalizedDescriptionKey : Constants.ErrorMessage.badUrl])
            
            let result=Result<[Account]>.failure(error)
            complationHandler(result)
            return
        }
        
        NetworkService.request(url: url) { (result) in

            switch result{

                case .success(let data):

                    self.createContactsListFromData(data:data)
                    let result=Result.success(self.contactsList)
                    complationHandler(result)

                case .failure(let error):
                    let result=Result<[Account]>.failure(error)
                    complationHandler(result)
            }
        }
        
        // create [Account] from Data received from API
       /* let resultCreateContactList=self.createContactsListFromData()
        switch resultCreateContactList {
            
            case .success(let data):
                // init the self.contactsList
                self.contactsList=data 
                let result=Result.success(self.contactsList)
                complationHandler(result)
            
            case .failure(let error):
                let result=Result<[Account]>.failure(error)
                complationHandler(result)
        }*/
      
    }
    
//    private func createContactsListFromData()->Result<[Account]>{
//
//            // first: decode Data into [Account]
//            let decodeResult=self.decodeContactsData()
//            switch decodeResult{
//
//                case .success(let data):
//                    let decodedContactsList = data
//                        // second: merge similar accounts into one account
//                        let mergedAccountsList=self.mergeSimilarAccounts(decodedContactsList)
//                        let result=Result.success(mergedAccountsList)
//                        return result
//
//                case .failure(let error):
//                    let result=Result<[Account]>.failure(error)
//                    return result
//            }
//    }
    private func createContactsListFromData(data:[String:Any])->Result<[Account]>{
        
        if let d=data["d"]  as? [String: Any]{

            if let results=d["results"] as?  [NSDictionary]{
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    
                    let resultsData=try JSONSerialization.data(withJSONObject: results, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
                    let decodedContactsList=try jsonDecoder.decode([Account].self, from: resultsData as Data)
                    
                    print ("******",contactsList[0].notes[0].data)
                } catch let error {
                    
                    let result=Result<[Account]>.failure(error)
                    return result
                }

//                let resultsData: Data = NSKeyedArchiver.archivedData(withRootObject: results[1]) as Data
//                let dictionary = NSKeyedUnarchiver.unarchiveObject(with: resultsData as Data) as? NSDictionary
//
//                let jsonDecoder = JSONDecoder()
//
//                do{
//
//                  //  resultsData=resultsData.removeLast()
//                   // String(data: bytes, encoding: .utf8)
//                    let jsonString=String(decoding: resultsData, as: UTF8.self)
//                    print("************",jsonString)
//                    print ("jjjjjjjjjjj",resultsData,dictionary.data)
//                    let contactsList=try jsonDecoder.decode(Account.self, from: resultsData)
//                }
//                catch let error{
//
//                    print (error)
//                }
            }
        }
        
        let result=Result.success(contactsList)
        return result
       
    }
    private func mergeSimilarAccounts(_ accountsList:[Account])->[Account]{
        
        var mergedAccountList=[Account]()
        for account in mergedAccountList{
            // check if it is a duplicated account
            if let index = mergedAccountList.index(where: { $0.accountId == account.accountId }) {
                // it is a duplicated account, merge it with the similar account
                let currentAccount=mergedAccountList[index]
                currentAccount.merge(account)
            }
            else{
                // not a duplicated account, add it into the list
                mergedAccountList.append(account)
            }
        }
        return mergedAccountList
    }
    
    private func decodeContactsData()->Result<[Account]>{
        
        let result = JsonHandler.readJsonFile(fileName: "contact")
        switch(result) {
            
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                do{
                    let contactsList=try jsonDecoder.decode([Account].self, from: data as! Data)
                    let result=Result.success(contactsList)
                    return result
                }
                catch let error{
                    print (error)
                    let result=Result<[Account]>.failure(error)
                    return result
                }
            case .failure(let error):
                print (error)
                let result=Result<[Account]>.failure(error)
                return result
        }
    }
}
