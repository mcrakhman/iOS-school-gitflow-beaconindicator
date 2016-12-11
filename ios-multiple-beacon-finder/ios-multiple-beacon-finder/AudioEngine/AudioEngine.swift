//
//  AudioEngine.swift
//  ios-multiple-beacon-finder
//
//  Created by m.rakhmanov on 11.12.16.
//  Copyright © 2016 m.rakhmanov. All rights reserved.
//

import Foundation
import CoreAudio
import AVFoundation

class AudioEngine {
    
    let beepSoundUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "beep", ofType: "wav")!)
    
    var audioPlayer = AVAudioPlayer()
    
    init() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: beepSoundUrl)
            audioPlayer.prepareToPlay()
        } catch {
            print("Ошибка проигрывания файла")
        }
    }
    
    func playBeepSound () {
        DispatchQueue.global().async {
            self.audioPlayer.currentTime = 0
            self.audioPlayer.play()
        }
    }
}
