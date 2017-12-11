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
    
     let loginManager = FBSDKLoginManager()
    
    var selectedALbumID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "my Albums"
        // Do any additional setup after loading the view.
        FbAlbumHandler.fetchAlbums()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable), name: Notification.Name("AlbumsFetched"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTable), name: Notification.Name("CoverPhotoFetched"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // User is not logged in
        if FBSDKAccessToken.current() == nil {
            performSegue(withIdentifier: "ShowLogin", sender: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("AlbumsFetched"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("CoverPhotoFetched"), object: nil)
    }
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        loginManager.logOut()
        performSegue(withIdentifier: "ShowLogin", sender: nil)
    }
    

}

extension AlbumsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FbAlbumHandler.albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCollectionViewCell
        cell.albumItem = FbAlbumHandler.albums[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedALbumID = FbAlbumHandler.albums[indexPath.row].id
        performSegue(withIdentifier: "ShowPhotos", sender: self)
    }
    
    
    @objc func updateTable() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
    }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhotos" {
            let photosViewController = segue.destination as? PhotosViewController
            if photosViewController != nil {
                if let id = selectedALbumID {
                    photosViewController?.albumID = id
                }
            }
        }
    }
}
