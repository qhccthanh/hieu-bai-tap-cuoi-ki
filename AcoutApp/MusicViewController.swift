//
//  MusicViewController.swift
//  AcoutApp
//
//  Created by James on 9/12/18.
//

import UIKit
import AVFoundation

class MusicViewController: ViewController {
    
    fileprivate let playButton: UIButton = {
       let button = UIButton()
       button.setTitle(" Play Music ", for: .normal)
       button.setTitleColor(.red, for: .normal)
       return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupContrains()
        
        self.chonNhac()
        
        

    }
    
    fileprivate func setupView(){
        self.playButton.addSubview(playButton)
        
        self.playButton.addTarget(self, action: #selector(self.didTapPlayButon(_:)), for: .touchUpInside)
        
        
    }
    
    fileprivate func setupContrains() {
        self.playButton.snp.makeConstraints {(make) in
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
     }
    }
    
    @objc fileprivate func didTapPlayButon (_ sender: Any!){
        
    }
    
    fileprivate func chonNhac() {
        let url:URL = URL(fileURLWithPath: "/Users/james/Documents/Music/Dap Mo Cuoc Tinh - Quang Lap (NhacPro.net).mp")
    }
}
