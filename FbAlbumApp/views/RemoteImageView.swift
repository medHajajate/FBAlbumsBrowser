//
//  RemoteImageView.swift
//  FbAlbumApp
//
//  Created by Mohammed Hajajate on 12/8/17.
//  Copyright © 2017 Mohammed Hajajate. All rights reserved.
//

import UIKit
import Siesta

let RemoteImageService = _RemoteImageService()

class _RemoteImageService {
    
    // MARK: - Configuration
    
    private let service = Service()
    
    var defaultImageService: Service {
        return service
    }
    
    fileprivate init() {
        #if DEBUG
            LogCategory.enabled = [.network]
        #endif
    }
}

class RemoteImageView: UIImageView {
    /// Optional view to show while image is loading.
    @IBOutlet public weak var loadingView: UIView?
    /// Optional image to show if image is either unavailable or loading.
    @IBInspectable public var placeholderImage: UIImage?
    
    /// The default service to cache `RemoteImageService` images.
    /// The service this view should use to request & cache its images.
    @objc
    public var imageService: Service = RemoteImageService.defaultImageService
    
    /// A URL whose content is the image to display in this view.
    @objc
    public var imageURL: String?
    {
        get { return imageResource?.url.absoluteString }
        set { imageResource = imageService.resource(absoluteURL: newValue) }
    }
    
    /// Optional image transform applyed to placeholderImage and downloaded image
    @objc
    public var imageTransform: (UIImage?) -> UIImage? = { $0 }
    
    /**
     A remote resource whose content is the image to display in this view.
     If this image is already in memory, it is displayed synchronously (no flicker!). If the image is missing or
     potentially stale, setting this property triggers a load.
     */
    @objc
    public var imageResource: Resource?
    {
        willSet
        {
            imageResource?.removeObservers(ownedBy: self)
            imageResource?.cancelLoadIfUnobserved(afterDelay: 0.05)
        }
        
        didSet
        {
            imageResource?.loadIfNeeded()
            imageResource?.addObserver(owner: self)
            { [weak self] _,_ in self?.updateViews() }
            
            if imageResource == nil  // (and thus closure above was not called on observerAdded)
            { updateViews() }
        }
    }
    
    private func updateViews()
    {
        DispatchQueue.main.async(execute: {
            self.image = self.imageTransform(self.imageResource?.typedContent(ifNone: self.placeholderImage))
        })
        let isLoading = imageResource?.isLoading ?? false
        loadingView?.isHidden = !isLoading
    }

}

