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
        .onAppear{
            stopBackgroundSound()
            messageManager.loadMessages()
        }
        .onDisappear{
            startBackgroundSound()
        }
    }
}

#Preview{
    SetupView()
        .environmentObject(MessageManager())
}
