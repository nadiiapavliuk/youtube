//
//  ApiService.swift
//  youtube
//
//  Created by Nadiia Pavliuk on 5/14/18.
//  Copyright © 2018 Nadiia Pavliuk. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    //if we want to have this function in separate class we have to add : see all comments and in class HomeController see next step
    
    static let sharedInstance = ApiService()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
   

    
    //    func fetchVideos() { //rewrite!!!
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/home_num_likes.json") { (videos) in
             completion(videos)
        }
        //this part was repeaten in all 3 functions and we call it with url in "function fetchFeedForUrlString {...}"
//        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
//        URLSession.shared.dataTask(with: url!) { (data, responce, error) in
//            if error != nil {
//                print(error!)
//                return
//            }
//
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//
//                //                self.videos = [Video]() //rewrite this!!!!
//                var videos = [Video]()
//
//                for dictionary in json as! [[String: AnyObject]] {
//
//                    let video = Video()
//                    video.title = dictionary["title"] as? String
//                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//                    video.numberOfViews = dictionary["number_of_views"] as? NSNumber
//                    let channelDictionary = dictionary["channel"] as! [String:AnyObject]
//                    let channel = Channel()
//                    channel.name = channelDictionary["name"] as? String
//                    channel.profileImage = channelDictionary["profile_image_name"] as? String
//
//                    video.channel = channel
//                    // self.videos?.append(video) //rewrite!!!
//                    videos.append(video)
//
//                }
//
//                DispatchQueue.main.async {
//                    // self.collectionView?.reloadData() //rewrite!!!
//                    completion(videos)
//                }
//            } catch let jsonError {
//                print(jsonError)
//            }
//
//
//            } .resume()
//
    }
    
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json") { (videos) in
            completion(videos)
        }
    }
    
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json") { (videos) in
            completion(videos)
        }
    }
    
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            DispatchQueue.main.async {
                
                if let error = error {
                    print(error)
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    completion(try decoder.decode([Video].self, from: data))
                } catch let jsonError {
                    print("Failed to decode: ", jsonError)
                }
            }
            }.resume()
        
    }
}




//old version of this function
    
//    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
//        let url = URL(string: urlString)
//        URLSession.shared.dataTask(with: url!) { (data, responce, error) in
//            if error != nil {
//                print(error!)
//                return
//            }
//
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//
//                //                self.videos = [Video]() //rewrite this!!!!
//                var videos = [Video]()
//
//                for dictionary in json as! [[String: AnyObject]] {
//
//                    let video = Video()
//                    video.title = dictionary["title"] as? String
//                    video.thumbnail_image_name = dictionary["thumbnail_image_name"] as? String
//                    video.number_of_views = dictionary["number_of_views"] as? NSNumber
//
//                    //video.setValuesForKeys(dictionary)
//
//                    let channelDictionary = dictionary["channel"] as! [String:AnyObject]
//                    let channel = Channel()
//                    channel.name = channelDictionary["name"] as? String
//                    channel.profileImage = channelDictionary["profile_image_name"] as? String
//
//                    video.channel = channel
//                    // self.videos?.append(video) //rewrite!!!
//                    videos.append(video)
//
//                }
//
//                DispatchQueue.main.async {
//                    // self.collectionView?.reloadData() //rewrite!!!
//                    completion(videos)
//                }
//            } catch let jsonError {
//                print(jsonError)
//            }
//
//
//            } .resume()
//
//    }
    
    
    
    

