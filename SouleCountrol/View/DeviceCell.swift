//
//  DeviceCell.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/4/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class DeviceCell: GenericCell<Device> {
    
    override var item: Device! {
        didSet {
            label.text = item.name
            setUI(fromDeviceType: item.type)
        }
    }
    
    lazy var imageView: UIImageView! = {
        let iv = UIImageView(image: nil)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var label: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ".SFUIDisplay-Bold", size: 20)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    let cornerRadius: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.lightYellow
        contentView.layer.cornerRadius = cornerRadius
        UIView.giveStandardShadow(toView: contentView)
        
        contentView.addSubview(label)
        label.anchor(top: contentView.centerYAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 8, bottom: 0, right: 8))
        
        let inset: CGFloat = 4
        contentView.addSubview(imageView)
        imageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: inset, left: inset, bottom: 0, right: 0))
        
        let height = AppDelegate.cellHeight / 2 - inset * 2
        imageView.anchorSize(size: CGSize(width: height, height: height))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUI(fromDeviceType type: DeviceType) {
        switch type {
        case .light:
            contentView.setHorizontalGradient(color1: .lightYellow, color2: .darkYellow, withCornerRadius: cornerRadius)
            imageView.image = #imageLiteral(resourceName: "lightbulb")
        case .camera:
            contentView.setHorizontalGradient(color1: .lightSkyBlue, color2: .darkSkyBlue, withCornerRadius: cornerRadius)
            imageView.image = #imageLiteral(resourceName: "camera")
        case .door:
            contentView.setHorizontalGradient(color1: .lightBrown, color2: .darkBrown, withCornerRadius: cornerRadius)
            imageView.image = #imageLiteral(resourceName: "door")
        case .extra:
            contentView.setHorizontalGradient(color1: .lightPurple, color2: .darkPurple, withCornerRadius: cornerRadius)
            imageView.image = #imageLiteral(resourceName: "random")
        }
    }
    
}
