//
//  VideoViewController.swift
//  ThucHanhImagePicker
//
//  Created by Hoàng Đức on 18/11/2022.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController  {
    let containerView:UIView = {
       let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let playButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        containerView.frame = view.bounds
        containerView.addSubview(playButton)
        playButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        playButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
        playButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        
        
    }
    
    @objc func didTapPlayButton() {
                let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "hoang", ofType: "mp4")!))
        
                let vc = AVPlayerViewController()
                vc.player = player
        present(vc, animated: true)
    }
    
    


    
}
