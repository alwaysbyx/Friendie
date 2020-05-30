//
//  storeViewController.swift
//  Friendie
//
//  Created by BB on 2020/5/30.
//  Copyright © 2020 Com. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class storeViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: storeView!
    
    var selectNode: SCNNode?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
        showFriends()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        sceneView.delegate = self
        //抗锯齿
        //sceneView.antialiasingMode = .multisampling4X
        showFriends()
        
        perform(#selector(hidenPreview), with: nil, afterDelay: 3)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandle(gesture:)))
        sceneView.addGestureRecognizer(tap)
 
        // Do any additional setup after loading the view.
    }
    

 
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension storeViewController {
    func showFriends() {
        sceneView.removeAllNodes()
        sceneView.addPhotoRing_Box(vector3: SCNVector3Make(0, 0, -6), left: 1, L: 40)
        sceneView.addPhotoRing_H(vector3: SCNVector3Make(0, -1.2, -6), left: -1, L: 10)
        sceneView.addPhotoRing_Box(vector3: SCNVector3Make(0, -2.4, -6), left: 1, L: 40)
        sceneView.addPhotoRing_V(vector3: SCNVector3Make(0, 1.5, -6), left: 1, L: 20)
        sceneView.addPhotoRing_V(vector3: SCNVector3Make(0, -4, -6), left: -1, L: 20)
        sceneView.addPhotoRing_Back(vector3: SCNVector3Make(0, -2, -8), left: -1, L: 2)

        
        //播放背景音乐
        let musicName = "花 が とぶ 飛ぶ"
        sceneView.playMusic(musicName: musicName)
 
        
        
        //粒子效果
        sceneView.addParticleSytem()
    }

    @objc func hidenPreview() {
        UIView.animate(withDuration: 1.2) {
            self.view.layoutIfNeeded()
        }
    }
}
//点击到的节点
extension storeViewController {
    @objc func tapHandle(gesture: UITapGestureRecognizer) {
        let results: [SCNHitTestResult] = (self.sceneView?.hitTest(gesture.location(ofTouch: 0, in: self.sceneView), options: nil))!
        guard let firstNode  = results.first else {
            return
        }
        // 点击到的节点
        let node = firstNode.node.copy() as? SCNNode

        if (node?.geometry?.isKind(of: SCNSphere.self))! {
            self.selectNode?.removeFromParentNode()
            return
        }

        if firstNode.node == self.selectNode {
            let newPosition  = SCNVector3Make(firstNode.node.worldPosition.x*2, firstNode.node.worldPosition.y*2, firstNode.node.worldPosition.z*2)
            let comeOut = SCNAction.move(to: newPosition, duration: 1.2)
            firstNode.node.runAction(comeOut)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2, execute: {
                firstNode.node.removeFromParentNode()
            })
        } else {
            self.selectNode?.removeFromParentNode()
            node?.position = firstNode.node.worldPosition
            let newPosition  = SCNVector3Make(firstNode.node.worldPosition.x/2, firstNode.node.worldPosition.y/2, firstNode.node.worldPosition.z/2)
            node?.rotation = (sceneView.pointOfView?.rotation)!
            sceneView.scene.rootNode.addChildNode(node!)
            let comeOn = SCNAction.move(to: newPosition, duration: 1.2)
            node?.runAction(comeOn)
            selectNode = node
        }
    }
}
// MARK: 按钮点击事件
extension storeViewController {
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
