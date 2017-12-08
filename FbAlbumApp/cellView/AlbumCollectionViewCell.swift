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
                titleAlbum.addGradientLayer(width: self.frame.width)
                imageAlbum.imageURL = albumItem?.coverPhotoURL
        }
    }

}

extension UILabel {
    func addGradientLayer(width: CGFloat){
        if self.layer.sublayers?.count == nil {
            let colors: [UIColor] = [ UIColor(red:0.0577, green:0.0577, blue:0.0577, alpha:1.0), .clear]
            let gradient = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.frame.size.width = width
            gradient.masksToBounds = true
            gradient.locations = [0.0, 0.75]
            gradient.colors = colors.map{$0.cgColor}
            self.layer.addSublayer(gradient)
        }
    }
}

