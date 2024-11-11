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
            ForEach(SirenSound.allCases, id: \.self){ soundName in
                Button {
                    //TODO: play sound
                    selection = soundName.label
                    AudioManager.shared.setPreferredSound(to: soundName.label)
                } label: {
                    HStack {
                        Text(soundName.label)
                        Spacer()
                        if selection == soundName.label {
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
    }
}

#Preview {
    SoundSelectionView()
}
