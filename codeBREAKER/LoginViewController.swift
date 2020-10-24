//
//  LoginViewController.swift
//  codeBREAKER
//
//  Created by user145843 on 10/18/18.
//  Copyright © 2018 T3Tech. All rights reserved.
//

import UIKit
import  Firebase
class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageViewHieght: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        var safe = UIScreen.main.bounds.maxY
        ////print(safe)
        imageViewHieght.constant = (safe) * 0.35
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var topView: UIView!
    let rootRef = FIRDatabase.database().reference()
    var readySegue = false
    var usernames: Array<String> = []
    @IBAction func RegesterAction(_ sender: Any) {
        var allUsers = FIRDatabase.database().reference().child("users")
        allUsers.observeSingleEvent(of: .value, with: { snapshot in
            self.usernames = snapshot
                .children
                .compactMap { $0 as? FIRDataSnapshot }
                .compactMap { $0.value as? [String:Any] }
                .compactMap { $0["Username"] as? String}
        })
        var usernameText = usernameLabel.text!
        ////print("heelo",usernames)
        ////print(usernameText)
        if usernames.contains(usernameText){
            errorLabel.text = "Username is not avaliable"
        }
            else if self.usernameLabel.text! != ""{
        
        
                FIRAuth.auth()?.createUser(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
            if error != nil{
                ////print(error.debugDescription)
                let errorM:String = (error?.localizedDescription)!
                self.errorLabel.text = errorM
                self.errorLabel.isHidden = false
            }
            else {
                ////print("Registration sucsessfull")
                FIRAuth.auth()?.signIn(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                    ////print(error)

                    if error == nil{
                        let userInfo = FIRAuth.auth()?.currentUser
                        let userRef = self.rootRef.child("users").child((userInfo?.uid)!)
                        userRef.child("Email").setValue(userInfo?.email)
                        userRef.child("Username").setValue(self.usernameLabel.text)
                        userRef.child("Score").setValue(0)
                        ////print("Login Sucsessfull")
                        self.readySegue = true
                        self.performSegue(withIdentifier: "goToMenu", sender: self)
                    }
                    else{
                        self.errorLabel.text = error?.localizedDescription
                    }
                })
            }
        })
        }
        
        else{
            
            errorLabel.text = "Username cannot be Nothing"
            errorLabel.isHidden = false
            ////print("~~~~~~~~"+usernameLabel.text!)
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if readySegue{
            return true
        }
        else if identifier == "goBack"{
            return true
            
        }
        else{
            return false
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
            ////print(error)
            
            if error == nil{
                ////print("Login  Sucsessful")
                self.readySegue = true
                self.performSegue(withIdentifier: "goToMenu", sender: self)
            }
            else{
                self.errorLabel.text = error?.localizedDescription
            }
        })    }
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
