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
    var userimagepath: String?
    var arrPlayerProfile: [[String: String]]?
    var arrBowling: [[String: String]]?
    var arrBatting: [[String: String]]?
    var reloadView: (() -> ())?
    
    // MARK: - ================================
    // MARK: Webservice calling to fetch Player details
    // MARK: ================================
    
    func callWebServiceToFetchPlayerDetais() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        WebAPIManager.sharedWebAPIManager.callWebServiceToFetchDetailsFor(module: .PlayerStatistics, queryparam: String(format: "%d", objPlayer?.pid?.intValue ?? 0)) {[weak self] (success, error, data) in
            if success, let byteData = data, byteData.count > 0 {
                do {
                    let decoder = JSONDecoder()
                    let objPlayerDetails = try decoder.decode(PlayerDetails.self, from: byteData)
                    self?.arrPlayerProfile = objPlayerDetails.returnPlayerInfo()
                    self?.userimagepath = objPlayerDetails.imageurl
                    self?.arrBowling = objPlayerDetails.statistics?.returnBowlingInfo()
                    self?.arrBatting = objPlayerDetails.statistics?.returnBattingInfo()
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
        objPlayer = nil
        arrPlayerProfile?.removeAll()
        arrPlayerProfile = nil
        arrBowling?.removeAll()
        arrBowling = nil
        arrBatting?.removeAll()
        arrBatting = nil
    }
}
