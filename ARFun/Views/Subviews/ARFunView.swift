//
//  ARFunView.swift
//  marketing-app
//
//  Created by eric collom on 2/22/23.
//

import SwiftUI
import FocusEntity
import RealityKit

struct ARFunView: UIViewRepresentable {
    
    @Binding var modelConfirmedForPlacement: ARModel?

    func makeUIView(context: Context) -> ARView {
        return FocusARView(frame: .zero)
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        if let model = self.modelConfirmedForPlacement,
           let entity = model.entity?.clone(recursive: true) {

            let plane: AnchoringComponent.Target.Alignment = .any
            let anchor = AnchorEntity(plane: plane) // This causes an error when building for previews
            anchor.addChild(entity)
            uiView.scene.addAnchor(anchor)

            DispatchQueue.main.async {
                self.modelConfirmedForPlacement = nil
            }
        }
    }
}


struct ARFunView_Previews: PreviewProvider {
    static var previews: some View {
        ARFunView(modelConfirmedForPlacement: .constant(nil))
    }
}
