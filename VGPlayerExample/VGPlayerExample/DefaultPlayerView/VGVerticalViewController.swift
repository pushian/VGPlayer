//
//  VGVerticalViewController.swift
//  VGPlayer-Example
//
//  Created by Vein on 2017/6/9.
//  Copyright © 2017年 Vein. All rights reserved.
//

import UIKit
import VGPlayer
import SnapKit

class VGVerticalViewController: UIViewController {
    var player : VGPlayer?
    override func viewDidLoad() {
        super.viewDidLoad()
//        var path = Bundle.main.bundlePath
//        path.append("/openpage.mp4")
        
        
        guard let path = Bundle.main.path(forResource: "openpage", ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        
        let url = URL.init(fileURLWithPath: path)//URL(string: path)
//        let url = URL.ini
//        let url = URL(string:"https://cq-assets.fooyotravel.com/uploads/site_videos/video/1/hongyadong.mp4")!
        debugPrint(url)
        let data = NSData.init(contentsOfFile: path)
//        debugPrint("debug \(data)")
        player = VGPlayer(URL: url)
        player?.player?.isMuted = true
//        player?.displayView.bottomView.isHidden = true
        player?.displayView.displayControlView(false)
        player?.displayView.disableGesture = true
        
//        player?.displayView.singl
//        player.voice
//        player?.gravityMode = .resize

//        if url != nil {
//            player = VGPlayer(URL: url!)
//        }
        player?.delegate = self
        view.addSubview((player?.displayView)!)
        player?.backgroundMode = .proceed
        player?.play()
        player?.displayView.delegate = self
        player?.displayView.titleLabel.text = "HLS Live"
        player?.displayView.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.edges.equalTo(strongSelf.view)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.default, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.shared.setStatusBarHidden(false, with: .none)
    }
}

extension VGVerticalViewController: VGPlayerDelegate {
    func vgPlayer(_ player: VGPlayer, playerFailed error: VGPlayerError) {
        print(error)
    }
    func vgPlayer(_ player: VGPlayer, stateDidChange state: VGPlayerState) {
        print("player State ",state)
    }
    func vgPlayer(_ player: VGPlayer, bufferStateDidChange state: VGPlayerBufferstate) {
        print("buffer State", state)
    }
    
}

extension VGVerticalViewController: VGPlayerViewDelegate {
    func vgPlayerView(_ playerView: VGPlayerView, willFullscreen fullscreen: Bool) {
        
    }
    func vgPlayerView(didTappedClose playerView: VGPlayerView) {
        if playerView.isFullScreen {
            playerView.exitFullscreen()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    func vgPlayerView(didDisplayControl playerView: VGPlayerView) {
        UIApplication.shared.setStatusBarHidden(!playerView.isDisplayControl, with: .fade)
    }
}
