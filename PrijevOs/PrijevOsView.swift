//
//  PrijevOsView.swift
//  PrijevOs
//
//  Created by user236283 on 2/2/23.
//

import SwiftUI

struct PrijevOsView: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive{
            ContentView()
        } else{
            VStack{
                VStack{
                    Image("image")
                        .font(.system(size: 80))
                        
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.isActive = true
                }
            }
        }
    }
}

struct PrijevOsView_Previews: PreviewProvider {
    static var previews: some View {
        PrijevOsView()
    }
}
