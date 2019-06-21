//
//  ViewController.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 18/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import UIKit

class PlayerListViewController: BaseViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!

    let playerListVM = PlayerListVM()
    
    // MARK: - ================================
    // MARK: ViewController life cycle
    // MARK: ================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "PLAYERS"
        tblView.tableFooterView = UIView()
        playerListVM.reloadTable = {
            DispatchQueue.main.async(execute: {
                self.tblView.reloadData()
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
            destinationContoller?.playerDetailVM.objPlayer = playerListVM.objPlayerFinder?.players?[indexpath.row]
        }
    }
}

// MARK: - ================================
// MARK: UISearchBar Delegate Methods
// MARK: ================================

extension PlayerListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        playerListVM.searchText = searchText
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
        searchbar.resignFirstResponder()
    }
}
