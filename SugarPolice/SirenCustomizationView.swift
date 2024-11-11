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
                    Text("currentSound")
                        .foregroundStyle(.gray)
                        .padding(.trailing)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SirenCustomizationView()
    }
}
