//
//  SirenCustomizationView.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 11/8/24.
//

import SwiftUI

struct SirenCustomizationView: View {
    @AppStorage(AppStorageKey.preferredTypeface) var preferredTypeface: String = "Baskerville"
    
    var body: some View {
        Form {
            Section {
                NavigationLink {
                    TypefaceSelectionView()
                } label: {
                    HStack {
                        Image(systemName: "a.square")
                        Text("Font")
                        Spacer()
                        Text(preferredTypeface)
                            .foregroundStyle(.gray)
                            .padding(.trailing)
                    }
                }
                NavigationLink {
                    SoundSelectionView()
                } label: {
                    HStack {
                        Image(systemName: "speaker.square")
                        Text("Sound")
                        Spacer()
                        Text(AudioManager.shared.preferredSound.capitalized)
                            .foregroundStyle(.gray)
                            .padding(.trailing)
                    }
                }
            }
            Link("Get the Shortcut", destination: URL(string: "https://www.icloud.com/shortcuts/87cf14058ae34d84a1c689ab50785764")!)
        }
    }
}

#Preview {
    NavigationStack {
        SirenCustomizationView()
    }
}
