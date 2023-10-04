//
//  IntentHandler.swift
//  SoundTheAlarmIntent
//
//  Created by Tyler Lawrence1 on 9/5/23.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is SoundTheAlarmIntent else {
          fatalError("Unhandled Intent error : \(intent)")
        }
       return SoundTheAlarmHandler()
    }

}

class SoundTheAlarmHandler: NSObject, SoundTheAlarmIntentHandling {
    
    let messageManager = MessageManager.shared
    
    func handle(intent: SoundTheAlarmIntent, completion: @escaping (SoundTheAlarmIntentResponse) -> Void) {
    
       if let crime = intent.crime {
           messageManager.updateCurrentMessage(crime)
           messageManager.hideSheet()
           completion(SoundTheAlarmIntentResponse.success(crime: crime))
       }
    }
    
    func resolveCrime(for intent: SoundTheAlarmIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let title = intent.crime else {
           completion(INStringResolutionResult.needsValue())
           return
        }
        completion(INStringResolutionResult.success(with: title))
    }

    private func donateIntent() {
        let intent = SoundTheAlarmIntent()
        intent.suggestedInvocationPhrase = "We have an infraction"
        let interaction = INInteraction(intent: intent, response: nil)
        interaction.donate { (error) in
            if error != nil {
                if let error = error as NSError? {
                    print("Interaction donation failed: \(error.description)")
                } else {
                    print("Successfully donated interaction")
                }
            }
        }
    }
}
