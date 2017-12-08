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

let FbHandler = _FbHandler()

class _FbHandler {
    
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
    
    
}
