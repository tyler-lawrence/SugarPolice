//
//  AudioPlayer.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 8/31/23.
//

import Foundation
import AVFAudio
import SwiftUI


@Observable
class AudioManager {

    static let shared = AudioManager()
    
    let defaults = UserDefaults(suiteName: AppStorageKey.suiteName)
    var preferredSound: String = "Siren"
    
    var audioPlayer: AVAudioPlayer?
    
    init() {
        fetchPreferredSound()
    }

    /// plays a file looping indefinitely
    /// - Returns:
    ///     - plays music if possible
    func startBackgroundSound() {
        let resource = "/Sounds/" + preferredSound
        if let bundle = Bundle.main.path(forResource: resource, ofType: "mp3") {
            let backgroundSound = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundSound as URL)
                try AVAudioSession.sharedInstance().setCategory(.playback)
                guard let backgroundAudioPlayer = audioPlayer else { return }
                backgroundAudioPlayer.numberOfLoops = -1
                backgroundAudioPlayer.prepareToPlay()
                backgroundAudioPlayer.play()
            } catch {
                print(error)
            }
        }
    }

    func play(_ sound: SirenSound) {
        guard let resourcePath = sound.path else { return }
        let soundURL: NSURL = NSURL(fileURLWithPath: resourcePath)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL as URL)
            try AVAudioSession.sharedInstance().setCategory(.playback)
            guard let backgroundAudioPlayer = audioPlayer else { return }
            backgroundAudioPlayer.prepareToPlay()
            backgroundAudioPlayer.play()
        } catch {
            print(error)
        }
    }
    
    /// stops the file associated with this audio player
    func stopBackgroundSound() {
        guard let backgroundAudioPlayer = audioPlayer else { return }
        backgroundAudioPlayer.stop()
    }
    
    func setPreferredSound(to resourceName: String) {
        guard let defaults else { return }
        defaults.setValue(resourceName, forKey: AppStorageKey.preferredSound)
        fetchPreferredSound()
    }
    
    func fetchPreferredSound() {
        guard let defaults else { return }
        preferredSound = defaults.string(forKey: "preferredSound") ?? "Siren"
    }
}

