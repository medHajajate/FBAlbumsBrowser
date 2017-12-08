//
//  FbPhotoHandler.swift
//  FbAlbumApp
//
//  Created by Mohammed Hajajate on 12/8/17.
//  Copyright © 2017 Mohammed Hajajate. All rights reserved.
//

import Foundation

import FBSDKCoreKit
import FBSDKLoginKit

class FbPhotoHandler {
    
    var imagesQuantity: Int?
    var imagesFetched = 0
    
    
    enum PhotoSize: Int {
        case small = 225
        case medium
        case full
    }
    
    var photos: [Photo] = []
    
    func fetchPhotos(by id: String) {
        FBSDKGraphRequest(graphPath: "/\(id)/photos", parameters: nil, httpMethod: "GET").start {
            (connection, result, error) in
            if error == nil {
                if let resultDictionary = result as? [String: Any],
                    let resultDictionaryData = resultDictionary["data"] as? [[String: Any]] {
                    self.imagesQuantity = resultDictionaryData.count
                    for photoAttributes in resultDictionaryData {
                        if let photoID = photoAttributes["id"],
                            let photoTime = photoAttributes["created_time"] {
                            self.photos.append(Photo(id: String(describing: photoID), createdTime: String(describing: photoTime)))
                            self.fetchPhotoURL(by: String(describing: photoID))
                        }
                    }
                }
            } else {
                if let error = error?.localizedDescription {
                    print("Error: \(error)")
                }
            }
            NotificationCenter.default.post(name: Notification.Name("PhotosFetched"), object: nil)
        }
    }
    
    /// Fetch photo URL by id via Graph Request and save it in `photoList`
    func fetchPhotoURL(by id: String, lastImage: Bool = false, thumbnailSize: PhotoSize = .small) {
        var imageURL: String?
        
        FBSDKGraphRequest(graphPath: id, parameters: ["fields":"images"], httpMethod: "GET").start {
            (connection, result, error) in
            if error == nil {
                if let result = result as? [String: Any],
                    let resultImages = result["images"] as? [[String: Any]] {
                    for (imageIndex, imageAttributes) in resultImages.enumerated() {
                        if imageIndex == 0 {
                            if let imageSource = imageAttributes["source"] as? String {
                                imageURL = imageSource
                                
                            }
                        } else {
                            switch thumbnailSize {
                            case .small:
                                if let imageWidth = imageAttributes["width"] as? Int,
                                    let imageSource = imageAttributes["source"] as? String {
                                    imageURL = imageSource
                                }
                            default:
                                break
                            }
                        }
                    }
                }
            } else {
                if let error = error?.localizedDescription {
                    print("Error: \(error)")
                }
            }
            
            for (photoIndex, photoItem) in self.photos.enumerated() {
                if photoItem.id == id {
                    self.photos[photoIndex].photoUrl = imageURL
                }
            }
            
            self.imagesFetched += 1
            if let imagesQuantity = self.imagesQuantity,
                imagesQuantity == self.imagesFetched {
                NotificationCenter.default.post(name: Notification.Name("PhotoURLFetched"), object: nil)
                self.imagesFetched = 0
            }
            
        }
    }
}
