//
//  ContentView.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 8/31/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var colorToggle = false
    @AppStorage("message", store: UserDefaults(suiteName: "group.com.academy.SugarPolice")) private var message: String = "Infraction"
    @State var showingSheet = false
    
    var backgroundGradient: LinearGradient {
        var g: LinearGradient
        if colorToggle {
            g = LinearGradient(colors: [.blue, .white], startPoint: .leading, endPoint: .trailing)
        } else {
            g = LinearGradient(colors: [.white, .red], startPoint: .leading, endPoint: .trailing)
        }
        return g
    }
  
    var body: some View {
        ZStack {
            backgroundGradient
                .edgesIgnoringSafeArea(.all)
            Text(message)
                .foregroundColor(.white)
                .font(.system(size: 100))
            }
        .onTapGesture {
            showingSheet.toggle()
        }
        .onAppear{
            var timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) {timer in
                colorToggle.toggle()
            }
            startBackgroundMusic(sound: "police-6007", type: "mp3")
        }
        .sheet(isPresented: $showingSheet){
            SetupView()
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
