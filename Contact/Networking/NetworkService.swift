//
//  NetworkService.swift
//  Contact
//
//  Created by Saeedeh on 27/06/2018.
//  Copyright © 2018 tiseno. All rights reserved.
//

import Foundation




class NetworkService{
    
    typealias networkServiceComplationHandler = (Result<Data>) -> Void
    
    private static var session: URLSession = URLSession(configuration:URLSessionConfiguration.default)
    
//    init(){
//
//        let sessionConfiguration = URLSessionConfiguration.default
//        self.session = URLSession(configuration: sessionConfiguration)
//    }
    
    class func request(url:URL,complationHandler: @escaping networkServiceComplationHandler){
        
        print ("->>request:",url.absoluteString)
        
        let dataTask=session.dataTask(with:url){ data, response, error in
            
            guard error == nil else{
                
                // inform  model layer about the error
                let result=Result<Data>.failure(error!)
                complationHandler(result)
                return
                
            }
            //check response
            guard let httpResponse = response as? HTTPURLResponse else {
                
                let error = NSError(domain: Constants.DomainError.server, code: 0, userInfo: [NSLocalizedDescriptionKey : Constants.ErrorMessage.serverError])
                
                // inform  model layer about the error
                let result=Result<Data>.failure(error)
                complationHandler(result)
                return
            }
            //check response's status code
            guard (200...299).contains(httpResponse.statusCode) else{
                
                let error = NSError(domain: Constants.DomainError.http, code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey : HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode)])
                
                // inform  model layer about the error
                let result=Result<Data>.failure(error)
                complationHandler(result)
                return
                
            }
            guard let data = data else{
                
                let error = NSError(domain: Constants.DomainError.server, code: 0, userInfo: [NSLocalizedDescriptionKey : Constants.ErrorMessage.serverError])
                // inform  model layer about the error
                let result=Result<Data>.failure(error)
                complationHandler(result)
                return
            }
            // data is received from api successfully
            let result=Result.success(data)
            complationHandler(result)
        }
        dataTask.resume()
    }
    
}
