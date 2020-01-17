//
//  ViewController.swift
//  Agora Watson ARKit Demo
//
//  Created by Hermes Frangoudis on 1/14/20.
//  Copyright © 2020 Agora.io. All rights reserved.
//


import UIKit

class ViewController: AgoraLobbyVC  {

    // MARK: VC Events
    override func loadView() {
        super.loadView()
        
        AgoraARKit.agoraAppId = "66b9d68bd5a14be9b8d35c05fd34f88d"
//        self.arBroadcastVC = arCoremlBroadcaster()
        self.arBroadcastVC = arWatsonBroadcaster()
        
        // set the banner image within the initial view
        if let agoraLogo = UIImage(named: "ar-support-icon") {
            self.bannerImage = agoraLogo
        }
        
        // set images for UI elements within audience and broadcast view controllers
        if let exitBtnImage = UIImage(named: "exit") {
            self.arAudienceVC.backBtnImage = exitBtnImage
            self.arBroadcastVC.backBtnImage = exitBtnImage
        }
        
        if let micBtnImage = UIImage(named: "mic"),
            let muteBtnImage = UIImage(named: "mute"),
            let watermakerImage = UIImage(named: "agora-logo") {
            self.arBroadcastVC.micBtnImage = micBtnImage
            self.arBroadcastVC.muteBtnImage = muteBtnImage
            self.arBroadcastVC.watermarkImage = watermakerImage
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
}

