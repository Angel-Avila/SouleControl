//
//  SecurityVC.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/4/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class SecurityVC: UITableViewController {
    
    let cellHeight: CGFloat = 100
    let addButtonHeight: CGFloat = 50
    let tintColor = #colorLiteral(red: 0.2605186105, green: 0.2605186105, blue: 0.2605186105, alpha: 1)
    
    var topSpace: CGFloat = 0
    
    lazy var addButton: UIButton! = {
        let button = UIButton.createFloatingButton(height: addButtonHeight, image: #imageLiteral(resourceName: "iconoPlus"), buttonColor: .white, borderColor: .clear, tintColor: tintColor, inset: 8)
        return button
    }()
    
//    let addPersonPopup = TextPopup(title: "Nueva cita", description: "Agregue el título de su cita")
    
    var people = [Person(name: "Ángel Ávila", role: "Familia"),
                  Person(name: "Sergio Chung", role: "Vagabundo")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupAddButton()
        people.first!.image = #imageLiteral(resourceName: "angel")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Seguridad"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if #available(iOS 11.0, *) {
            topSpace = self.view.safeAreaInsets.top
        } else {
            topSpace = self.topLayoutGuide.length
        }
    }
    
    // MARK: - Calculate frames
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        calculateAddButtonFrame()
    }

    fileprivate func calculateAddButtonFrame() {
        var  offset: CGFloat = -tableView.contentOffset.y + 60
        
        let padding: CGFloat = 20
        
        if Utils.phoneHasNotch() {
            offset += 24
        }
        
        let x = view.bounds.width - padding - addButtonHeight
        let y = view.bounds.height - padding - addButtonHeight - offset
        addButton.frame = CGRect(x: x, y: y, width: addButtonHeight, height: addButtonHeight)
    }
    
    fileprivate func calculatePopupFrame() {
//        let y = -topSpace
//        let width = view.frame.width
//        let height = view.frame.height
//        addRegistryPopup.frame = CGRect(x: 0, y: y, width: width, height: height)
    }
    
    // MARK: - Actions
    
    @objc func addButtonTapped() {
        navigationController?.navigationBar.layer.zPosition = 0
        calculatePopupFrame()
//        addRegistryPopup.presentAddElement()
    }
    
    // MARK: - Setup
    
    fileprivate func setupTableView() {
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func setupAddButton() {
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = true
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        calculateAddButtonFrame()
    }
}


extension SecurityVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PersonTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.person = people[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
