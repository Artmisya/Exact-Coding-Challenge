//
//  NetworkService.swift
//  Contact
//
//  Created by Saeedeh on 27/06/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import Foundation




class NetworkService{
    
    typealias networkServiceComplationHandler = (Result) -> Void
    
    private var session: URLSession = URLSession()
    
    init(){
        
        let sessionConfiguration = URLSessionConfiguration.default
        self.session = URLSession(configuration: sessionConfiguration)
    }
    
    func request(url:URL,complationHandler: @escaping networkServiceComplationHandler){
        
        print ("->>request:",url.absoluteString)
        
        let dataTask=self.session.dataTask(with:url){ data, response, error in
            
            guard error == nil else{
                
                // inform  model layer about the error
                let result=Result.failure(error!)
                complationHandler(result)
                return
                
            }
            //check response
            guard let httpResponse = response as? HTTPURLResponse else {
                
                let error = NSError(domain: Constants.DomainError.serverError, code: 0, userInfo: [NSLocalizedDescriptionKey : Constants.ErrorMessage.serverError])
                
                // inform  model layer about the error
                let result=Result.failure(error)
                complationHandler(result)
                
                return
            }
            //check response's status code
            guard (200...299).contains(httpResponse.statusCode) else{
                
                let error = NSError(domain: Constants.DomainError.httpError, code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey : HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)])
                
                // inform  model layer about the error
                let result=Result.failure(error)
                complationHandler(result)
                return
                
            }
            if let data = data {
                
                //let reply=NetworkServiceReply(data:data, error: nil)
                let result=Result.success(data)
                complationHandler(result)
                
            }
            
        }
        dataTask.resume()
    }
    
}
