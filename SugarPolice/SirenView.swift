//
//  ContentView.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 8/31/23.
//

import SwiftUI

struct SirenView: View {
    
    @EnvironmentObject var messageManager: MessageManager
  
    var body: some View {
            ZStack {
                BackgroundGradient()
                Text(messageManager.currentMessage)
                    .foregroundColor(.white)
                    .font(.system(size: 300))
                    .minimumScaleFactor(0.2)
            }
            
            .onTapGesture {
                messageManager.showingSheet = true
            }
            .onAppear {
                startBackgroundSound()
            }
            .sheet(isPresented: $messageManager.showingSheet){
                SetupView()
            }
        } 
}

#Preview {
    SirenView()
        .environmentObject(MessageManager())
}
