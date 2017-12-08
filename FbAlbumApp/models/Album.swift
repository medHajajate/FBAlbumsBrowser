//
//  Album.swift
//  FbAlbumApp
//
//  Created by Mohammed Hajajate on 12/8/17.
//  Copyright © 2017 Mohammed Hajajate. All rights reserved.
//

import UIKit

struct Album {
    let id: String
    let name: String
    let coverPhotoId: String
    
    init(id: String,name: String, coverPhotoId: String) {
        self.id = id
        self.name = name
        self.coverPhotoId = coverPhotoId
    }
    
    var coverPhotoURL: String?
    
}
