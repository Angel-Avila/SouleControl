//
//  ArrivalHourVC.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/23/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class ArrivalHourVC: GenericTableViewController<StringCell, String> {
    
    var person: Person?
    let tintColor = UIColor(white: 0.25, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupBackButton()
        setupTableView()
    }
    
    @objc fileprivate func dismissButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table View
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    fileprivate func setupNavigationController() {
        guard  let nc = self.navigationController  else { return }
        nc.navigationBar.isHidden = false
        nc.navigationBar.barTintColor = .white
        nc.navigationBar.tintColor = tintColor
        
        nc.navigationBar.layer.masksToBounds = false
        nc.navigationBar.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        nc.navigationBar.layer.shadowOpacity = 0.5
        nc.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        nc.navigationBar.layer.shadowRadius = 2
    }
    
    fileprivate func setupBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        backButton.setImage(#imageLiteral(resourceName: "iconoCerrar"), for: .normal)
        backButton.addTarget(self, action: #selector(dismissButtonPressed), for: .touchUpInside)
        
        let item = UIBarButtonItem(customView: backButton)
        item.customView?.anchorSize(size: CGSize(width: 24, height: 24))
        
        navigationItem.leftBarButtonItem = item
    }
    
    fileprivate func setupTableView() {
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.fillSuperview()
        
        let hours: [String] = person!.hoursArrivedAt.map { hour in
            let f = DateFormatter()
            f.dateFormat = "hh:mm a dd/MM/yyyy"
            let date = Date(timeIntervalSince1970: hour)
            return f.string(from: date)
        }
        
        items = hours
    }
}
