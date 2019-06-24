//
//  PlayerListVM.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 20/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation
import  UIKit

class PlayerListViewModel {
    let operationQueue = OperationQueue()
    // A list to parse & map players data into a list of models
    var players: [Player]? {
        didSet {
            reloadTable!()
        }
    }
    // A closure to reload table
    var reloadTable: (() -> ())?
    
    init() {
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue.qualityOfService = .userInitiated
    }
    
    // Search text parameter to get players data from web-service
    var searchText: String? {
        didSet {
            operationQueue.cancelAllOperations()
            // Check length of searchable input prior making a call to server
            if let searchText = searchText?.trimmedString, searchText.length > 0 {
                let operation = Operation()
                operation.qualityOfService = .userInitiated
                operation.queuePriority = .veryHigh
                operation.completionBlock = { [weak self] in
                    self?.fetchPlayerListBasedOn(inputText: searchText)
                }
                operationQueue.addOperation(operation)
            } else {
                clearPlayers()
            }
        }
    }
    
    // MARK: - ================================
    // MARK: Webservice calling to fetch Player list
    // MARK: ================================

    func fetchPlayerListBasedOn(inputText: String) {
        DispatchQueue.main.async(execute: {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        })
        WebAPIManager.sharedWebAPIManager.callWebServiceToFetchDetailsFor(module: .PlayerFinder, queryparam: inputText) { [weak self] (success, error, data) in
            if success, let byteData = data, byteData.count > 0 {
                if let count = self?.searchText?.count, count > 0 {
                    do {
                        let decoder = JSONDecoder()
                        let objPlayerFinder = try decoder.decode(PlayerFinder.self, from: byteData)
                        self?.players = objPlayerFinder.players
                    } catch {
                        #if DEBUG
                        print(error.localizedDescription)
                        #endif
                        self?.clearPlayers()
                    }
                } else {
                    self?.clearPlayers()
                }
            } else {
                self?.clearPlayers()
                #if DEBUG
                print(error as Any)
                #endif
            }
            DispatchQueue.main.async(execute: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
        }
    }
    
    private func clearPlayers() {
        self.players?.removeAll()
        self.players = nil
    }
    
    deinit {
        clearPlayers()
    }
}
