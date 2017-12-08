//
//  FbHandler.swift
//  FbAlbumApp
//
//  Created by Mohammed Hajajate on 12/8/17.
//  Copyright © 2017 Mohammed Hajajate. All rights reserved.
//

import Foundation

import FBSDKCoreKit
import FBSDKLoginKit

let FbAlbumHandler = _FbAlbumHandler()

class _FbAlbumHandler {
    
    var coversQuantity: Int?
    var coversFetched = 0
    
    enum PhotoSize: Int {
        case small = 225
        case medium
        case full
    }
    
    var albums: [Album] = []
    
    func fetchAlbums() {
        FBSDKGraphRequest(graphPath: "/me/albums", parameters: ["fields":"id,name,cover_photo, images"], httpMethod: "GET").start {
            (connection, result, error) in
            if error == nil {
                if let resultDictionary = result as? [String: Any],
                    let resultDictionaryData = resultDictionary["data"] as? [[String: Any]] {
                    self.coversQuantity = resultDictionaryData.count
                    for albumAttributes in resultDictionaryData {
                        if let albumID = albumAttributes["id"],
                            let albumName = albumAttributes["name"],
                            let albumCoverPhotoDictionary = albumAttributes["cover_photo"] as? [String: Any] {
                            if let albumCoverPhotoID = albumCoverPhotoDictionary["id"] {
                                self.albums.append(Album(id: String(describing: albumID), name: String(describing: albumName), coverPhotoId: String(describing: albumCoverPhotoID)))
                                  self.fetchCoverPhotoURL(by: String(describing: albumCoverPhotoID))
                            }
                        }
                    }
                }
            } else {
                if let error = error?.localizedDescription {
                    print("Error: \(error)")
                }
            }
            NotificationCenter.default.post(name: Notification.Name("AlbumsFetched"), object: nil)
        }
    }
    
    
    func fetchCoverPhotoURL(by id: String, size: PhotoSize = .small) {
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
                            switch size {
                            case .small:
                                if let imageWidth = imageAttributes["width"] as? Int,
                                    let imageSource = imageAttributes["source"] as? String {
                                    if imageWidth == size.rawValue {
                                        imageURL = imageSource
                                    }
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
            
            for (albumIndex, albumItem) in self.albums.enumerated() {
                if albumItem.coverPhotoId == id {
                    self.albums[albumIndex].coverPhotoURL = imageURL
                }
            }
            
            self.coversFetched += 1
            if let coversQuantity = self.coversQuantity,
                coversQuantity == self.coversFetched + 2 {
                NotificationCenter.default.post(name: Notification.Name("CoverPhotoFetched"), object: nil)
                self.coversFetched = 0
            }
            
        }
    }
    
}
