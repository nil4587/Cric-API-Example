//
//  PlayerDetailsViewController.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 20/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import UIKit

final class PlayerDetailsViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var playerImageView: UIImageView!

    let playerDetailViewModel = PlayerDetailsViewModel()
    
    class func instance() -> PlayerDetailsViewController? {
        let storyBoard = UIStoryboard(name: Constants.AppViewKeys.mainStoryboardKey, bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: Constants.AppViewKeys.playerDetailViewKey) as? PlayerDetailsViewController
    }
    
    // MARK: - ================================
    // MARK: ViewController life cycle
    // MARK: ================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = playerDetailViewModel.selectedPlayer?.shortName

        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 45
        tableView.rowHeight = UITableView.automaticDimension
        
        playerDetailViewModel.reloadView = { [weak self] in
            DispatchQueue.main.async(execute: {
                self?.tableView.reloadData()
                self?.loadUserImageView()
            })
        }
        playerDetailViewModel.fetchPlayerDetails()
    }
    
    // MARK: - ================================
    // MARK: User-defined methods
    // MARK: ================================
    
    private func loadUserImageView() {
        if let imagepath = playerDetailViewModel.userimagepath?.trimmedString, imagepath.count > 0 {
            self.playerImageView.loadImage(fromURL: imagepath)
        } else {
            DispatchQueue.main.async {
                self.playerImageView.transition(toImage: #imageLiteral(resourceName: "cricket_avtar"))
            }
        }
    }
}
