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
    
    func fetchContacts(complationHandler:@escaping (Result<Any>) -> Void){
        
        guard let url=URL(string: Constants.ApiUrl.getContacts) else {
            
            let error=NSError(domain: Constants.DomainError.httpError, code: 0, userInfo: [NSLocalizedDescriptionKey : Constants.ErrorMessage.badUrl])
            
            let result=Result<Any>.failure(error)
            complationHandler(result)
            return
        }
        
//        NetworkService.request(url: url) { (result) in
//
//            switch result{
//
//                case .success(let data):
//
//                    self.processContactsData(data:data as! [String : Any])
//                    let result=Result.success(self.contactsList as Any)
//                    complationHandler(result)
//
//                case .failure(_):
//                    complationHandler(result)
//            }
//        }
        
        // create [Account] from Data received from API
        let resultCreateContactList=self.createContactsListFromData()
        switch resultCreateContactList {
            
            case .success(let data):
                // init the self.contactsList
                self.contactsList=data as! [Account]
                let result=Result.success(self.contactsList as Any)
                complationHandler(result)
            
            case .failure(_):
                complationHandler(resultCreateContactList)
        }
      
    }
    
    private func createContactsListFromData()->Result<Any>{
        
            // first: decode Data into [Account]
            let decodeResult=self.decodeContactsData()
            switch decodeResult{
                
                case .success(let data):
                    let decodedContactsList = data as! [Account]
                        // second: merge similar accounts into one account
                        let mergedAccountsList=self.mergeSimilarAccounts(decodedContactsList)
                        let result=Result.success(mergedAccountsList as Any)
                        return result
                
                case .failure(_):
                    return decodeResult
            }
    }
    
//        if let d=data["d"]  as? [String: Any]{
//
//            if let results=d["results"] as?  [NSDictionary]{
//
//                var resultsData: Data = NSKeyedArchiver.archivedData(withRootObject: results[1]) as Data
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
//                    print ("jjjjjjjjjjj",resultsData,dictionary!)
//                    let contactsList=try jsonDecoder.decode(Account.self, from: resultsData)
//                }
//                catch let error{
//
//                    print (error.localizedDescription)
//                }
//            }
//        }
  
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
    
    private func decodeContactsData()->Result<Any>{
        
        let result = JsonHandler.readJsonFile(fileName: "contact")
        switch(result) {
            
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                do{
                    let contactsList=try jsonDecoder.decode([Account].self, from: data as! Data)
                    let result=Result.success(contactsList as Any)
                    return result
                }
                catch let error{
                    print (error)
                    let result=Result<Any>.failure(error)
                    return result
                }
            case .failure(let error):
                print (error)
                let result=Result<Any>.failure(error)
                return result
        }
    }
}
