//
//  ARObjectPickerView.swift
//  marketing-app
//
//  Created by eric collom on 2/22/23.
//

import SwiftUI

struct ARObjectPickerView: View {
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: ARModel?
    
    var models: [ARModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(models) { item in
                    Button {
                        self.selectedModel = item
                        isPlacementEnabled = true
                    } label: {
                        item.image
                            .resizable()
                            .frame(height: 80)
                            .aspectRatio(1/1, contentMode: .fit)
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }.padding(.horizontal, 20)
        }
        .padding(.top, 20)
        .padding(.bottom, 35)
        .background(Color.black.opacity(0.3))
    }
}

struct ARObjectPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ARObjectPickerView(isPlacementEnabled: .constant(false),
                           selectedModel: .constant(nil),
                           models: [ARModel(name: "teapot.usdz")])
    }
}
