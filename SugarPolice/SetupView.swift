//
//  SetupView.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 9/1/23.
//

import SwiftUI

struct SetupView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var messageManager: MessageManager
    @State private var message: String = ""
    
    var body: some View {
        
        #if os(watchOS)
        watchLayout
            .onAppear{
                stopBackgroundSound()
                messageManager.loadMessages()
            }
            .onDisappear{
                startBackgroundSound()
            }
        
        #else
        phoneLayout
            .onAppear{
                stopBackgroundSound()
                messageManager.loadMessages()
            }
            .onDisappear{
                startBackgroundSound()
            }
        #endif
    }
    
    var watchLayout: some View {
        TabView{
            
            VStack{
                TextField("Write an infraction", text: $message)
                    .font(.largeTitle)
                    .padding()
                Button("Sound the alarm") {
                    messageManager.updateCurrentMessage(message)
                    messageManager.hideSheet()
                    dismiss()
                }
            }
            
            Picker("Previous infractions", selection: $message) {
                ForEach(messageManager.messages, id:\.self) { m in
                    Text(m)
                }
            }
            .onDisappear{
                messageManager.currentMessage = message
            }
        }
    }
    
    var phoneLayout: some View {
        VStack {
            TextField("Write an infraction", text: $message)
                .font(.largeTitle)
                .padding()
            Picker("Previous infractions", selection: $message) {
                ForEach(messageManager.messages, id:\.self) { m in
                    Text(m)
                }
            }
            Button("Sound the alarm") {
                messageManager.updateCurrentMessage(message)
                messageManager.hideSheet()
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .disabled(message.isEmpty)
            
        }
    }
}

#Preview{
    SetupView()
        .environmentObject(MessageManager())
}
