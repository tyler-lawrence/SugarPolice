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
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Setup", selection: $selectedSetup) {
                    ForEach(Setup.allCases, id: \.self){
                        Text($0.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                Spacer()
                switch selectedSetup {
                case .report:
                    NewReportView()
                case .customize:
                    SirenCustomizationView()
                }
                Spacer()
            }
            .padding()
        }
        .toolbar {
            ToolbarItem {
                Link("Get the Shortcut", destination: URL(string: "https://www.icloud.com/shortcuts/87cf14058ae34d84a1c689ab50785764")!)
            }
        }
       
    }
}


#Preview{
    SetupView()
        .environmentObject(MessageManager.testMessageManager)
}
