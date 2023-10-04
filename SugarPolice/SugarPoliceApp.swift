//
//  SugarPoliceApp.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 8/31/23.
//

import SwiftUI

@main
struct SugarPoliceApp: App {
    @StateObject var messageManager = MessageManager.shared
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            SirenView()
                .environmentObject(messageManager)
                .onChange(of: scenePhase){ newPhase in
                    if newPhase == .background{
                        messageManager.showingSheet = false
                        messageManager.hideSheet()
                    }
                }
        }
    }
}
