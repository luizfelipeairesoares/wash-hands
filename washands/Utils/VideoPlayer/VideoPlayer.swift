//
//  VideoPlayer.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 27/05/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation
import AVKit

class CustomPlayer: NSObject {
    
    private var player = AVPlayer()
    
    public struct Constants {
        public static let TimeUpdateInterval: TimeInterval = 0.1
    }
    
    // MARK: - ProvidesView Protocol
    
    private class PlayerView: UIView {
        var playerLayer: AVPlayerLayer {
            return self.layer as! AVPlayerLayer
        }
        
        override class var layerClass: AnyClass {
            return AVPlayerLayer.self
        }
        
        func configureForPlayer(player: AVPlayer) {
            (self.layer as! AVPlayerLayer).player = player
        }
    }
    
    public let view: UIView = PlayerView(frame: .zero)
    
    private var playerView: PlayerView {
        return self.view as! PlayerView
    }
    
    private var playerLayer: AVPlayerLayer {
        return self.playerView.playerLayer
    }
    
    // MARK: - Init
    
    override init() {
        super.init()
        
        addPlayerObservers()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.backgroundColor = .clear
        player.actionAtItemEnd = .none
        playerView.configureForPlayer(player: player)
        
    }
    
    // MARK: - Deinit
    
    deinit {
        if player.currentItem != nil {
            removePlayerObservers()
        }
    }
    
    // MARK: - Public API
    
    func set(_ asset: AVAsset) {
        let playerItem = AVPlayerItem(asset: asset)
        
        player.replaceCurrentItem(with: playerItem)
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    // MARK: - Private API
    
    private func addPlayerObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidPlayToEnd(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }

    private func removePlayerObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Observation
    
    @objc private func playerDidPlayToEnd(_ notification: Notification) {
        if let playerItem: AVPlayerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
        }
    }
    
}
