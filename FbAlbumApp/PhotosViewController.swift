//
//  PhotosViewController.swift
//  FbAlbumApp
//
//  Created by Mohammed Hajajate on 12/8/17.
//  Copyright © 2017 Mohammed Hajajate. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    var albumID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.msg(message: albumID!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
