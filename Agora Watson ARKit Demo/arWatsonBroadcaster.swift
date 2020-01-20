//
//  arWatsonBroadcaster.swift
//  Agora Watson ARKit Demo
//
//  Created by Hermes Frangoudis on 1/17/20.
//  Copyright © 2020 Agora.io. All rights reserved.
//

import Foundation
import VisualRecognition
import IBMSwiftSDKCore

class arWatsonBroadcaster: ARBroadcaster {
    
//    func authenticate(request: RestRequest, completionHandler: @escaping (RestRequest?, RestError?) -> Void) {
//        print("authenticate RestRequest")
//    }
//
//    func authenticate(request: URLRequest, completionHandler: @escaping (URLRequest?, RestError?) -> Void) {
//        print("authenticate URLRequest")
//    }
//
    
    let watsonAuth: WatsonAuthenticator = WatsonIAMAuthenticator(apiKey: "tFvymVbfSpY-pIrlduqgSsxIBhAZagluDVd4caP7dTsl", url: "https://api.us-south.visual-recognition.watson.cloud.ibm.com/instances/91a3a4e9-c831-4b2c-b788-49602a27972c")
    var visualRecognition: VisualRecognition!
    
    // Name of the classifier to use
    let classifierID = "food"

    // Minimum confidence threshold for image recognition
    let threshold = 0.5
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pixbuff : CVPixelBuffer? = (sceneView.session.currentFrame?.capturedImage)
        if pixbuff == nil { return }
        let ciImage = CIImage(cvPixelBuffer: pixbuff!)
        let image = UIImage(ciImage: ciImage)
        let threshold = 0.5

        // Classify your image using your model
        visualRecognition.classifyWithLocalModel(image: image, classifierIDs: [classifierID], threshold: threshold) { classifiedImages, error in
            if let error = error {
               print(error)
            }
            guard let classifiedImages = classifiedImages else {
               print("Failed to classify the image")
               return
            }
           print(classifiedImages)
        }


    }


    override func viewDidLoad() {
        super.viewDidLoad()
        let visualRecognition = VisualRecognition(version: "2018-03-19", authenticator: watsonAuth)
        self.visualRecognition = visualRecognition
        // Update or download your model
        visualRecognition.updateLocalModel(classifierID: classifierID) { _, error in
            if let error = error {
                print(error)
            } else {
                print("model successfully updated")
            }
        }
    }
}
