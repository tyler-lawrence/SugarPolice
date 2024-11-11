//
//  TypefaceSelectionView.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 11/11/24.
//

import SwiftUI

struct TypefaceSelectionView: View {
    
    @AppStorage(AppStorageKey.preferredTypeface) var preferredTypeface: String = "Baskerville"
    @State var selection: String?
    
    var typefaceNames: [String] {
        guard let bundlePath = Bundle.main.resourcePath else { return [] }
        do {
            let typefaceDirectory = bundlePath + "/Typefaces/"
            let contents: [String] = try FileManager.default.contentsOfDirectory(atPath: typefaceDirectory)
            
            return contents.map{($0 as NSString).deletingPathExtension}
        } catch {
            print(error)
        }
        return []
    }
    
    var body: some View {
        List {
            ForEach(typefaceNames, id: \.self){ typefaceName in
                Button {
                    if selection == typefaceName {
                        selection = nil
                    } else {
                        selection = typefaceName
                        preferredTypeface = typefaceName
                    }
                } label: {
                    HStack {
                        // TODO: update fixed size
                        Text(typefaceName)
                            .font(Font.custom(typefaceName, size: 20))
                        Spacer()
                        if selection == typefaceName {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .foregroundStyle(.primary)
            }
        }
        .onAppear {
            selection = preferredTypeface
        }
    }
}

#Preview {
    TypefaceSelectionView()
}
