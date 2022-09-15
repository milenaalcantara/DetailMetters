//
//  BeachView.swift
//  DetailsMetter
//
//  Created by Milena Lima de Alcântara on 08/09/22.
//

import UIKit
import AVFoundation

class BeachView: UIView {
    
    var player: AVAudioPlayer!
    var i = 0
    
    lazy var backgroundImageView: UIImageView = {
        let backgroundImage = UIImage(named: "beachBackground")
        let backgroundView = UIImageView(image: backgroundImage)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
    
        return backgroundView
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Botão", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.addTarget(self, action: #selector(buttonActions), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 8
       
      return button
        
    }()
    
    @objc func buttonActions() {
        playSound()
        playHaptics()
    }

    func playSound(){
        
        
       guard let url = Bundle.main.url(forResource: "success", withExtension: "mp3") else {
           return
       }
        
    
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)

        }
    }
    
    func playHaptics() {
        
        HapticsManager.shared.vibrate(for: .success)
        
    }
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       
        self.addSubview(backgroundImageView)
        self.addSubview(createButton)
        
        configureContraints()
    }

    required init?(coder: NSCoder) {
       fatalError()
    }
    
    func configureContraints() {
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.createButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.createButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
