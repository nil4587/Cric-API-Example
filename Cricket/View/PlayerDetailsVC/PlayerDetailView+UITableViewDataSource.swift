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
        if playerDetailVM.objPlayerDetails == nil {
            return 0
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 9
        } else {
            return 5
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
        if indexPath.section == 0 {
            // Biography section
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = Constants.AppKeys.fullname
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.fname ?? "N/A"
            case 1:
                cell?.textLabel?.text = Constants.AppKeys.born
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.born ?? "N/A"
            case 2:
                cell?.textLabel?.text = Constants.AppKeys.age
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.age ?? "N/A"
            case 3:
                cell?.textLabel?.text = Constants.AppKeys.country
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.country ?? "N/A"
            case 4:
                cell?.textLabel?.text = Constants.AppKeys.role
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.role ?? "N/A"
            case 5:
                cell?.textLabel?.text = Constants.AppKeys.battingstyle
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.battingStyle ?? "N/A"
            case 6:
                cell?.textLabel?.text = Constants.AppKeys.bowlingstyle
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.bowlingStyle ?? "N/A"
            case 7:
                cell?.textLabel?.text = Constants.AppKeys.majorteams
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.majorTeams ?? "N/A"
            case 8:
                cell?.textLabel?.text = Constants.AppKeys.profile
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.profile?.trimmedString ?? "N/A"
            default:
                break
            }
        } else if indexPath.section == 1 {
            // Bowling Info section
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = Constants.AppKeys.listA
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.statistics?.bowling?.listA?.returnBowlingInfo() ?? "N/A"
            case 1:
                cell?.textLabel?.text = Constants.AppKeys.first_class
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.statistics?.bowling?.firstClass?.returnBowlingInfo() ?? "N/A"
            case 2:
                cell?.textLabel?.text = Constants.AppKeys.t20s
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.statistics?.bowling?.t20IS?.returnBowlingInfo() ?? "N/A"
            case 3:
                cell?.textLabel?.text = Constants.AppKeys.odis
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.statistics?.bowling?.odis?.returnBowlingInfo() ?? "N/A"
            case 4:
                cell?.textLabel?.text = Constants.AppKeys.test
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.statistics?.bowling?.tests?.returnBowlingInfo() ?? "N/A"
            default:
                break
            }
        } else {
            // Batting Info section
            switch indexPath.row {
            case 0:
                cell?.textLabel?.text = Constants.AppKeys.listA
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.statistics?.batting?.listA?.returnBattingInfo() ?? "N/A"
            case 1:
                cell?.textLabel?.text = Constants.AppKeys.first_class
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.statistics?.batting?.firstClass?.returnBattingInfo() ?? "N/A"
            case 2:
                cell?.textLabel?.text = Constants.AppKeys.t20s
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.statistics?.batting?.t20IS?.returnBattingInfo() ?? "N/A"
            case 3:
                cell?.textLabel?.text = Constants.AppKeys.odis
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.statistics?.batting?.odis?.returnBattingInfo() ?? "N/A"
            case 4:
                cell?.textLabel?.text = Constants.AppKeys.test
                cell?.detailTextLabel?.text = playerDetailVM.objPlayerDetails?.statistics?.batting?.tests?.returnBattingInfo() ?? "N/A"
            default:
                break
            }
        }
        return cell!
    }
}
