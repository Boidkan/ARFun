//
//  FadeOutView.swift
//  marketing-app
//
//  Created by eric collom on 3/7/23.
//

import SwiftUI

struct FadeOutView: View {
    @Binding var trigger: Bool
    
    var body: some View {
        Rectangle()
            .ignoresSafeArea(.all)
            .background(Color.black.opacity(0.8))
            .transition(.opacity)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    self.trigger = false
                }
            }
    }
}

struct FadeOutView_Previews: PreviewProvider {
    static var previews: some View {
        FadeOutView(trigger: .constant(true))
    }
}
