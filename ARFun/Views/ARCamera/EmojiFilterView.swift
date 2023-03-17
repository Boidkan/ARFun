//
//  EmojiFilterView.swift
//  marketing-app
//
//  Created by eric collom on 3/6/23.
//

import SwiftUI
import ARKit

/// To get magical face numbers use https://github.com/bobbymay/ARFaceGeometry-Map/blob/master/ScreenShot.png

struct EmojiFilterView: UIViewRepresentable {
    
    
    @Binding var tookPicture: Bool
    @Binding var filterType: ARFaceFilterType
    
    class Coordinator: EmojiFilterViewCoordinator {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> ARSCNView {
        let view = ARSCNView()
        
        context.coordinator.sceneView = view
        view.delegate = context.coordinator

        let configuration = ARFaceTrackingConfiguration()
        view.session.run(configuration)
        return view
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        
        // need these blank references in order to trigger updateView on state change
        _ = filterType
        _ = tookPicture
        
        context.coordinator.filterType = filterType
        
        if tookPicture {
            context.coordinator.takePicture(uiView)
        }
    }
}
