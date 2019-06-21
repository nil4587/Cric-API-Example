//
//  WebAPIManager.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 19/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation

class WebAPIManager: NSObject {
    // A singleton
    static let sharedWebAPIManager = WebAPIManager()
    
    // An operation queue
    let operationQueue = OperationQueue()
    
    override init() {
        operationQueue.name = "Web-serviceQueue"
        operationQueue.maxConcurrentOperationCount = 2
        operationQueue.qualityOfService = .userInteractive
    }
    
    // A method to handle multiple web-service calls
    func callWebServiceToFetchDetailsFor(module: APIModule, queryparam: String, completionHandler: @escaping(_ result: Bool, _ error: String?, _ value: Data?) -> Swift.Void) {
        var fullweburl = WebService.webapi_url
        if module == .PlayerFinder {
            fullweburl = String(format: "%@/%@?%@=%@&name=%@", fullweburl,module.returnAPIModuleName(), Constants.AppKeys.api_key_title, WebService.webapi_key, queryparam)
        } else {
            fullweburl = String(format: "%@/%@?%@=%@&pid=%@", fullweburl,module.returnAPIModuleName(), Constants.AppKeys.api_key_title, WebService.webapi_key, queryparam)
        }
        
        let requestUrl = URL(string: fullweburl)
        guard requestUrl != nil else {
            completionHandler(false, "Invalid request url", nil)
            return
        }
        var request = URLRequest(url: requestUrl!)
        request.timeoutInterval = 120
        request.cachePolicy = .returnCacheDataElseLoad
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: operationQueue)
        let task = session.dataTask(with: request) { (data, response, error) in
            let httpresponse = response as? HTTPURLResponse
            if httpresponse?.statusCode == APIResponseCode.success.rawValue {
                if let respondata = data {
                    completionHandler(true, nil, respondata)
                } else {
                    completionHandler(false, "No data found", nil)
                }
            } else {
                if let errr = error {
                    completionHandler(false, errr.localizedDescription, nil)
                } else if let statuscode = httpresponse?.statusCode {
                    let message = HTTPURLResponse.localizedString(forStatusCode: statuscode)
                    completionHandler(false, message, nil)
                } else {
                    completionHandler(false, "Something went wrong..!! Please try again..!!", nil)
                }
            }
        }
        task.resume()
    }
}

// MARK: - ================================
// MARK: URLSession Delegate Methods
// MARK: ================================

extension WebAPIManager: URLSessionDelegate {
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        print(error?.localizedDescription as Any)
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
    }
}
