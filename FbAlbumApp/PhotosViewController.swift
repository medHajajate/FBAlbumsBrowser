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
    
    var selectedPhotoUrl: String?
    
    let FbPhotoHandler = _FbPhotoHandler()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Log.msg(message: albumID!)
        if let id = albumID {
            FbPhotoHandler.fetchPhotos(by: id)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCollection), name: Notification.Name("PhotosFetched"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCollection), name: Notification.Name("PhotoURLFetched"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FbPhotoHandler.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        if let url = FbPhotoHandler.photos[indexPath.row].photoUrl {
            cell.image.imageURL = url
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPhotoUrl = FbPhotoHandler.photos[indexPath.row].photoUrl
        performSegue(withIdentifier: "showSinglePhoto", sender: self)
    }
    
   @objc func updateCollection() {
        DispatchQueue.main.async() {
            self.collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSinglePhoto" {
            let singlePhoto = segue.destination as? SinglePhotoViewController
            if singlePhoto != nil {
                if let url = selectedPhotoUrl {
                    singlePhoto?.imageUrl = url
                }
            }
        }
    }
}
