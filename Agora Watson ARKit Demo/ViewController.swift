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
        
        AgoraARKit.agoraAppId = ""

        
        // set the banner image within the initial view
        if let agoraLogo = UIImage(named: "ar-support-icon") {
            self.bannerImage = agoraLogo
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
        
        // set images for UI elements within audience and broadcast view controllers
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: Button Actions
    @IBAction override func joinSession() {
        if let channelName = self.userInput.text {
            if channelName != "" {
                let arAudienceVC = ARAudience()
                if let exitBtnImage = UIImage(named: "exit") {
                    arAudienceVC.backBtnImage = exitBtnImage
                }
                arAudienceVC.channelName = channelName
                arAudienceVC.modalPresentationStyle = .fullScreen
                self.present(arAudienceVC, animated: true, completion: nil)
            } else {
               // TODO: add visible msg to user
               print("unable to join a broadcast without a channel name")
            }
        }
    }
    
    @IBAction override func createSession() {
        if let channelName = self.userInput.text {
            if channelName != "" {
                let arBroadcastVC = arHotDogBroadcaster()
//                let arBroadcastVC = arCoremlBroadcaster()
//                let arBroadcastVC = arWatsonBroadcaster()
//                let arBroadcastVC = ARBroadcaster()
                if let exitBtnImage = UIImage(named: "exit") {
                    arBroadcastVC.backBtnImage = exitBtnImage
                }
                if let micBtnImage = UIImage(named: "mic"),
                    let muteBtnImage = UIImage(named: "mute"),
                    let watermakerImage = UIImage(named: "agora-logo") {
                    arBroadcastVC.micBtnImage = micBtnImage
                    arBroadcastVC.muteBtnImage = muteBtnImage
                    arBroadcastVC.watermarkImage = watermakerImage
                }
                
                arBroadcastVC.channelName = channelName
                arBroadcastVC.modalPresentationStyle = .fullScreen
                self.present(arBroadcastVC, animated: true, completion: nil)
            } else {
               // TODO: add visible msg to user
               print("unable to launch a broadcast without a channel name")
            }
        }
    }
    
}

