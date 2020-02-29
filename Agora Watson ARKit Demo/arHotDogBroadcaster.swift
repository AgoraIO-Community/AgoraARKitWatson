//
//  arHotDogBroadcaster.swift
//  Agora Watson ARKit Demo
//
//  Created by Hermes Frangoudis on 1/22/20.
//  Copyright © 2020 Agora.io. All rights reserved.
//

import Vision
import UIKit
import ARKit
import AgoraARKit

class arHotDogBroadcaster: ARBroadcaster {
    
    let textDepth : Float = 0.01 // the 'depth`' of 3D text
    var clearBtn: UIButton!
    var resultsRootNode: SCNNode!
    
    // COREML
    let mlModel: MLModel = Hotdog().model
    var visionRequests = [VNRequest]()
    let dispatchQueueML = DispatchQueue(label: "io.agora.dispatchqueue.ml") // A Serial Queue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up Vision Model
        guard let hotDogModel = try? VNCoreMLModel(for: mlModel) else {
            fatalError("Could not load model. Ensure Coreml model is in your XCode Project and part of a target (see: https://stackoverflow.com/questions/45884085/model-is-not-part-of-any-target-add-the-model-to-a-target-to-enable-generation ")
        }
        
        // Set up Vision-CoreML Request
        let classificationRequest = VNCoreMLRequest(model: hotDogModel, completionHandler: classificationCompleteHandler)
        classificationRequest.imageCropAndScaleOption = VNImageCropAndScaleOption.centerCrop // Crop from centre of images and scale to appropriate size.
        visionRequests = [classificationRequest]
        
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        resultsRootNode = SCNNode()
        sceneView.scene.rootNode.addChildNode(resultsRootNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dispatchQueueML.async {
            self.runCoreML() // Run Update
        }
    }
    
    // UI
    override func createUI() {
        super.createUI()
        // add clear button to UI
        let clearBtn: UIButton = UIButton()
        clearBtn.frame = CGRect(x: self.view.frame.minX+25, y: self.view.frame.maxY - 65, width: 40, height: 40)
        if let clearBtnImage = UIImage(named: "trash") {
            clearBtn.setImage(clearBtnImage, for: .normal)
        } else {
            clearBtn.setTitle("clear", for: .normal)
        }
        
        clearBtn.addTarget(self, action: #selector(clearResults), for: .touchUpInside)
        self.view.insertSubview(clearBtn, at: 2)
    }
    
    // MARK: - CoreML Vision Handling
    func classificationCompleteHandler(request: VNRequest, error: Error?) {
        // Catch Errors
        if error != nil {
            print("Error: " + (error?.localizedDescription)!)
            return
        }
        guard let observations = request.results else {
            print("No results")
            return
        }
        
        // Get Classifications
        let classification: VNClassificationObservation = observations.first as! VNClassificationObservation

        DispatchQueue.main.async {
            // Print Classifications
            print("--")
            
            // Display Debug Text on screen
            let debugText: String = "- \(classification.identifier) : \(classification.confidence)"
            print(debugText)
            
            // Display prediction
            var objectName: String = "Not Hotdog"
            if classification.confidence > 0.4 {
                objectName = "Hotdog"
            }
            
            // show the result
            self.showResult(objectName)
        }
    }
    
    

    func runCoreML() {
        // Get Camera Image as RGB
        guard let sceneView = self.sceneView else { return }
        guard let currentFrame = sceneView.session.currentFrame else { return }
        let pixbuff : CVPixelBuffer = currentFrame.capturedImage
        let ciImage = CIImage(cvPixelBuffer: pixbuff)
        
        // Prepare CoreML/Vision Request
        let imageRequestHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])

        // Run Image Request
        do {
            try imageRequestHandler.perform(self.visionRequests)
        } catch {
            print(error)
        }
        
    }
    
    //MARK: Show CV in AR
    func showResult(_ result: String) {
        // HIT TEST : REAL WORLD
        // Get Screen Centre
        let screenCentre : CGPoint = CGPoint(x: self.sceneView.bounds.midX, y: self.sceneView.bounds.midY)
        
        let arHitTestResults : [ARHitTestResult] = sceneView.hitTest(screenCentre, types: [.featurePoint]) // Alternatively, we could use '.existingPlaneUsingExtent' for more grounded hit-test-points.
        
        if let closestResult = arHitTestResults.first {
            // Get Coordinates of HitTest
            let transform : matrix_float4x4 = closestResult.worldTransform
            let worldCoord : SCNVector3 = SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
            
            // Create 3D Text
            let node : SCNNode = createNewResultsNode(result)
            resultsRootNode.addChildNode(node)
            node.position = worldCoord
        }
    }
    
    func createNewResultsNode(_ text : String) -> SCNNode {
        // Warning: Programmatically generating 3D Text is susceptible to crashing. To reduce chances of crashing; reduce number of polygons, letters, smoothness, etc.
        print("shwo result: \(text)")
        // Billboard contraint to force text to always face the user
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = SCNBillboardAxis.Y
        
        // SCN Text
        let scnText = SCNText(string: text, extrusionDepth: CGFloat(textDepth))
        var font = UIFont(name: "Helvetica", size: 0.15)
        font = font?.withTraits(traits: .traitBold)
        scnText.font = font
        scnText.alignmentMode = CATextLayerAlignmentMode.center.rawValue
        scnText.firstMaterial?.diffuse.contents = UIColor.orange
        scnText.firstMaterial?.specular.contents = UIColor.white
        scnText.firstMaterial?.isDoubleSided = true
        scnText.chamferRadius = CGFloat(textDepth)
        
        // Text Node
        let (minBound, maxBound) = scnText.boundingBox
        let textNode = SCNNode(geometry: scnText)
        // Centre Node - to Centre-Bottom point
        textNode.pivot = SCNMatrix4MakeTranslation( (maxBound.x - minBound.x)/2, minBound.y, textDepth/2)
        // Reduce default text size
        textNode.scale = SCNVector3Make(0.2, 0.2, 0.2)
        
        // Sphere Node
        let sphere = SCNSphere(radius: 0.005)
        sphere.firstMaterial?.diffuse.contents = UIColor.cyan
        let sphereNode = SCNNode(geometry: sphere)
        
        // Text Parent Node
        let textParentNode = SCNNode()
        textParentNode.addChildNode(textNode)
        textParentNode.addChildNode(sphereNode)
        textParentNode.constraints = [billboardConstraint]
        
        return textParentNode
    }
    
    @objc func clearResults() {
        for child in resultsRootNode.childNodes {
            child.isHidden = true
            child.removeFromParentNode()
        }
    }
}


