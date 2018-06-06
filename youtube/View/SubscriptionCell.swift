//
//  SubscriptionCell.swift
//  youtube
//
//  Created by Nadiia Pavliuk on 5/20/18.
//  Copyright © 2018 Nadiia Pavliuk. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
