//
//  ViewController.swift
//  ios-multiple-beacon-finder
//
//  Created by m.rakhmanov on 11.12.16.
//  Copyright © 2016 m.rakhmanov. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController, SCNSceneRendererDelegate {

    @IBOutlet weak var sceneView: SCNView!
    var scene: SCNScene!
    var cameraNode: SCNNode!
    var accuracyScene: AccuracyScene!
    
    lazy var sphere: SCNSphere = {
        let hydrogenAtom = SCNSphere(radius: 1.20)
        hydrogenAtom.firstMaterial!.diffuse.contents = UIColor.green
        return hydrogenAtom
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupScene()
        setupCamera()
        spawnShape()
        
        sceneView.delegate = self
        sceneView.isPlaying = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupView() {
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
    }
    
    func setupScene() {
        accuracyScene = AccuracyScene(size: view.bounds.size)
        scene = SCNScene()
        sceneView.scene = scene
        sceneView.overlaySKScene = accuracyScene
    }
    
    func setupCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 25)
        scene.rootNode.addChildNode(cameraNode)
    }
    
    func spawnShape() {
        let geometryNode = SCNNode(geometry: sphere)
        geometryNode.position = SCNVector3(x: 0, y: 0, z: 10)
        scene.rootNode.addChildNode(geometryNode)
    }
    
    // MARK: SCNSceneRendererDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
       // sphere.radius = CGFloat(arc4random_uniform(9) + 1)
       // print(sphere.radius)
    }
}

