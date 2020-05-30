//
//  GameViewController.swift
//  Friendie
//
//  Created by Com on 2020/5/24.
//  Copyright © 2020 Com. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

class GameViewController: UIViewController, ARSKViewDelegate {
    typealias Dependencies = PersistenceDependency & MusicDependency

    @IBOutlet var sceneView: ARSKView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    private let dependencies = DependencyContainer()
    private var volumeAction = MusicVolumeAction.mute
    weak var logicDelegate: GameSceneProtocol?
    
    var hasBuff = false
    
    var isVictory: Bool {
        return anchors.count == 0
    }

    // MARK: Private Properties
    private var anchors = [Anchor]()
    
    private (set) var timer = Timer()
    private var time = 0 {
        didSet{
            self.timeLabel.text = "\(time)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = false
        sceneView.showsNodeCount = false
        
        // Load the SKScene from 'Scene.sks'
//        if let scene = SKScene(fileNamed: "Scene") {
//            sceneView.presentScene(scene)
//        }
        let scene = Scene(size: sceneView.bounds.size)
        scene.scaleMode = .resizeFill
        sceneView.presentScene(scene)
        startTimer()
        
        
    }
    
    func startTimer() {

        time = 0
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(update),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func endTimer() {
        timer.invalidate()
    }

    @objc private func update() {

        time += 1
        //delegate?.controller(self, didUpdateTimeTo: time)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dependencies.musicProvider.apply(.start)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
        endTimer()
        dependencies.musicProvider.apply(.stop)
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        // Create and configure a node for the anchor added to the view's session.
//        let labelNode = SKLabelNode(text: "👾")
//        labelNode.horizontalAlignmentMode = .center
//        labelNode.verticalAlignmentMode = .center
//        return labelNode;
        
        guard let anchor = anchor as? Anchor, let type = anchor.type else { return nil }

        let node = type.asSprite()
        node.name = type.rawValue

        return node
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        endTimer()
        presentAlert()
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        guard let configuration = session.configuration else { return }

        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
    }
    
    @IBAction func onBackTouch(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        endTimer()
    }
    
    @IBAction func onMusicTouch(_ sender: UIButton) {
        //声音关闭
        dependencies.musicProvider.apply(volumeAction)
        volumeAction = volumeAction.invert()
    }
    
}

// MARK: - Alertable
extension GameViewController: Alertable {}

// MARK: - GameSceneProtocol
extension GameViewController: GameSceneProtocol {

    func gameScene(_ gameScene: Scene, created anchor: Anchor) {
        anchors.append(anchor)
    }

    func gameScene(_ gameScene: Scene, killed anchor: Anchor) {

        guard let index = anchors.index(of: anchor) else { return }
        anchors.remove(at: index)

        if isVictory {
            timer.invalidate()
            self.navigationController?.popViewController(animated: true)
            //TBD
//            delegate?.didWin(accordingTo: self, with: time)

        }
    }

    func gameScene(_ gameScene: Scene, picked buff: Anchor) {

        hasBuff = true
        guard let index = anchors.index(of: buff) else { return }
        anchors.remove(at: index)
    }

    func didFailWithBuff(in gameScene: Scene) {

        endTimer()
        self.navigationController?.popViewController(animated: true)
        //TBD
//        delegate?.didLose(accordingTo: self)
    }
}
