//
//  ARCompassView.swift
//  marketing-app
//
//  Created by eric collom on 2/15/23.
//

import SwiftUI
import RealityKit
import ARKit

struct ARContentView: View {
    
    @State private var isPlacementEnabled = false
    @State private var selectedModel: ARModel?
    @State private var modelConfirmedForPlacement: ARModel?
    
    private var models: [ARModel] = {
        let filemanager = FileManager.default
        guard let path = Bundle.main.resourcePath,
              let files = try? filemanager.contentsOfDirectory(atPath: path)
        else {
            return []
        }
                
        var availableModels: [ARModel] = []
        for filename in files where filename.hasSuffix("usdz") {
            let name = filename.replacingOccurrences(of: ".usdz", with: "")
            let model = ARModel(name: name)
            
            availableModels.append(model)
        }
        
        return availableModels
    }()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARFunView(modelConfirmedForPlacement: $modelConfirmedForPlacement)
            
            if self.isPlacementEnabled {
                PlacementButtonsView(isPlacementEnabled: $isPlacementEnabled,
                                     selectedModel: $selectedModel,
                                     modelConfirmedForPlacement: $modelConfirmedForPlacement)
            } else {
                ARObjectPickerView(isPlacementEnabled: $isPlacementEnabled,
                                   selectedModel: $selectedModel,
                                   models: models)
            }
        }
        .ignoresSafeArea()
    }
}


struct ARContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ARContentView()
        }
    }
}
