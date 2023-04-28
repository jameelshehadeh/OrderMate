//
//  SoundPlayer.swift
//  OrderMate
//
//  Created by Jameel Shehadeh on 28/04/2023.
//

import Foundation
import AVFoundation

class SoundPlayer {
    
    static let shared = SoundPlayer()
    
    private var audioPlayer: AVAudioPlayer?
    
    private init () {}
    
    func playDeliveredSound() {
        
        guard let url = Bundle.main.url(forResource: "BellSound", withExtension: "mp3") else { return }
          
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else {return}
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                self.audioPlayer?.prepareToPlay()
            } catch {
                print("Error loading sound file: \(error.localizedDescription)")
            }
            
            guard let player = audioPlayer else { return }
            
            if !player.isPlaying {
                player.play()
            }
        }
    }
    
}
