//
//  DemoButtonView.swift
//  ARFun
//
//  Created by e on 3/16/23.
//

import SwiftUI

struct DemoButtonView: View {
    
    var demo: DemoSummary
    
    var body: some View {
        NavigationLink(value: demo) {
            HStack {
                Image(systemName: demo.icon)
                    .resizable()
                    .frame(maxWidth: 50, maxHeight: 50)
                    .scaledToFit()
                    .padding(.leading, 0)
                
                Text(demo.description)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.horizontal, 0)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.blue)
                    .padding(.trailing, 0)
                    .background(.blue)
                    
            }
            .background(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .buttonStyle(PlainButtonStyle())
        .background(.white)
        .padding(.zero)
        .borderWithRoundedCorners(cornerRadius: 15)
    }
}

struct DemoButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let demo = DemoSummary(icon: "cube.transparent",
                               description: "word wrap",
                               type: .AR)
        DemoButtonView(demo: demo)
    }
}
