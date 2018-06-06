//
//  Utility.swift
//  youtube
//
//  Created by Nadiia Pavliuk on 5/7/18.
//  Copyright © 2018 Nadiia Pavliuk. All rights reserved.
//


import UIKit

final class Utility: NSObject {
    private override init() { }
    static let shared = Utility()
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func CGSizeMake( _ width:CGFloat, _ height:CGFloat) -> CGSize{
        return CGSize(width: width, height: height)
    }
}
