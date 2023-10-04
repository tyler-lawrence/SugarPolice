//
//  MessageManager.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 9/12/23.
//

import Foundation
import SwiftUI

class MessageManager: ObservableObject {
    
    static let shared = MessageManager()
    
    // MARK: - app storage keys
    static let suiteName = "group.com.academy.SugarPolice"
    static let previousMessagesKey = "previousMessages"
    static let currentMessageKey = "currentMessage"
    static let showingSheetKey = "showingSheet"
    
    let defaults = UserDefaults(suiteName: suiteName)
    
    // MARK: - properties
    @Published var messages: [String] = [String]()
    @AppStorage(currentMessageKey, store: UserDefaults(suiteName: suiteName)) var currentMessage: String = ""
    @AppStorage(showingSheetKey, store: UserDefaults(suiteName: suiteName)) var showingSheet: Bool = false
    
    
    // MARK: - Initialization
    private init(){
        loadMessages()
    }

    
    // MARK: - Methods
    func hideSheet() {
        guard let defaults = defaults else { return }
        self.showingSheet = false
        defaults.set(false, forKey: MessageManager.showingSheetKey)
    }
    
    func updateCurrentMessage(_ message: String) {
        guard let defaults = defaults else { return }
        defaults.set(message, forKey: MessageManager.currentMessageKey)
        addMessage(message)
    }
    
    func addMessage(_ message: String) {
        guard let defaults = defaults else { return }
        var priorMessages = defaults.array(forKey: MessageManager.previousMessagesKey) as? [String] ?? [String]()
        
        // validate message
        guard !priorMessages.contains(message) else { return }
        guard !message.isEmpty else { return }
        
        priorMessages.append(message)
        defaults.set(priorMessages, forKey: MessageManager.previousMessagesKey)
    }
    
    func loadMessages()  {
        guard let defaults = defaults else { return }
        let priorMessages: [String]? = defaults.array(forKey: MessageManager.previousMessagesKey) as? [String]
        self.messages = priorMessages ?? [String]()
    }
    
}

#if DEBUG
extension MessageManager {
    static let testMessageManager = MessageManager()
}
#endif
