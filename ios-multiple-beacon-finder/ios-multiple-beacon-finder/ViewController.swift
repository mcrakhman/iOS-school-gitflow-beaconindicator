//
//  ViewController.swift
//  ios-multiple-beacon-finder
//
//  Created by m.rakhmanov on 11.12.16.
//  Copyright © 2016 m.rakhmanov. All rights reserved.
//

import UIKit
import SceneKit
import CoreLocation

class ViewController: UIViewController, SCNSceneRendererDelegate, LocationServiceDelegate {

    @IBOutlet weak var sceneView: SCNView!
    var scene: SCNScene!
    var cameraNode: SCNNode!
    var accuracyScene: AccuracyScene!
    var locationService: LocationServiceImplementation!
    var tempoCounter: TempoCounter!
    var audioEngine: AudioEngine!
    
    let minAccuracy = 5.0
    
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
        
        setupServices()
        setupAudioEngine()
        setupTempoCounter()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Конфигурация
    
    func setupServices() {
        locationService = LocationServiceImplementation()
        
        let beacon = Beacon(name: "MyBeacon",
                            uuid: UUID(uuidString: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA7")!,
                            majorValue: 3,
                            minorValue: 3)
        locationService.register(beacon)
        
        locationService.delegate = self
    }
    
    func setupAudioEngine() {
        audioEngine = AudioEngine()
    }
    
    func setupTempoCounter() {
        tempoCounter = TempoCounter()
        tempoCounter.addHandler { [weak self] in
            self?.audioEngine.playBeepSound()
        }
        tempoCounter.start()
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
    
    func colorForSphere(accuracy: Double) -> UIColor {
        let hue = max((minAccuracy - accuracy) / minAccuracy * 0.20, 0.0)
        return UIColor(hue: CGFloat(hue),
                       saturation: 1.0,
                       brightness: 1.0,
                       alpha: 1.0)
    }
    
    // MARK: SCNSceneRendererDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {}
    
    // MARK: LocationServiceDelegate
    
    func didLocateClosest(_ beacon: CLBeacon) {
        accuracyScene.accuracy = Double(Int(beacon.accuracy * 100)) / 100
        sphere.firstMaterial?.diffuse.contents = colorForSphere(accuracy: beacon.accuracy)
    }
}

