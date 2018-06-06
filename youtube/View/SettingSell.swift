//
//  SettingCell.swift
//  youtube
//
//  Created by Nadiia Pavliuk on 5/10/18.
//  Copyright © 2018 Nadiia Pavliuk. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.black
            print(isHighlighted)
            nameLabel.textColor = isHighlighted ? UIColor.black : UIColor.white
            iconImageView.tintColor = isHighlighted ? UIColor.black : UIColor.white
        }
    }
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.white
            }
            
        }
    }
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .left
        return label
    }()
    
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(20)]-8-[v1]|", views: iconImageView, nameLabel)
        
        
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-13-[v0(20)]|", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
