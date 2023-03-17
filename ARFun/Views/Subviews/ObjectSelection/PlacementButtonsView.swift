//
//  PlacementButtonsView.swift
//  marketing-app
//
//  Created by eric collom on 2/22/23.
//

import SwiftUI

struct PlacementButtonsView: View {
    
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: ARModel?
    @Binding var modelConfirmedForPlacement: ARModel?
    
    func reset() {
        isPlacementEnabled = false
        selectedModel = nil
    }
    
    var body: some View {
        HStack {
            Button {
                reset()
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
            
            Button {
                self.modelConfirmedForPlacement = self.selectedModel
                reset()
            } label: {
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }

        }
    }
}

struct PlacementButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        PlacementButtonsView(isPlacementEnabled: .constant(true),
                             selectedModel: .constant(nil),
                             modelConfirmedForPlacement: .constant(nil))
    }
}
