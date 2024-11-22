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
    static let previousMessagesKey = "previousMessages"
    static let currentMessageKey = "currentMessage"
    static let showingSheetKey = "showingSheet"
    
    let defaults = UserDefaults(suiteName: AppStorageKey.suiteName)
    
    // MARK: - properties
    @Published var messages: [String] = [String]()
    @AppStorage(currentMessageKey, store: UserDefaults(suiteName: AppStorageKey.suiteName)) var currentMessage: String = ""
    @AppStorage(showingSheetKey, store: UserDefaults(suiteName: AppStorageKey.suiteName)) var showingSheet: Bool = false
    
    // MARK: - Initialization
    init(){
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
    
    func saveMessages() {
        guard let defaults = defaults else { return }
        defaults.set(messages, forKey: MessageManager.previousMessagesKey)
    }
    
    func loadMessages() {
        guard let defaults = defaults else { return }
        let priorMessages: [String] = defaults.array(forKey: MessageManager.previousMessagesKey) as? [String] ?? [String]()
        self.messages = priorMessages
    }
    
    func removeMessage(at offsets: IndexSet) {
        messages.remove(atOffsets: offsets)
        saveMessages()
    }
    
}

#if DEBUG
extension MessageManager {
    static var testMessageManager: MessageManager {
        let messageManager = MessageManager()
        messageManager.currentMessage = "this is a big sugar infraction this is a big sugar infraction"
        messageManager.messages = [
            "sugar",
            "didn't code",
            "infraction"
        ]
        return messageManager
    }
}
#endif
