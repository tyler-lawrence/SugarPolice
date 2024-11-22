//
//  PreviousInfractionsView.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 11/6/24.
//

import SwiftUI

struct PreviousInfractionsView: View {
    @EnvironmentObject var messageManager: MessageManager
    @Binding var selectedMessage: String
    @State var selection: String?
    
    var body: some View {
        
        if messageManager.messages.isEmpty {
            ContentUnavailableView("No previous infractions", systemImage: "megaphone")
        } else {
            List {
                ForEach(messageManager.messages, id: \.self){ message in
                    Button {
                        toggleSelectedMessage(message)
                    } label: {
                        HStack {
                            Text(message)
                            Spacer()
                            if selection == message {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .foregroundStyle(.primary)
                }
                .onDelete(perform: messageManager.removeMessage(at:))
            }
            .onAppear {
                messageManager.loadMessages()
            }
            .onDisappear {
                if selection != nil {
                    messageManager.updateCurrentMessage(selectedMessage)
                }
            }
        }
    }
    private func toggleSelectedMessage(_ message: String) {
        if selection == message {
            selection = nil
        } else {
            selection = message
            selectedMessage = message
            messageManager.updateCurrentMessage(selectedMessage)
        }
    }
}

#Preview {
    NavigationStack {
        PreviousInfractionsView(selectedMessage: .constant("test"))
            .environmentObject(MessageManager.testMessageManager)
    }
}
