//
//  SugarPoliceApp.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 8/31/23.
//

import SwiftUI
import TipKit

@main
struct SugarPoliceApp: App {
    
    @StateObject var messageManager = MessageManager()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            SirenView()
                .environmentObject(messageManager)
                .onChange(of: scenePhase){ _, newPhase in
                    if newPhase == .background{
                        messageManager.showingSheet = false
                        messageManager.hideSheet()
                    }
                }
        }
    }
    init() {
        try? Tips.configure([.displayFrequency(.immediate), .datastoreLocation(.applicationDefault)])
    }
}
