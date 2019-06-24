//
//  PlayerDetailsVM.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 20/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation
import UIKit

class PlayerDetailsViewModel {
    var selectedPlayer: Player?
    var userimagepath: String?
    var arrPlayerProfileKeyValues: [[String: String]]?
    var arrBowlingKeyValues: [[String: String]]?
    var arrBattingKeyValues: [[String: String]]?
    var reloadView: (() -> ())?
    
    // MARK: - ================================
    // MARK: Webservice calling to fetch Player details
    // MARK: ================================
    
    func fetchPlayerDetails() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        WebAPIManager.sharedWebAPIManager.callWebServiceToFetchDetailsFor(module: .PlayerStatistics, queryparam: String(format: "%d", selectedPlayer?.playerId?.intValue ?? 0)) {[weak self] (success, error, data) in
            if success, let byteData = data, byteData.count > 0 {
                do {
                    let decoder = JSONDecoder()
                    let objPlayerDetails = try decoder.decode(PlayerDetails.self, from: byteData)
                    self?.arrPlayerProfileKeyValues = objPlayerDetails.playerInformations()
                    self?.userimagepath = objPlayerDetails.imageURL
                    self?.arrBowlingKeyValues = objPlayerDetails.statistics?.bowlingStatistics()
                    self?.arrBattingKeyValues = objPlayerDetails.statistics?.battingStatistics()
                    self?.reloadView!()
                } catch {
                    displayAlert(message: "An error occurred while decoding data due to \(error.localizedDescription)")
                }
            } else {
                if let errormessage = error {
                    displayAlert(message: errormessage)
                } else {
                    displayAlert(message: "Something went wrong. Please try again!!")
                }
            }
            DispatchQueue.main.async(execute: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
        }
    }
        
    deinit {
        selectedPlayer = nil
        arrPlayerProfileKeyValues?.removeAll()
        arrPlayerProfileKeyValues = nil
        arrBowlingKeyValues?.removeAll()
        arrBowlingKeyValues = nil
        arrBattingKeyValues?.removeAll()
        arrBattingKeyValues = nil
    }
}
