//
//  ViewController.swift
//  Agora Watson ARKit Demo
//
//  Created by Hermes Frangoudis on 1/14/20.
//  Copyright © 2020 Agora.io. All rights reserved.
//


import UIKit
import AgoraARKit

class ViewController: AgoraLobbyVC  {

    // MARK: VC Events
    override func loadView() {
        super.loadView()
        
        AgoraARKit.agoraAppId = ""
        
        // set the banner image within the initial view
        if let agoraLogo = UIImage(named: "watson_live_banner") {
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
    
    // UI
    override func createUI() {
        super.createUI()
        if let hotdog = UIImage(named: "hotdog-guy") {
            let hotdogGuy = UIImageView(image: hotdog)
            hotdogGuy.contentMode = .scaleAspectFit
            hotdogGuy.frame = CGRect(x: self.view.frame.maxX-100, y: self.view.frame.maxY-100, width: 75, height: 75)
            self.view.insertSubview(hotdogGuy, at: 2)
        }
        
        if let poweredBy = UIImage(named: "powered-by-agora") {
            let poweredByAgora = UIImageView(image: poweredBy)
            poweredByAgora.contentMode = .scaleAspectFit
            poweredByAgora.frame = CGRect(x: self.view.frame.midX-75, y: self.view.frame.maxY-55, width: 150, height: 37.5)
            self.view.insertSubview(poweredByAgora, at: 2)
        }
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
                if let exitBtnImage = UIImage(named: "exit") {
                    arBroadcastVC.backBtnImage = exitBtnImage
                }
                if let micBtnImage = UIImage(named: "mic"),
                    let muteBtnImage = UIImage(named: "mute") {
                    arBroadcastVC.micBtnImage = micBtnImage
                    arBroadcastVC.muteBtnImage = muteBtnImage
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

