//
//  SetupView.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 9/1/23.
//

import SwiftUI

struct SetupView: View {
    
    enum Setup: String, CaseIterable {
        case report
        case customize
    }
    
    @State var selectedSetup: Setup = .report
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Setup", selection: $selectedSetup) {
                    ForEach(Setup.allCases, id: \.self){
                        Text($0.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                Spacer()
                switch selectedSetup {
                case .report:
                    NewReportView()
                case .customize:
                    SirenCustomizationView()
                }
                Spacer()
            }
            .toolbar {
                ToolbarItem {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}


#Preview{
    SetupView()
        .environmentObject(MessageManager.testMessageManager)
}
