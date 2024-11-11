//
//  NewReportView.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 11/8/24.
//

import SwiftUI

struct NewReportView: View {
    @EnvironmentObject var messageManager: MessageManager
    @State var message: String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
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
    }
}

#Preview {
    NewReportView()
        .environmentObject(MessageManager.testMessageManager)
}
