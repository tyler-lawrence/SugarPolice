//
//  SoundSelectionView.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 11/11/24.
//

import SwiftUI

struct SoundSelectionView: View {
    
    @State var selection: String?
    
    var body: some View {
        List {
            ForEach(SirenSound.allCases, id: \.self){ sirenSound in
                Button {
                    //TODO: play sound
                    AudioManager.shared.stopBackgroundSound()
                    AudioManager.shared.play(sirenSound)
                    selection = sirenSound.label
                    AudioManager.shared.setPreferredSound(to: sirenSound.label)
                } label: {
                    HStack {
                        Text(sirenSound.icon)
                        Text(sirenSound.label)
                        Spacer()
                        if selection == sirenSound.label {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .foregroundStyle(.primary)
            }
        }
        .onAppear {
            selection = AudioManager.shared.preferredSound
        }
        .onDisappear {
            AudioManager.shared.stopBackgroundSound()
        }
    }
}

#Preview {
    SoundSelectionView()
}
