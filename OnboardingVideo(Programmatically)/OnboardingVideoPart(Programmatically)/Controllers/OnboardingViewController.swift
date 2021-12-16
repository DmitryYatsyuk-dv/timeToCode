//
//  OnboardingViewController.swift
//  OnboardingVideoPart(Programmatically)
//
//  Created by Lucky on 16.11.2021.
//

import UIKit
import AVFoundation
import Combine

class OnboardingViewController: UIViewController {
    
    //MARK: - Properties
    
    private let customView = CustomView()
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private let notification = NotificationCenter.default
    private var appEventSubscriber = [AnyCancellable]()
    
    //MARK: - Lifecycle
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completionStartButton()
        customView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        observeAppEvents()
        setupPlayerIfNeeded()
        restartVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        removeAppEventsSubscriber()
        removePlayer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = view.layer.bounds
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    //MARK: - Actions
    
    
    
    //MARK: - Helpers
    private func completionStartButton() {
        customView.handlerStartButton = {
            print("DEBUG: Callback from customView is delivered")
            let controller = MainViewController()
            controller.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    private func buildPlayer() -> AVPlayer? {
        guard let filePath = Bundle.main.path(forResource: "teamVideo",
                                              ofType: "mp4") else { return nil }
        let url = URL(fileURLWithPath: filePath)
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        player.isMuted = true
        return player
    }
    
    private func buildPlayerLayer() -> AVPlayerLayer? {
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        return layer
    }
    
    private func playVideo() {
        player?.play()
    }
    
    private func restartVideo() {
        player?.seek(to: .zero)
        playVideo()
    }
    
    private func pauseVideo() {
        player?.pause()
    }
    
    private func setupPlayerIfNeeded() {
        player = buildPlayer()
        playerLayer = buildPlayerLayer()
        
        if let layer = self.playerLayer,
           view.layer.sublayers?.contains(layer) == false {
            view.layer.insertSublayer(layer, at: 0)
        }
    }
    
    private func removePlayer() {
        player?.pause()
        player = nil
        
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
    }
    
    private func observeAppEvents() {
        notification.publisher(for: .AVPlayerItemDidPlayToEndTime).sink { [weak self] _ in
            self?.restartVideo()
        }.store(in: &appEventSubscriber)
        
        notification.publisher(for: UIApplication.willResignActiveNotification).sink { [weak self] _ in
            self?.pauseVideo()
        }.store(in: &appEventSubscriber)
        
        notification.publisher(for: UIApplication.didBecomeActiveNotification).sink { [weak self] _ in
            self?.playVideo()
        }.store(in: &appEventSubscriber)
    }
    
    private func removeAppEventsSubscriber() {
        appEventSubscriber.forEach { subscriber in
            subscriber.cancel()
        }
    }
}

extension OnboardingViewController: CustomViewDelegate {
    func testDelegate() {
        print("DEBUG: Delegation rights transferred")
    }
}

