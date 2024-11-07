//
//  ContentView.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 8/31/23.
//

import SwiftUI
import TipKit

struct SirenView: View {
    
    @EnvironmentObject var messageManager: MessageManager
    let messageSetupTip = MessageSetupTip()
    var body: some View {
        BackgroundGradient()
            .overlay{
                VStack {
                    TipView(messageSetupTip, arrowEdge: .top)
                    Text(messageManager.currentMessage)
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.2)
                        .foregroundStyle(.white)
                }
                .padding()
            }
            .onTapGesture {
                messageManager.showingSheet = true
            }
            .onAppear {
                startBackgroundSound()
            }
            .sheet(isPresented: $messageManager.showingSheet){
                SetupView()
                    .presentationDetents([.medium])
            }
    }
}

#Preview {
    SirenView()
        .environmentObject(MessageManager.testMessageManager)
}
