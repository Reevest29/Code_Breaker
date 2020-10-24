//
//  ViewController.swift
//  codeBREAKER
//
//  Created by user145843 on 9/20/18.
//  Copyright © 2018 T3Tech. All rights reserved.
//

import UIKit
import  Firebase
class ViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    var usernames: Array<String> = []
    var scores: Array<Int> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        var rootRef = FIRDatabase.database().reference()
        print(FIRAuth.auth()?.currentUser?.uid)
        if FIRAuth.auth()?.currentUser != nil{
            var uid = FIRAuth.auth()?.currentUser?.uid
            rootRef.child("users").child(uid!).child("Username").observeSingleEvent(of: .value, with: { snapshot in
                var username =  snapshot.value
                self.usernameLabel.text = username as! String
            })
            welcomeLabel.isHidden = false
            usernameLabel.isHidden = false
            

            
            
            
            
        }
                    var allUsers = rootRef.child("users")
            allUsers.observeSingleEvent(of: .value, with: { snapshot in
                //print("Here 40")
                self.usernames = snapshot
                    .children
                    .compactMap { $0 as? FIRDataSnapshot }
                    .compactMap { $0.value as? [String:Any] }
                    .compactMap { $0["Username"] as? String}
                self.scores =
                    snapshot.children
                        .compactMap { $0 as? FIRDataSnapshot }
                        .compactMap { $0.value as? [String:Any] }
                        .compactMap { $0["Score"] as? Int}
                
                
            })
            
        }
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLeader"{
            let LVC = segue.destination as! leaderboardViewController
            LVC.usernamesGlob = usernames
            LVC.scoresGlob = scores
            //print("here 62")
    
    }
        if segue.identifier == "goToGame"{
            if FIRAuth.auth()?.currentUser?.email != nil{
                let GVC = segue.destination as! gameViewController
                GVC.username = self.usernameLabel.text!
                GVC.bestScore = scores[usernames.index(of: GVC.username)!]
            }
        }
        if segue.identifier == "goToLogin"{
            let LogVC = segue.destination as! LoginViewController
            LogVC.usernames = usernames
        }
        
        
    }


}

