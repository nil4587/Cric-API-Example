//
//  ViewController.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 18/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import UIKit

final class PlayerListViewController: BaseViewController {

    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var searchBar: UISearchBar!

    let playerListViewModel = PlayerListViewModel()
    
    class func instance() -> PlayerListViewController? {
        let storyBoard = UIStoryboard(name: Constants.AppViewKeys.mainStoryboardKey, bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier: Constants.AppViewKeys.playerListViewKey) as? PlayerListViewController
    }
    
    // MARK: - ================================
    // MARK: ViewController life cycle
    // MARK: ================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "player_list_title".localised()
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 45
        tableView.rowHeight = UITableView.automaticDimension
        playerListViewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async(execute: {
                self?.tableView.reloadData()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ================================
    // MARK: View Navigation
    // MARK: ================================
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexpath = sender as? IndexPath {
            let destinationContoller = segue.destination as? PlayerDetailsViewController
            destinationContoller?.playerDetailViewModel.selectedPlayer = playerListViewModel.players?[indexpath.row]
        }
    }
}

// MARK: - ================================
// MARK: UISearchBar Delegate Methods
// MARK: ================================

extension PlayerListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        playerListViewModel.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - ================================
// MARK: UIScrollView Delegate Methods
// MARK: ================================

extension PlayerListViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}
