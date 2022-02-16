//
//  Images.swift
//  Feivan
//
//  Created by javigo on 16/2/22.
//

// shoutout Daniel Krom

import Foundation
import SwiftUI

func coreDataObjectFromImages(images: [UIImage]) -> Data? {
    let dataArray = NSMutableArray()
    
    for img in images {
        if let data = img.jpegData(compressionQuality: 0.5) {
            dataArray.add(data)
        }
    }
    
    return try? NSKeyedArchiver.archivedData(withRootObject: dataArray, requiringSecureCoding: true)
}

func imagesFromCoreData(object: Data?) -> [UIImage]? {
    var retVal = [UIImage]()

    guard let object = object else { return nil }
    if let dataArray = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: object) {
        for data in dataArray {
            if let data = data as? Data, let image = UIImage(data: data) {
                retVal.append(image)
            }
        }
    }
    
    return retVal
}
