//
//  Extensions.swift
//  youtube
//
//  Created by Nadiia Pavliuk on 3/29/18.
//  Copyright © 2018 Nadiia Pavliuk. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index,view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

let imageCache = NSCache<NSString , UIImage>()

class CustomImageView: UIImageView {
    var imageUrlString: String?
    
//    func loadImageUsingUrlString(urlString: String) {
//
//        imageUrlString = urlString
//        let url = URL(string: urlString)
//
//        image = nil
//        if let imageFromCache  = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
//            self.image = imageFromCache
//            return
//        }
//
//
//        URLSession.shared.dataTask(with: url!) { (data, responce, error) in
//            if error != nil {
//                print(error!)
//                return
//            }
//            DispatchQueue.main.async {
//                let imageToCache = UIImage(data: data!)
//                if self.imageUrlString == urlString {
//                    self.image = imageToCache
//                }
//                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
//
//            }
//
//            }.resume()
//
//    }
    
    func loadImageUsingUrlString(urlString:String){
        
        imageUrlString = urlString
        let url = URL(string: urlString)
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if error != nil{
                print(error!)
                return
            }
            DispatchQueue.main.async(execute: {
                let imageToCache = UIImage(data:data!)
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                
            })
        })
        task.resume()
    }
}
