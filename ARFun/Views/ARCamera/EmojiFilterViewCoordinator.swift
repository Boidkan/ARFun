//
//  EmojiFilterViewCoordinator.swift
//  marketing-app
//
//  Created by eric collom on 3/6/23.
//

import SwiftUI
import ARKit

enum ARFaceFilterType {
    case dog
    case emojis
}

enum ARFaceNodeType: String {
    case hat
    case face
    case leftEye
    case rightEye
    case mouth
    
    static var all: [ARFaceNodeType] {
        return [.hat, .face, .leftEye, .rightEye, .mouth]
    }
    
    static func types(for filterType: ARFaceFilterType) -> [ARFaceNodeType] {
        switch filterType {
        case .dog:
            return [.face]
        case .emojis:
            return [.hat, .leftEye, .rightEye, .mouth]
        }
    }
    
    var emojis: [String] {
        switch self {
        case .hat: return ["🎩"]
        case .face: return ["🐶"]
        case .leftEye, .rightEye: return ["👁"]
        case .mouth: return ["👅"]
        }
    }
    
    var widthAndHeight: CGFloat {
        switch self {
        case .hat: return 0.15
        case .face: return 0.25
        case .leftEye, .rightEye, .mouth: return 0.05
        }
    }
    
    var verticesIndices: [Int] {
        switch self {
        case .hat: return [20]
        case .leftEye: return [1062]
        case .rightEye: return [1107]
        case .mouth: return [24, 25]
        case .face: return [15]
        }
    }
}

class EmojiFilterViewCoordinator: NSObject, ARSCNViewDelegate {
    
    var sceneView: ARSCNView?
    private var didUpdateFilter: Bool = false
    var filterType: ARFaceFilterType? {
        willSet {
            didUpdateFilter = newValue != filterType
        }
    }
    
    private let imageSaver = ImageSaverService()

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        guard let device = sceneView?.device,
              let faceAnchor = anchor as? ARFaceAnchor
        else {
            return nil
        }
        
        let faceGeometry = ARSCNFaceGeometry(device: device)
        let node = SCNNode(geometry: faceGeometry)
        node.geometry?.firstMaterial?.fillMode = .lines
        
        node.geometry?.firstMaterial?.transparency = 0.0
        
        addNodes(node: node)
        
        updateFeatures(for: node, using: faceAnchor)
        
        return node
    }
    
    func addNodes(node: SCNNode) {
        ARFaceNodeType.all.forEach {
            let childNode = self.node(for: $0)
            node.addChildNode(childNode)
        }
    }
    
    func node(for type: ARFaceNodeType) -> EmojiNode {
        let node = EmojiNode(with: type.emojis, width: type.widthAndHeight, height: type.widthAndHeight)
        node.name = type.rawValue
        
        if type == .leftEye {
            node.name = ARFaceNodeType.leftEye.rawValue
            node.rotation = SCNVector4(0, 1, 0, GLKMathDegreesToRadians(180.0))
        }
        
        return node
    }
    
    func updateChildNodes(node: SCNNode) {
        
        let emojiNames = ARFaceNodeType.types(for: .emojis).map { $0.rawValue }
        
        node.enumerateChildNodes { node, _ in
            if filterType == .emojis {
                node.isHidden = node.name == ARFaceNodeType.face.rawValue
            } else if filterType == .dog {
                guard let name = node.name else { return }
                node.isHidden = emojiNames.contains(name)
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer,
                  didUpdate node: SCNNode,
                  for anchor: ARAnchor) {
        
        guard let faceAnchor = anchor as? ARFaceAnchor,
              let faceGeometry = node.geometry as? ARSCNFaceGeometry else {
            return
        }
        
        if didUpdateFilter {
            didUpdateFilter = false
            updateChildNodes(node: node)
        }
        
        faceGeometry.update(from: faceAnchor.geometry)
        updateFeatures(for: node, using: faceAnchor)
    }
    
    func updateFeatures(for node: SCNNode, using anchor: ARFaceAnchor) {
        
        guard let filterType = filterType else { return }
        
        if filterType == .dog {
            guard let child = node.childNode(withName: ARFaceNodeType.face.rawValue, recursively: false) as? EmojiNode else { return }
            let vertices = [anchor.geometry.vertices[15]]
            child.updatePosition(for: vertices)
        } else if filterType == .emojis {
            
            let emojiNodeTypes = ARFaceNodeType.types(for: filterType)
            
            for type in emojiNodeTypes {
                let child = node.childNode(withName: type.rawValue, recursively: false) as? EmojiNode
                let vertices = type.verticesIndices.map { anchor.geometry.vertices[$0] }
                child?.updatePosition(for: vertices)
                
                transform(node: child,
                          type: type,
                          anchor: anchor)
            }
        }
    }
    
    private func transform(node: EmojiNode?, type: ARFaceNodeType, anchor: ARFaceAnchor) {
        switch type {
            
        case .leftEye:
            // ADD Winking
            let scaleX = node?.scale.x ?? 1.0
            let eyeBlinkValue = anchor.blendShapes[.eyeBlinkLeft]?.floatValue ?? 0.0
            node?.scale = SCNVector3(scaleX, 1.0 - eyeBlinkValue, 1.0)
        case .rightEye:
            // ADD Winking
            let scaleX = node?.scale.x ?? 1.0
            let eyeBlinkValue = anchor.blendShapes[.eyeBlinkRight]?.floatValue ?? 0.0
            node?.scale = SCNVector3(scaleX, 1.0 - eyeBlinkValue, 1.0)
        case .hat:
            // MOVE to top of head
            node?.pivot = SCNMatrix4MakeTranslation(0, -0.07, 0)
        case .mouth:
            // ADD toungue if out
            let scaleX = node?.scale.x ?? 1.0
            let tongueValue = anchor.blendShapes[.tongueOut]?.floatValue ?? 1
             
            node?.scale = SCNVector3(scaleX, tongueValue > 0.8 ? 1 : tongueValue, 1)
        default:
            break
        }
    }

    func takePicture(_ view: ARSCNView) {
        let image = view.snapshot()
        imageSaver.writeToPhotoAlbum(image: image)
    }
}
