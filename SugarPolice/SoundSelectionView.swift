//
//  SoundSelectionView.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 11/11/24.
//

import SwiftUI

struct SoundSelectionView: View {
    
    @State var selection: String?
    
    var soundNames: [String] {
        guard let bundlePath = Bundle.main.resourcePath else { return [] }
        do {
            let typefaceDirectory = bundlePath + "/Sounds/"
            let contents: [String] = try FileManager.default.contentsOfDirectory(atPath: typefaceDirectory)
            
            return contents.map{($0 as NSString).deletingPathExtension}
        } catch {
            print(error)
        }
        return []
    }
    var body: some View {
        List {
            ForEach(soundNames, id: \.self){ soundName in
                Button {
                    //TODO: play sound
                    selection = soundName
                    AudioManager.shared.setPreferredSound(to: soundName)
                } label: {
                    HStack {
                        Text(soundName)
                        Spacer()
                        if selection == soundName {
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
