//
//  PlayerDetailsViewController.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 20/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import UIKit

final class PlayerDetailsViewController: BaseViewController {

    let playerDetailVM = PlayerDetailsVM()
    
    @IBOutlet weak private var tblView: UITableView!
    @IBOutlet private weak var userImgView: UIImageView!
    
    // MARK: - ================================
    // MARK: ViewController life cycle
    // MARK: ================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = playerDetailVM.objPlayer?.name

        tblView.tableFooterView = UIView()
        tblView.estimatedRowHeight = 50
        tblView.rowHeight = UITableView.automaticDimension
        
        playerDetailVM.reloadView = { [weak self] in
            DispatchQueue.main.async(execute: {
                self?.tblView.reloadData()
            })
            self?.loadUserImageView()
        }
        playerDetailVM.callWebServiceToFetchPlayerDetais()
    }
    
    // MARK: - ================================
    // MARK: User-defined methods
    // MARK: ================================
    
    private func loadUserImageView() {
        if let imagepath = playerDetailVM.userimagepath?.trimmedString, imagepath.count > 0 {
            self.userImgView.loadImage(fromURL: imagepath)
        } else {
            DispatchQueue.main.async {
                self.userImgView.transition(toImage: #imageLiteral(resourceName: "cricket_avtar"))
            }
        }
    }
}
