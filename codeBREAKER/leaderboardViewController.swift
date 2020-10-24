//
//  leaderboardViewController.swift
//  codeBREAKER
//
//  Created by user145843 on 10/23/18.
//  Copyright © 2018 T3Tech. All rights reserved.
//

import UIKit
import Firebase
class leaderboardViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    
    let rootRef = FIRDatabase.database().reference()
    let userInfo = FIRAuth.auth()?.currentUser
    @IBOutlet weak var tableView: UITableView!
    var usernamesGlob: Array<String> = []
    var scoresGlob: Array<Int> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "customTableViewCell", bundle: nil ), forCellReuseIdentifier: "customPodiumCell")
        }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customPodiumCell",for: indexPath) as!  customTableViewCell
        //print("here 51")
        cell.usernameLabel.text = usernamesGlob[indexPath.row]
        cell.scoreLabel.text = String(scoresGlob[indexPath.row])
        cell.placeLabel.text = " # "+String(indexPath.row+1)
        if indexPath.row == 0{ //set the first row to Gold
            cell.backgroundColor = UIColor.init(displayP3Red: 255/255, green: 215/255, blue: 0/255, alpha: 1.0)
        }
        else if indexPath.row == 1{ //set the second row to sliver
            cell.backgroundColor = UIColor.init(displayP3Red: 192/255, green: 192/255, blue: 192/255, alpha: 1.0)
        }
        else if indexPath.row == 2{ //set the third row to bronzw
            cell.backgroundColor = UIColor.init(displayP3Red: 205/255, green: 127/255, blue: 50/255, alpha: 1.0)
        }
        else{  //set the rest of the rows to white
            cell.backgroundColor = UIColor.white
        }
        return cell
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var allUsers = self.rootRef.child("users")
        for var i in 0 ... usernamesGlob.count{
            //print(i)
            while i > 0 && i < usernamesGlob.count && scoresGlob[i] > scoresGlob[i-1]{
                var temp = scoresGlob[i]
                var temp1 = usernamesGlob[i]
                scoresGlob[i] = scoresGlob[i-1]
                usernamesGlob[i] = usernamesGlob[i-1]
                scoresGlob[i-1] = temp
                usernamesGlob[i-1] = temp1
                i -= 1
                
            }
        }
        //print(self.usernamesGlob.count)
        return self.usernamesGlob.count
    }
     
    
}
    /*
    // MARK: - Navigationpq

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



