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
            HStack {
                Spacer()
                Link(
                    destination: URL(string: "https://www.icloud.com/shortcuts/badf0627de8a4b1bbe29c755c2fc41f0")!,
                    label: {
                        HStack(spacing: 0) {
                            Image(systemName: "square.2.layers.3d.fill")
                            Text("get the shortcut")
                                .padding()
                        }
                        
                    }
                )
            }
            Spacer()
            TextField("Report a new infraction", text: $message)
                .font(.largeTitle)
                .padding()
            Divider()
            HStack {
                Text("Repeat offenses:")
                    .font(.title)
                Picker("Previous infractions", selection: $message) {
                    ForEach(messageManager.messages, id:\.self) { m in
                        Text(m)
                            .lineLimit(1)
                    }
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
        
    }
}

#Preview{
    SetupView()
        .environmentObject(MessageManager.testMessageManager)
}
