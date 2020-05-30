//
//  storeView.swift
//  Friendie
//
//  Created by BB on 2020/5/30.
//  Copyright © 2020 Com. All rights reserved.
//

import UIKit
import ARKit

class storeView: ARSCNView {
    
    var videoPlayer: AVPlayer?
    lazy var musicPlayer: AVPlayer = {
        let  musicPlayer = AVPlayer()
        return musicPlayer
    }()
    ///环的半径
    let ringRadius: Float = 6.0
    func removeAllNodes() {
        for node in self.scene.rootNode.childNodes {
            node.removeFromParentNode()
        }
        videoPlayer = nil
        musicPlayer.pause()
        NotificationCenter.default.removeObserver(self)
    }
    func addPhotoRing_V(vector3: SCNVector3, left: CGFloat, L: Int) {
        let photoRingNode = SCNNode()
        photoRingNode.position = SCNVector3Zero
        self.scene.rootNode.addChildNode(photoRingNode)
        let photoW: CGFloat = 1.4
        let photoH: CGFloat = photoW/0.618
        let radius: CGFloat = 0.02
        for index in 0..<L {
            let photo = SCNPlane(width: photoW, height: photoH)
            photo.cornerRadius = radius
            let image = "p1"
            photo.firstMaterial?.diffuse.contents = image
            let photoNode = SCNNode(geometry: photo)
            photoNode.position = vector3
            let emptyNode = SCNNode()
            emptyNode.position = SCNVector3Zero
            emptyNode.rotation = SCNVector4Make(0, 1, 0, Float.pi/Float(L/2) * Float(index))
            emptyNode.addChildNode(photoNode)
            photoRingNode.addChildNode(emptyNode)
        }
        let ringAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: left, z: 0, duration: 10))
        photoRingNode.runAction(ringAction)
    }
    func addPhotoRing_H(vector3: SCNVector3, left: CGFloat, L: Int) {
        let photoRingNode = SCNNode()
        photoRingNode.position = SCNVector3Zero
        self.scene.rootNode.addChildNode(photoRingNode)
        let photoW: CGFloat       = 2.8
        let photoH: CGFloat       = photoW * 0.618
        let radius: CGFloat = 0.02
        for index in 0..<L {
            let photo = SCNPlane(width: photoW, height: photoH)
            photo.cornerRadius = radius
            let image = "p1"
            photo.firstMaterial?.diffuse.contents = image
            let photoNode = SCNNode(geometry: photo)
            photoNode.position = vector3
            let emptyNode = SCNNode()
            emptyNode.position = SCNVector3Zero
            emptyNode.rotation = SCNVector4Make(0, 1, 0, Float.pi/Float(L/2) * Float(index))
            emptyNode.addChildNode(photoNode)
            photoRingNode.addChildNode(emptyNode)
        }
        let ringAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: left, z: 0, duration: 10))
        photoRingNode.runAction(ringAction)
    }
    func addPhotoRing_Box(vector3: SCNVector3, left: CGFloat, L: Int) {
        let photoRingNode = SCNNode()
        photoRingNode.position = SCNVector3Zero
        self.scene.rootNode.addChildNode(photoRingNode)
        let boxW: CGFloat       = 0.36
        for index in 0..<L {
            let box = SCNBox(width: boxW, height: boxW, length: boxW, chamferRadius: 0)
            
            let image = "p1"
            box.firstMaterial?.diffuse.contents = image
            
            let boxNode = SCNNode(geometry: box)
            boxNode.position = vector3
            let emptyNode = SCNNode()
            emptyNode.position = SCNVector3Zero
            emptyNode.rotation = SCNVector4Make(0, 1, 0, Float.pi/Float(L/2) * Float(index))
            emptyNode.addChildNode(boxNode)
            photoRingNode.addChildNode(emptyNode)
            var right: CGFloat = left
            if index%2 == 1 { right = -left }
            let ringAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: right, z: 0, duration: 2))
            boxNode.runAction(ringAction)
        }
    }
    
    func addPhotoRing_Back(vector3: SCNVector3, left: CGFloat, L: Int) {
        let photoRingNode = SCNNode()
        photoRingNode.position = SCNVector3Zero
        self.scene.rootNode.addChildNode(photoRingNode)
        let photoW: CGFloat       = CGFloat(2*ringRadius*sin(Float.pi/Float(L)) - 0.5)
        let photoH: CGFloat       = photoW * 0.618
        let radius: CGFloat = 0
        for index in 0..<L {
            let photo = SCNPlane(width: photoW, height: photoH)
            photo.cornerRadius = radius
            let image = "back"
            photo.firstMaterial?.diffuse.contents = image
            let photoNode = SCNNode(geometry: photo)
            photoNode.position = vector3
            let emptyNode = SCNNode()
            emptyNode.position = SCNVector3Zero
            emptyNode.rotation = SCNVector4Make(0, 1, 0, Float.pi/Float(L/2) * Float(index))
            emptyNode.addChildNode(photoNode)
            photoRingNode.addChildNode(emptyNode)
        }
        let ringAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: left, z: 0, duration: 20))
        photoRingNode.runAction(ringAction)
    }
    
    func addPanoramaImage(image: UIImage) {
        let sphere = SCNSphere(radius: 15)
        let sphereNode = SCNNode(geometry: sphere)
        sphere.firstMaterial?.isDoubleSided = true
        sphere.firstMaterial?.diffuse.contents = image
        sphereNode.position = SCNVector3Zero
        scene.rootNode.addChildNode(sphereNode)
    }
    
    func playMusic(musicName: String) {
        //播放音乐
        if let resourceUrl = Bundle.main.url(forResource: musicName, withExtension: "aac") {
            if FileManager.default.fileExists(atPath: resourceUrl.path) {
                let item = AVPlayerItem(url: resourceUrl)
                musicPlayer.replaceCurrentItem(with: item)
                musicPlayer.play()
            }
        }
    }
    func addParticleSytem() {
        let particleNode = SCNNode()
        var particleName =  "bokeh.scnp"
        if let particleSytem = SCNParticleSystem(named: particleName, inDirectory: nil) {
            particleNode.addParticleSystem(particleSytem)
            particleNode.position = SCNVector3Make(0, 0, 0)
            self.scene.rootNode.addChildNode(particleNode)
        }
    }
    @objc func playEnd(notify: Notification) {
        let item = notify.object as! AVPlayerItem
        if  musicPlayer.currentItem == item {
            musicPlayer.seek(to: CMTime.zero)
            musicPlayer.play()
        }
    }
}
