//
//  AlbumTableViewCell.swift
//  FbAlbumApp
//
//  Created by Mohammed Hajajate on 12/8/17.
//  Copyright © 2017 Mohammed Hajajate. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleAlbum: UILabel!
    @IBOutlet weak var imageAlbum: RemoteImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var albumItem: Album? {
        didSet {
                titleAlbum.text = albumItem?.name
                imageAlbum.imageURL = albumItem?.coverPhotoURL
        }
    }

}

