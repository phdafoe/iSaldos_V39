//
//  SALoginViewController.swift
//  iSaldos
//
//  Created by formador on 12/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse
import AVFoundation

class SALoginViewController: UIViewController {
    
    //MARK: - Variables locales
    var player : AVPlayer!
    
    
    //MARK: - IBOutlet
    @IBOutlet weak var myUsernameTF: UITextField!
    @IBOutlet weak var myPasswordTF: UITextField!
    @IBOutlet weak var myAccederBTN: UIButton!
    @IBOutlet weak var myresgistrarseBTn: UIButton!
    
    //MARK: - IBActions
    @IBAction func accederApp(_ sender: Any) {
        let sign = APISignIn(pUsername: myUsernameTF.text!,
                             pPassword: myPasswordTF.text!)
        do{
            try sign.signUser()
            self.performSegue(withIdentifier: "jumpFromLogin", sender: self)
        }catch let error{
            present(muestraAlertVC("Lo sentimos",
                                   messageData: "\(error.localizedDescription)"),
                    animated: true,
                    completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showVideoInVC()
        
        myAccederBTN.layer.cornerRadius = 5
        myresgistrarseBTn.layer.cornerRadius = 5
    }
    
    func showVideoInVC(){
        //video
        let path = Bundle.main.path(forResource: "Nike_iOS", ofType: "mp4")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        player.actionAtItemEnd = .none
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.insertSublayer(playerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItem),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem)
        player.seek(to: kCMTimeZero)
        player.play()
    }
    
    func playerItem(){
        player.seek(to: kCMTimeZero)
    }

    
    
    
    
    
    
    
    
    
    

}
