//
//  SetupView.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 9/1/23.
//

import SwiftUI

struct SetupView: View {
    @Environment(\.dismiss) var dismiss
    @State private var message: String = ""
    @State var previousMessages = [String]()
    let defaults = UserDefaults(suiteName: "group.com.academy.SugarPolice") ?? UserDefaults.standard
    
    var body: some View {
        VStack {
            TextField("Write an infraction", text: $message)
                .font(.largeTitle)
                .padding()
            Picker("Previous infractions", selection: $message) {
                ForEach(previousMessages, id:\.self) { m in
                    Text(m)
                }
            }
            Button("Sound the alarm") {
                updateMessage(message)
                addMessage(message)
                dismiss()
                startBackgroundMusic(sound: "police-6007", type: "mp3")
            }
            .buttonStyle(.borderedProminent)
            
        }
        .onAppear{
            stopBackgroundMusic()
            previousMessages = defaults.array(forKey: "previousMessages") as? [String] ?? [String]()
        }
    }
    
    func updateMessage(_ message: String) {
        defaults.set(message, forKey: "message")
    }
    
    func addMessage(_ message: String) {
        var priorMessages = defaults.array(forKey: "previousMessages") as? [String] ?? [String]()
        if !priorMessages.contains(message) {
            priorMessages.append(message)
            defaults.set(priorMessages, forKey: "previousMessages")
        }
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView()
    }
}
