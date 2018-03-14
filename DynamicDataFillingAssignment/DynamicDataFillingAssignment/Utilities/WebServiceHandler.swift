//
//  WebServiceHandler.swift
//  DynamicDataFillingAssignment
//

import Foundation
import Alamofire
import UIKit

class WebserviceHandler {
    ///  Call post webservice with required url,parameters
    ///
    /// - Parameters:
    ///   - url: api url to be hit
    ///   - parameters: parameters to hit url
    ///   - success: action to be performed on success call of api
    ///   - failure: action to be performed on failure call of api
    func callPostWebService(url: String,
                        parameters: NSDictionary,
                        success: @escaping (_ response: AnyObject?) ->(),
                        failure: @escaping (_ error: NSData)->()) {
        let param = parameters
        //Show loader
        Alamofire.request(url,
                          method: .post,
                          parameters: param as? [String : AnyObject],
                          encoding: JSONEncoding.default,
                          headers: [:])
            .validate()
            .responseJSON { (response) in
                DispatchQueue.main.async( execute: {
                    //Hide loader
                })
                
                if  (response.result.error != nil) {
                    failure(response.data! as NSData)
                } else {
                    if (response.response != nil) {
                        success(response.result.value as AnyObject )
                    }
                }
        }
    }
}
