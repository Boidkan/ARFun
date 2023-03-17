//
//  View+Styling.swift
//  ARFun
//
//  Created by e on 3/16/23.
//

import SwiftUI

extension View {
    func borderWithRoundedCorners(lineWidth: CGFloat = 0.5,
                                  cornerRadius: CGFloat = 10) -> some View {
        
        
        
        return self
            .cornerRadius(cornerRadius)
            .shadow()
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.black, lineWidth: lineWidth)
            )
    }
    
    func shadow() -> some View {
        let color = Color.black
        return self.shadow(color: color, radius: 1, x: -1, y: 1)
    }
}
