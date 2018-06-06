//
//  VideoCell.swift
//  youtube
//
//  Created by Nadiia Pavliuk on 3/29/18.
//  Copyright © 2018 Nadiia Pavliuk. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class VideoCell: BaseCell {
    var video: Video? {
        didSet {
         
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            
            setupProfileImage()

            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitleText = "\(channelName) • \( numberFormatter.string(for: numberOfViews)!)" + "\n" + "• 2 years ago"
                
//                let subtitleText = "\(channelName) • \(numberFormatter.string(from: numberOfViews)!)" + "\n" + "• 2 years ago"
//
//
                subtitleTextView.text = subtitleText
                
            }
            
            //measure title text
            if let title = video?.title {
                //let size = CGSize(width: frame.width - 16 - 8 - 44 - 16, height: 1000)
                let size = Utility.shared.CGSizeMake(frame.width - 16 - 8 - 44 - 16 , 1000)
                
                
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: 13)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
            
            
        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
            
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
            
        }
    }
    
    func  setupThumbnailImage() {
        if let thumbnailImageUrl = video?.thumbnailImageName {
            
            self.thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)

        }
    }
    
    
   
    
    
    
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        //imageView.backgroundColor = UIColor.blue
        //imageView.image = UIImage(named: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        //imageView.backgroundColor = UIColor.red
       // imageView.image = UIImage(named: "search")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
       // imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.brown
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        // label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
       // label.text = "Any text....fbfdhjckxz,nbcvxhjdsknmbcfhdsjk.."
        label.numberOfLines = 2
        return label
    }()
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.black
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = UIColor.lightGray
        //textView.text = "subtitle text is here. ...looooooooonngggggg gggggggggggggghjh hgggggfgffybgvcfdfgyhjvhcdfry jjj."
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.isEditable = false
        textView.isSelectable = false
        return textView
    }()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        backgroundColor = UIColor.black
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        // Auto layout constraints
        
        //        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions() , metrics: nil, views: ["v0": thumbnailImageView]))
        
        
        //horizontal constraints:
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]|", views: userProfileImageView)
        
        //vertical constraints:
        
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-38-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
        //top constraints
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)
        addConstraint(titleLabelHeightConstraint!)
        
//
//        //top constraints
//        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 8))
//
//        //left constraint
//        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
//
//        //right constraint
//        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
//
//        //height constraint
//        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
//
        
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: titleLabel, attribute: .left, multiplier: 1, constant: 0))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
}


