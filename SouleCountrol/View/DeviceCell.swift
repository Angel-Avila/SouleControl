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
            var stateText = ""
            
            switch item.type! {
            case .door:
                stateText = item.isOn ? DoorState.on.rawValue : DoorState.off.rawValue
            case .light:
                stateText = item.isOn ? LightState.on.rawValue : LightState.off.rawValue
            case .camera:
                stateText = item.isOn ? CameraState.on.rawValue : CameraState.off.rawValue
            default:
                stateText = item.state
            }
            
            nameLabel.text = item.name
            stateLabel.text = stateText
            setUI(fromDeviceType: item.type, andState: item.isOn)
        }
    }
    
    lazy var imageView: UIImageView! = {
        let iv = UIImageView(image: nil)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    lazy var nameLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ".SFUIDisplay-Bold", size: 20)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    lazy var stateLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ".SFUIDisplay-Regular", size: 17)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    let cornerRadius: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.lightYellow
        contentView.layer.cornerRadius = cornerRadius
        UIView.giveStandardShadow(toView: contentView)
        
        contentView.addSubview(nameLabel)
        nameLabel.anchor(top: contentView.centerYAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 4, left: 8, bottom: 0, right: 8))
        
        contentView.addSubview(stateLabel)
        stateLabel.anchor(top: nil, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 9, right: 8))
        
        let inset: CGFloat = 4
        contentView.addSubview(imageView)
        imageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: inset, left: inset, bottom: 0, right: 0))
        
        let height = AppDelegate.cellHeight / 2 - inset * 2
        imageView.anchorSize(size: CGSize(width: height, height: height))
        
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
    
    fileprivate func setUI(fromDeviceType type: DeviceType, andState isOn: Bool) {
        let lightGray1 = UIColor(white: 0.8, alpha: 1)
//        let lightGray2 = UIColor(white: 0.7, alpha: 1)
        
        switch type {
            
        case .light:
            
            if isOn {
//                contentView.setHorizontalGradient(color1: .lightYellow, color2: .darkYellow, withCornerRadius: cornerRadius)
                contentView.backgroundColor = .lightYellow
                imageView.image = #imageLiteral(resourceName: "lightbulb")
            } else {
//                contentView.setHorizontalGradient(color1: lightGray1, color2: lightGray2, withCornerRadius: cornerRadius)
                contentView.backgroundColor = lightGray1
                imageView.image = #imageLiteral(resourceName: "lightbulb")
            }
            
        case .camera:
            
            if isOn {
//                contentView.setHorizontalGradient(color1: .lightSkyBlue, color2: .darkSkyBlue, withCornerRadius: cornerRadius)
                contentView.backgroundColor = .lightSkyBlue
                imageView.image = #imageLiteral(resourceName: "camera")
            } else {
//                contentView.setHorizontalGradient(color1: lightGray1, color2: lightGray2, withCornerRadius: cornerRadius)
                contentView.backgroundColor = lightGray1
                imageView.image = #imageLiteral(resourceName: "camera")
            }

        case .door:
            
            if isOn {
//                contentView.setHorizontalGradient(color1: .lightOrange, color2: .darkOrange, withCornerRadius: cornerRadius)
                contentView.backgroundColor = .lightOrange
                imageView.image = #imageLiteral(resourceName: "door")
            } else {
//                contentView.setHorizontalGradient(color1: lightGray1, color2: lightGray2, withCornerRadius: cornerRadius)
                contentView.backgroundColor = lightGray1
                imageView.image = #imageLiteral(resourceName: "door")
            }

        case .extra:
//            contentView.setHorizontalGradient(color1: .lightPurple, color2: .darkPurple, withCornerRadius: cornerRadius)
            contentView.backgroundColor = .lightPurple
            imageView.image = #imageLiteral(resourceName: "random")
        }
    }
    
    func updateUI() {
        setUI(fromDeviceType: item.type, andState: item.isOn)
    }
    
}
