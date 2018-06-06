//
//  Video.swift
//  youtube
//
//  Created by Nadiia Pavliuk on 4/24/18.
//  Copyright © 2018 Nadiia Pavliuk. All rights reserved.
//

import UIKit


//class  Video: NSObject {
//    var thumbnail_image_name: String?
//    var title: String?
//    var number_of_views: NSNumber?
//    var uploadDate: NSDate?
//    var duration: NSNumber?
//    
//    var channel: Channel?
//}
//class Channel:NSObject{
//    var name:String?
//    var profileImage:String?
//}


struct Video: Decodable {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: Int?
    var uploadDate: Date?
    var duration: Int?
    var numberOfLikes: Int?
    
    var channel: Channel?
    
}

struct Channel: Decodable {
    
    var name: String?
    var profileImageName: String?
    
}
