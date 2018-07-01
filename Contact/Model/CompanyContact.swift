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
    private(set) var accountsList=[Account]()
    
    func fetchAccounts(complationHandler:@escaping (Result<[Account]>) -> Void){
        
        guard let url=URL(string: Constants.ApiUrl.getAccounts) else {
            
            let error=NSError(domain: Constants.DomainError.http, code: 0, userInfo: [NSLocalizedDescriptionKey : Constants.ErrorMessage.badUrl])
            
            let result=Result<[Account]>.failure(error)
            complationHandler(result)
            return
        }
        NetworkService.request(url: url) { (result) in

            switch result{

            case .success(let data):
                let resultCreateAccountList=self.createAccountsListFromData(data:data)
                switch resultCreateAccountList {
                case .success(let data):
                    // init the self.accountsList
                    self.accountsList=data
                    let result=Result.success(self.accountsList)
                    complationHandler(result)
                
                case .failure(let error):
                    let result=Result<[Account]>.failure(error)
                    complationHandler(result)
                }
            case .failure(let error):
                let result=Result<[Account]>.failure(error)
                complationHandler(result)
            }
        }
 
    }
    private func createAccountsListFromData(data:Data)->Result<[Account]>{
            // first: decode Data into [Account]
        let decodeResult=self.decodeAccountsData(data:data)
            switch decodeResult{
                
            case .success(let data):
                let decodedAccountsList = data
                    // second: merge similar accounts into one account
                let mergedAccountsList=self.mergeSimilarAccounts(accountsList:decodedAccountsList)
                    let result=Result.success(mergedAccountsList)
                    return result
            case .failure(let error):
                print (error.localizedDescription)
                let result=Result<[Account]>.failure(error)
                return result
            }
    }
    
    private func mergeSimilarAccounts(accountsList:[Account])->[Account]{
        
        var mergedAccountList=[Account]()
        for account in accountsList{
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

    private func decodeAccountsData(data:Data)->Result<[Account]>{
        
        // convert Data to [String,Any]
        var dataDic: [String: Any]
        do {
            dataDic = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as! [String: Any]
        } catch let error {
            
            print( error)
            let result=Result<[Account]>.failure(error)
            return result
        }
        guard let d=dataDic["d"]  as? [String: Any] else{
            
            let error = NSError(domain: Constants.DomainError.api, code: 0, userInfo: [NSLocalizedDescriptionKey : Constants.ErrorMessage.serverError])
            let result=Result<[Account]>.failure(error)
            return result
        }
        guard let results=d["results"] as?  [NSDictionary] else{
            
            let error = NSError(domain: Constants.DomainError.api, code: 0, userInfo: [NSLocalizedDescriptionKey : Constants.ErrorMessage.serverError])
            let result=Result<[Account]>.failure(error)
            return result
        }
        let jsonDecoder = JSONDecoder()
        
        do {
            let resultsData=try JSONSerialization.data(withJSONObject: results, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
            let decodedAccountsList=try jsonDecoder.decode([Account].self, from: resultsData as Data)
            //print ("******",decodedContactsList.count)
            
            let result=Result.success(decodedAccountsList)
            return result
        } catch let error {
            let result=Result<[Account]>.failure(error)
            return result
        }
     }
}

// MARK:- Expose Account private functions for unit test
#if DEBUG
extension CompanyContact {
    
    public func exposePrivateDecodeAccountsData(data:Data)->Result<[Account]>{
        return self.decodeAccountsData(data:data)
    }
    
    public func exposePrivateMergeSimilarAccounts(accountsList:[Account])->[Account]{
        return self.mergeSimilarAccounts(accountsList:accountsList)
    }
    
    public func exposePrivateCreateAccountsListFromData(data:Data)->Result<[Account]>{
        return self.createAccountsListFromData(data:data)
    }
}
#endif

