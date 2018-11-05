//
//  PersonCollectionViewCell.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/23/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class PersonCollectionViewCell: GenericCollectionViewCell<Person> {
    
    override var item: Person! {
        didSet {
            nameLabel.text = item.name
            imageView.image = item.image
        }
    }
    
    lazy var cellContainer: UIView! = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    lazy var imageView: UIImageView! = {
        let iv = UIImageView(image: nil)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var coverView: UIView! = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 0.25)
        return view
    }()
    
    lazy var nameLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ".SFUIDisplay-Bold", size: 20)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    let cornerRadius: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet { bounce(isHighlighted) }
    }
    
    func bounce(_ bounce: Bool) {
        UIView.animate(
            withDuration: 0.8,
            delay: 0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.8,
            options: [.allowUserInteraction, .beginFromCurrentState],
            animations: { self.transform = bounce ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity },
            completion: nil)
    }
    
    func updateUI() {
        
    }
    
    fileprivate func setupViews() {
        contentView.backgroundColor = UIColor.lightYellow
        contentView.layer.cornerRadius = cornerRadius
        cellContainer.layer.cornerRadius = cornerRadius
        UIView.giveStandardShadow(toView: contentView)
        
        contentView.addSubview(cellContainer)
        cellContainer.addSubview(imageView)
        cellContainer.addSubview(coverView)
        cellContainer.addSubview(nameLabel)
        
        cellContainer.fillSuperview()
        imageView.fillSuperview()
        coverView.fillSuperview()
        nameLabel.anchor(top: nil, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 4, bottom: 4, right: 4))
    }
}
