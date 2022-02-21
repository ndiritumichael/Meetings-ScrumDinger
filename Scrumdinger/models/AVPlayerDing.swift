//
//  AVPlayerDing.swift
//  Scrumdinger
//
//  Created by mac on 18/02/2022.
//

import Foundation

import AVFoundation

extension AVPlayer {
    static let sharedDingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "wav") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
}
