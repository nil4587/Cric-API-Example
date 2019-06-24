//
//  PlayerListView+UITableViewDataSource.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 20/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ================================
// MARK: UITableView DataSource Methods
// MARK: ================================

extension PlayerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = playerListViewModel.players?.count, count > 0 {
            tableView.backgroundView = nil
            return count
        } else {
            let title = UILabel(frame: tableView.bounds)
            title.text = "no_record_found".localised()
            title.textAlignment = .center
            tableView.backgroundView = title
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PlayerListViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.lineBreakMode = .byWordWrapping
            cell?.detailTextLabel?.numberOfLines = 0
            cell?.detailTextLabel?.lineBreakMode = .byWordWrapping
            cell?.detailTextLabel?.textColor = UIColor.gray
            cell?.textLabel?.textColor = UIColor.brown
        }
        let player = playerListViewModel.players?[indexPath.row]
        cell?.textLabel?.text = player?.shortName
        cell?.detailTextLabel?.text = String(format: "\("player_id".localised()) : %d", player?.playerId?.intValue ?? 0)
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
}
