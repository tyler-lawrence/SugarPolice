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
        BackgroundGradient()
            .overlay{
                Text(messageManager.currentMessage)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.2)
                    .foregroundStyle(.white)
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
        .environmentObject(MessageManager.testMessageManager)
}
