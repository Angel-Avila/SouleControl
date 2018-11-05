//
//  PersonCell.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/11/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    var person: Person? {
        didSet {
            guard let person = person else { return }
            titleLabel.text = person.name
            personImageView.image = person.image
            
            guard let last = person.hoursArrivedAt.last else { return }
            
            let lastArrival = Date(timeIntervalSince1970: last)
            let f = DateFormatter()
            f.dateFormat = "hh:mm a dd/MM/yyyy"
            detailLabel.text = "Última llegada: " + f.string(from: lastArrival)
        }
    }
    
    fileprivate let titleColor = UIColor(white: 0.3, alpha: 1)
    fileprivate let detailColor = UIColor(white: 0.6, alpha: 1)
    
    var personImageView: UIImageView! = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "person"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 5
        return iv
    }()
    
    lazy var titleLabel: UILabel! = {
        let label = Label(labelText: "-", fontName: "AvenirNext-DemiBold", size: 22, textColor: titleColor)
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    lazy var detailLabel: UILabel! = {
        let label = Label(labelText: "Última llegada: -", size: 17, textColor: detailColor)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(personImageView)
        addSubview(titleLabel)
        addSubview(detailLabel)
        
        let inset: CGFloat = 16
        let height: CGFloat = 100 - inset * 2
        
        personImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.init(top: inset, left: inset, bottom: 0, right: 0), size: CGSize(width: height, height: height))
        
        titleLabel.anchor(top: personImageView.topAnchor, leading: personImageView.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets.init(top: 0, left: inset, bottom: 0, right: 0))

        detailLabel.anchor(top: personImageView.centerYAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
