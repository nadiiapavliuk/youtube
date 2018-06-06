//
//  ApiService.swift
//  youtube
//
//  Created by Nadiia Pavliuk on 5/14/18.
//  Copyright © 2018 Nadiia Pavliuk. All rights reserved.
//

import UIKit

class ApiService: NSObject {
 
    static let sharedInstance = ApiService()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
   
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/home_num_likes.json") { (videos) in
             completion(videos)
        }

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


