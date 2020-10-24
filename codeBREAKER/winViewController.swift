//
//  winViewController.swift
//  codeBREAKER
//
//  Created by user145843 on 9/30/18.
//  Copyright © 2018 T3Tech. All rights reserved.
//

import UIKit
import GoogleMobileAds

class winViewController: UIViewController, GADInterstitialDelegate {
    var mscore: Int = 0
    var receivedString = ""
    var fullAD: GADInterstitial!
    var addRan = false
    var bestScore = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = GADRequest()
        fullAD = createAndLoadInterstitial()
    }
    func createAndLoadInterstitial() -> GADInterstitial {
        var fullAD = GADInterstitial(adUnitID: "ca-app-pub-7349651961210984/2468556607")
        fullAD.delegate = self
        fullAD.load(GADRequest())
        return fullAD
    }
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        if !addRan {
            fullAD.present(fromRootViewController: self)
            addRan = true
        }
    }
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        performSegue(withIdentifier: "goToGame",sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get a reference to the second view controller
        let secondViewController = segue.destination as! gameViewController
        //print(receivedString)

            var new: String = ""
            for item in receivedString{
                var num = "1234567890"
                if num.contains(item){
                    new += String(item)
                
            }
               
            
        }
    
        secondViewController.score = Int(new)!
        secondViewController.bestScore = self.bestScore
        
    }
    func updateScore(score: Int) {
       // var score = OverviewClass.get()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
