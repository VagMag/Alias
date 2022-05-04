//
//  GameViewController.swift
//  Alias
//
//  Created by Maxim Vagin on 02.05.2022.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    var player: AVAudioPlayer!

    @IBAction func TrueButtonPressed(_ sender: UIButton) {
        playSound(soundName: "TRUE")
    }
    @IBAction func SkipButtonPressed(_ sender: UIButton) {
        playSound(soundName: "FALSE")
    }
    
    func playSound(soundName:String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
}
    

    
}
