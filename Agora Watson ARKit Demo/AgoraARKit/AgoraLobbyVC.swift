//
//  AgoraLobby.swift
//  Agora-ARKit Framework
//
//  Created by Hermes Frangoudis on 1/14/20.
//  Copyright © 2020 Agora.io. All rights reserved.
//

import UIKit

open class AgoraLobbyVC: UIViewController  {

    var debug : Bool = false
    
    // VCs
    let arBroadcastVC = ARBroadcaster()
    let arAudienceVC = ARAudience()
    
    // UI properties
    var banner: UIImageView?
    var bannerImage: UIImage?
    var bannerFrame: CGRect?
    
    var broadcastBtnText: String = "Broadcast"
    var broadcastBtnColor: UIColor = .systemBlue
    
    var audienceBtnText: String = "Audience"
    var audienceBtnColor: UIColor = .systemGray
    
    var textFieldPlaceholder: String = "Channel Name"
    
    var userInput: UITextField!
    
    // MARK: VC Events
    override open func loadView() {
        super.loadView()
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        createUI()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // dismiss the keyboard when user touches the view
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }

    // MARK: Create UI
    private func createUI() {
        // add branded logo to remote view
        if let logoImage = self.bannerImage {
            let banner = UIImageView(image: logoImage)
            if let bannerFrame = self.bannerFrame {
                banner.frame = bannerFrame
            } else {
                 banner.frame = CGRect(x: self.view.center.x-100, y: self.view.center.y-275, width: 200, height: 200)
            }
            self.view.insertSubview(banner, at: 1)
        }

        
        // text input field
        let textField = UITextField()
        textField.frame = CGRect(x: self.view.center.x-150, y: self.view.center.y-40, width: 300, height: 40)
        textField.placeholder = textFieldPlaceholder
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.delegate = self
        self.view.addSubview(textField)
        userInput = textField

        //  create button
        let createBtn = UIButton()
        createBtn.frame = CGRect(x: textField.frame.midX+12.5, y: textField.frame.maxY + 20, width: 100, height: 50)
        createBtn.backgroundColor = broadcastBtnColor
        createBtn.layer.cornerRadius = 5
        createBtn.setTitle(broadcastBtnText, for: .normal)
        createBtn.addTarget(self, action: #selector(createSession), for: .touchUpInside)
        self.view.addSubview(createBtn)
        
        // add the join button
        let joinBtn = UIButton()
        joinBtn.frame = CGRect(x: createBtn.frame.minX-125, y: createBtn.frame.minY, width: 100, height: 50)
        joinBtn.backgroundColor = audienceBtnColor
        joinBtn.layer.cornerRadius = 5
        joinBtn.setTitle(audienceBtnText, for: .normal)
        joinBtn.addTarget(self, action: #selector(joinSession), for: .touchUpInside)
        self.view.addSubview(joinBtn)
    }
    
    // MARK: Button Actions
    @IBAction open func joinSession() {
        
        if let channelName = self.userInput.text {
            if channelName != "" {
                arAudienceVC.channelName = channelName
                arAudienceVC.modalPresentationStyle = .fullScreen
                self.present(arAudienceVC, animated: true, completion: nil)
            } else {
               // TODO: add visible msg to user
               print("unable to join a broadcast without a channel name")
            }
        }
    }
    
    @IBAction open func createSession() {
        if let channelName = self.userInput.text {
            if channelName != "" {
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



