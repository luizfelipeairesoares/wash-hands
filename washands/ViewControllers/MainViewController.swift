//
//  MainViewController.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 24/05/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit
import AVKit

class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var mainView: MainView = {
        let view = MainView()
        view.delegate = self
        return view
    }()
    
    private var gifs: [GiphyAPIEntity] = []
    
    private var currentIndex: Int = 0
    
    // MARK: - ViewController functions
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestGifs()
    }
    
    // MARK: - Private functions
    
    private func requestGifs() {
        GifService().requestGifs { [weak self] (result) in
            switch result {
            case .success(let gifs):
                self?.gifs.append(contentsOf: gifs)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func selectGifFromList() {
        if !gifs.isEmpty {
            let gif = gifs[currentIndex]
            if let image = gif.images["original_mp4"], let mp4 = image.mp4, let url = URL(string: mp4) {
                let urlAsset = AVURLAsset(url: url)
                mainView.setupAssetInPlayer(asset: urlAsset, username: gif.username)
            }
            currentIndex += 1
            if currentIndex >= gifs.count {
                currentIndex = 0
            }
        }
    }

}

extension MainViewController: MainViewDelegate {
    
    func didTapStart() {
        selectGifFromList()
    }
    
}

