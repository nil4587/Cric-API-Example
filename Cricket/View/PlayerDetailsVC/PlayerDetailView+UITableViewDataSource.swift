//
//  PlayerDetailView+UITableViewDataSource.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 21/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ================================
// MARK: UITableView DataSource Methods
// MARK: ================================

extension PlayerDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if playerDetailVM.arrPlayerProfile == nil || playerDetailVM.arrPlayerProfile?.count == 0 {
            return 0
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return playerDetailVM.arrPlayerProfile?.count ?? 0
        } else if section == 1 {
            return playerDetailVM.arrBowling?.count ?? 0
        } else {
            return playerDetailVM.arrBatting?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return Constants.AppKeys.biography
        } else if section == 1 {
            return Constants.AppKeys.bowling_stats
        } else {
            return Constants.AppKeys.bating_stats
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        view.tintColor = UIColor.orange
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PlayerDetailsViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.lineBreakMode = .byWordWrapping
            cell?.detailTextLabel?.numberOfLines = 0
            cell?.detailTextLabel?.lineBreakMode = .byWordWrapping
            cell?.detailTextLabel?.textColor = UIColor.gray
            cell?.textLabel?.textColor = UIColor.brown
            // To slightly increase the font size
            if let detailfont = cell?.detailTextLabel?.font {
                let familyName = detailfont.familyName
                let pointSize = detailfont.pointSize
                cell?.detailTextLabel?.font = UIFont(name: familyName, size: pointSize + 5.0)
            }
            cell?.selectionStyle = .none
        }
        var dictInfo: [String: String]?
        if indexPath.section == 0 {
            // Biography section
            dictInfo = playerDetailVM.arrPlayerProfile?[indexPath.row]
        } else if indexPath.section == 1 {
            // Bowling Info section
            dictInfo = playerDetailVM.arrBowling?[indexPath.row]
        } else {
            // Batting Info section
            dictInfo = playerDetailVM.arrBatting?[indexPath.row]
        }
        cell?.textLabel?.text = dictInfo?.keys.first
        cell?.detailTextLabel?.text = dictInfo?.values.first
        return cell!
    }
}
