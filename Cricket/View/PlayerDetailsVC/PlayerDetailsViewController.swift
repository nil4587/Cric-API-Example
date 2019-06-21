//
//  PlayerDetailsViewController.swift
//  Cricket
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 20/06/19.
//  Copyright © 2019 Saturn. All rights reserved.
//

import UIKit

class PlayerDetailsViewController: BaseViewController {

    let playerDetailVM = PlayerDetailsVM()
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet var userImgView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
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
        
        loadingIndicator.startAnimating()
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
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    private func loadUserImageView() {
        if let imagepath = playerDetailVM.objPlayerDetails?.imageurl, let imageurl = URL(string: imagepath) {
            getData(from: imageurl) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async() {
                        self.userImgView.image = #imageLiteral(resourceName: "cricket_avtar")
                        self.userImgView.setNeedsLayout()
                        self.loadingIndicator.stopAnimating()
                    }
                    return
                }
                print("Download Finished")
                DispatchQueue.main.async() {
                    let image = UIImage(data: data)
                    self.userImgView.image = image
                    self.userImgView.setNeedsLayout()
                    self.loadingIndicator.stopAnimating()
                }
            }
        } else {
            DispatchQueue.main.async {
                self.userImgView.image = #imageLiteral(resourceName: "cricket_avtar")
                self.userImgView.setNeedsLayout()
                self.loadingIndicator.stopAnimating()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
