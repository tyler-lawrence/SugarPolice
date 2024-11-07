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
    @AppStorage(MessageManager.currentMessageKey) private var message: String = ""
    
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
                message = ""
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
                    .font(.title2)
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
        NavigationStack {
            VStack {
                Spacer()
                TextField("Report a new infraction", text: $message)
                    .font(.title2)
                    .padding()
                Divider()
                NavigationLink{
                    PreviousInfractionsView(selectedMessage: $message)
                        .environmentObject(messageManager)
                } label: {
                    HStack{
                        Text("Previous Infractions")
                        Image(systemName: "chevron.right")
                    }
                }
                Spacer()
                HStack(spacing: 20) {
                    Button("🚨Sound the alarm") {
                        messageManager.updateCurrentMessage(message)
                        messageManager.hideSheet()
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(message.isEmpty)
                    
                    Button("Dismiss") {
                        messageManager.hideSheet()
                        dismiss()
                    }
                }
            }
            .padding()
            .toolbar {
                ToolbarItem {
                    Link("Get the Shortcut", destination: URL(string: "https://www.icloud.com/shortcuts/87cf14058ae34d84a1c689ab50785764")!)

                }
            }
        }
        
    }
}

#Preview{
    SetupView()
        .environmentObject(MessageManager.testMessageManager)
}
