//
//  BackgroundGradient.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 9/30/23.
//

import SwiftUI

struct BackgroundGradient: View {
    
    @State var colorToggle = false
    
    var backgroundGradient: LinearGradient {
        var g: LinearGradient
        if colorToggle {
            g = LinearGradient(colors: [.blue, .white], startPoint: .leading, endPoint: .trailing)
        } else {
            g = LinearGradient(colors: [.white, .red], startPoint: .leading, endPoint: .trailing)
        }
        return g
    }
    
    var body: some View {
        backgroundGradient
            .edgesIgnoringSafeArea(.all)
            .onAppear{
                _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) {timer in
                    colorToggle.toggle()
                }
            }
    }
}

#Preview {
    BackgroundGradient()
}
