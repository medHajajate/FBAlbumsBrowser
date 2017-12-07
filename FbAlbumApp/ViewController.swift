//
//  ViewController.swift
//  FbAlbumApp
//
//  Created by Mohammed Hajajate on 12/4/17.
//  Copyright © 2017 Mohammed Hajajate. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loginButton.readPermissions = ["email", "user_photos"];
        loginButton.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        if FBSDKAccessToken.current() != nil {
            performSegue(withIdentifier: "showAlbums", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error == nil {
                Log.msg(message: "Log In")
                performSegue(withIdentifier: "showAlbums", sender: nil)
        } else {
            if let error = error?.localizedDescription {
                print("Error: \(error)")
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {}


}

