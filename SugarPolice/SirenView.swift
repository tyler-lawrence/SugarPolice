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
                .font(.system(size: 100))
            }
        .onTapGesture {
            messageManager.showingSheet = true
        }
        .onAppear {
            startBackgroundSound(sound: "siren", type: "mp3")
        }
        .sheet(isPresented: $messageManager.showingSheet){
            SetupView()
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SirenView()
            .environmentObject(MessageManager.testMessageManager)
    }
}
