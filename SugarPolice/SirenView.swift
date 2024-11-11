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
    @AppStorage(AppStorageKey.preferredTypeface) var preferredTypeface: String = "Baskerville"
    var body: some View {
        BackgroundGradient()
            .overlay{
                VStack {
                    TipView(messageSetupTip, arrowEdge: .top)
                    Text(messageManager.currentMessage)
                        .font(Font.custom(preferredTypeface, size: 200))
                        .bold()
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
