//
//  Photo.swift
//  FbAlbumApp
//
//  Created by Mohammed Hajajate on 12/8/17.
//  Copyright © 2017 Mohammed Hajajate. All rights reserved.
//

import UIKit

struct  Photo {
    let id: String
    let createdTime: String
    
    init(id: String, createdTime: String) {
        self.id = id
        self.createdTime = createdTime
    }
    
    var photoUrl: String?
}
