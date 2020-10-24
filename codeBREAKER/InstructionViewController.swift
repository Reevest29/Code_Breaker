//
//  InstructionViewController.swift
//  codeBREAKER
//
//  Created by user145843 on 11/10/18.
//  Copyright © 2018 T3Tech. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds
class InstructionViewController: UIViewController {

    var bannerView: GADBannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let adSize = GADAdSizeFromCGSize(CGSize(width: 320, height: 100))
        bannerView = GADBannerView(adSize: adSize)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-7349651961210984/4298096298"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.isHidden = false
        
        
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .top,
                                relatedBy: .equal,
                                toItem: topLayoutGuide,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
