//
//  SirenCustomizationView.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 11/8/24.
//

import SwiftUI

struct SirenCustomizationView: View {
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
        Form {
            List {
                Section("Typeface"){
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
                                Text(typefaceName)
                                    .font(Font.custom(typefaceName, size: 30))
                                Spacer()
                                if selection == typefaceName {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                        .foregroundStyle(.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    SirenCustomizationView()
}
