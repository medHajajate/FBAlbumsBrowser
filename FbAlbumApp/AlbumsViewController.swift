//
//  AlbumsViewController.swift
//  FbAlbumApp
//
//  Created by Mohammed Hajajate on 12/7/17.
//  Copyright © 2017 Mohammed Hajajate. All rights reserved.
//

import UIKit

import FBSDKCoreKit
import FBSDKLoginKit

class AlbumsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "my Albums"
        // Do any additional setup after loading the view.
        FbHandler.fetchAlbums()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable), name: Notification.Name("AlbumsFetched"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable), name: Notification.Name("CoverPhotoFetched"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension AlbumsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FbHandler.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCollectionViewCell
        cell.albumItem = FbHandler.albums[indexPath.row]
        return cell
    }
    
    
    
    @objc func updateTable() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
    }
    }
}
