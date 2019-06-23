//
//  PlayerListVM.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 20/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation
import  UIKit

class PlayerListVM {
    let operationQueue = OperationQueue()
    // An object to parse & map players data into a model
    var objPlayerFinder: PlayerFinder? {
        didSet {
            reloadTable!()
        }
    }
    // A closure to reload table
    var reloadTable: (() -> ())?
    
    init() {
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.qualityOfService = .userInteractive
    }
    
    // Search text parameter to get players data from web-service
    var searchText: String? {
        didSet {
            operationQueue.cancelAllOperations()
            // Check length of searchable input prior making a call to server
            if let length = searchText?.trimmedString.length, length > 0 {
                let operation = Operation()
                operation.qualityOfService = .userInteractive
                operation.queuePriority = .veryHigh
                operation.completionBlock = {
                    self.callWebServiceToFetchPlayerList(searchtext: self.searchText!)
                }
                operationQueue.addOperation(operation)
            } else {
                clearPlayerInfo()
            }
        }
    }
    
    // MARK: - ================================
    // MARK: Webservice calling to fetch Player list
    // MARK: ================================

    func callWebServiceToFetchPlayerList(searchtext: String) {
        DispatchQueue.main.async(execute: {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        })
        WebAPIManager.sharedWebAPIManager.callWebServiceToFetchDetailsFor(module: .PlayerFinder, queryparam: searchtext) { [weak self] (success, error, data) in
            if success, let byteData = data, byteData.count > 0 {
                if let count = self?.searchText?.count, count > 0 {
                    do {
                        let decoder = JSONDecoder()
                        self?.objPlayerFinder = try decoder.decode(PlayerFinder.self, from: byteData)
                    } catch {
                        print(error.localizedDescription)
                        self?.clearPlayerInfo()
                    }
                } else {
                    self?.clearPlayerInfo()
                }
            } else {
                self?.clearPlayerInfo()
                print(error as Any)
            }
            DispatchQueue.main.async(execute: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
        }
    }
    
    private func clearPlayerInfo() {
        self.objPlayerFinder?.players?.removeAll()
        self.objPlayerFinder?.players = nil
        self.objPlayerFinder = nil
    }
    
    deinit {
        objPlayerFinder?.players?.removeAll()
        objPlayerFinder = nil
    }
}
