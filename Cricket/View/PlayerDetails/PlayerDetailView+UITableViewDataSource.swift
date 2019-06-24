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
        if playerDetailViewModel.arrPlayerProfileKeyValues == nil || playerDetailViewModel.arrPlayerProfileKeyValues?.count == 0 {
            return 0
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return playerDetailViewModel.arrPlayerProfileKeyValues?.count ?? 0
        } else if section == 1 {
            return playerDetailViewModel.arrBowlingKeyValues?.count ?? 0
        } else {
            return playerDetailViewModel.arrBattingKeyValues?.count ?? 0
        }
    }
        
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "biography".localised()
        } else if section == 1 {
            return "bowling_stats".localised()
        } else {
            return "batting_stats".localised()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        if let font = header.textLabel?.font {
            header.textLabel?.font = UIFont(name: font.familyName, size: font.pointSize + 5.0)
        }
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
            dictInfo = playerDetailViewModel.arrPlayerProfileKeyValues?[indexPath.row]
        } else if indexPath.section == 1 {
            // Bowling Info section
            dictInfo = playerDetailViewModel.arrBowlingKeyValues?[indexPath.row]
        } else {
            // Batting Info section
            dictInfo = playerDetailViewModel.arrBattingKeyValues?[indexPath.row]
        }
        cell?.textLabel?.text = dictInfo?.keys.first
        cell?.detailTextLabel?.text = dictInfo?.values.first
        return cell!
    }
}
