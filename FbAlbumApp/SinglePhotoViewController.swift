//
//  SinglePhotoViewController.swift
//  FbAlbumApp
//
//  Created by Mohammed Hajajate on 12/8/17.
//  Copyright © 2017 Mohammed Hajajate. All rights reserved.
//

import UIKit

class SinglePhotoViewController: UIViewController {

    @IBOutlet weak var singleImage: RemoteImageView!

    var imageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = imageUrl {
            singleImage.imageURL = url
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
