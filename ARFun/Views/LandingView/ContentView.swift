//
//  ContentView.swift
//  ARFun
//
//  Created by e on 3/15/23.
//

import SwiftUI

struct ContentView: View {
    
    let demos = [DemoSummary(icon: "cube.transparent",
                             description: "Augmented Reality",
                             type: .AR),
                 DemoSummary(icon: "camera.aperture",
                             description: "Selfie Filters",
                             type: .selfies)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("AR Fun")
                    .frame(alignment: .center)
                    .padding(.horizontal, 15)
                    .font(.system(.title, weight: .bold))
                    .foregroundColor(.orange)
                ForEach(demos, id: \.self) { demo in
                    DemoButtonView(demo: demo)
                        .padding(.horizontal, 15)
                }
                Spacer()
            }
            .padding(.top, 50)
            .navigationDestination(for: DemoSummary.self) { demo in
                switch demo.type {
                case .selfies:
                    ARPictureTakerView()
                case .AR:
                    ARContentView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
