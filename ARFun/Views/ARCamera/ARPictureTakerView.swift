//
//  ARPictureTakerView.swift
//  marketing-app
//
//  Created by eric collom on 3/6/23.
//

import SwiftUI
import ARKit


struct ARPictureTakerView: View {
    
    @State var tookPicture = false
    @State var filterType: ARFaceFilterType = .emojis
    
    var body: some View {
        ZStack {
            
            EmojiFilterView(tookPicture: $tookPicture, filterType: $filterType)
                .ignoresSafeArea(.all)
            
            if tookPicture {
                FadeOutView(trigger: $tookPicture)
            }
            
            VStack {
                Spacer()
                
                HStack(alignment: .center, spacing: 30) {
                    
                    Button {
                        filterType = .emojis
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 80, height: 80)
                                .cornerRadius(15)
                            Text("👁👅👁")
                        }
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.white)
                    
                    Button {
                        tookPicture = true
                    } label: {
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 75, height: 75)
                            Circle()
                                .foregroundColor(.black)
                                .frame(width: 70, height: 70)
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 65, height: 65)
                        }
                    }
                    
                    Button {
                        filterType = .dog
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 80, height: 80)
                                .cornerRadius(15)
                            Text("🐶")
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.white)
                    
                }
                .padding(.bottom, 35)
            }
        }
        .animation(.easeOut, value: 0.15)
    }
}

struct ARPictureTakerView_Previews: PreviewProvider {
    static var previews: some View {
        ARPictureTakerView()
    }
}
