//
//  AudioPlayer.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 8/31/23.
//

import Foundation
import AVFAudio

var backgroundAudioPlayer: AVAudioPlayer?

/// plays a file looping indefinitely
///
/// - Parameters:
///     - sound: name of the audio file in your xcode project
///     - type: type of file for sound parameter (ex: "mp3")
/// - Returns:
///     - plays music if possible

func startBackgroundSound(sound: String = "siren", type: String = "mp3") {
    if let bundle = Bundle.main.path(forResource: sound, ofType: type) {
        let backgroundSound = NSURL(fileURLWithPath: bundle)
        do {
            backgroundAudioPlayer = try AVAudioPlayer(contentsOf:backgroundSound as URL)
            try AVAudioSession.sharedInstance().setCategory(.playback)
            guard let backgroundAudioPlayer = backgroundAudioPlayer else { return }
            backgroundAudioPlayer.numberOfLoops = -1
            backgroundAudioPlayer.prepareToPlay()
            backgroundAudioPlayer.play()
        } catch {
            print(error)
        }
    }
}

/// stops the file associated with this audio player
func stopBackgroundSound() {
    guard let backgroundAudioPlayer = backgroundAudioPlayer else { return }
    backgroundAudioPlayer.stop()
}
