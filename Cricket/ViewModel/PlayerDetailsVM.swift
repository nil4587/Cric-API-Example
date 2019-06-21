//
//  PlayerDetailsVM.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 20/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation
import UIKit

class PlayerDetailsVM {
    var objPlayer: Player?
    var objPlayerDetails: PlayerDetails? {
        didSet {
            reloadView!()
        }
    }
    var reloadView: (() -> ())?
    
    // MARK: - ================================
    // MARK: Webservice calling to fetch Player details
    // MARK: ================================
    
    func callWebServiceToFetchPlayerDetais() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        WebAPIManager.sharedWebAPIManager.callWebServiceToFetchDetailsFor(module: .PlayerStatistics, queryparam: String(format: "%d", objPlayer?.pid?.intValue ?? 0)) {[weak self] (success, error, data) in
            if success, let byteData = data {
                do {
                    let decoder = JSONDecoder()
                    self?.objPlayerDetails = try decoder.decode(PlayerDetails.self, from: byteData)
                } catch {
                    displayAlert("An error occurred while decoding data due to \(error.localizedDescription)")
                }
            } else {
                if let errormessage = error {
                    displayAlert(errormessage)
                } else {
                    displayAlert("Something went wrong!!")
                }
            }
            DispatchQueue.main.async(execute: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
        }
    }
    
    deinit {
        objPlayer = nil
        objPlayerDetails = nil
    }
}
