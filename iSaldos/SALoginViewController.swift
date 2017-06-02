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
        
        myUsernameTF.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        myPasswordTF.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
    }
     ///Actualmente el video sigue funcionado por debajo. Para evitarlo,
    ///Hay que controlar cuando la ventana desaparece y realizar las siguientes acciones:
    ///Eliminar la vista actual como observador del vídeo (si no se hace esto se mantiene la referencia a la vista y el recolector de basura no borra el SALoginViewController, por lo que el vídeo sigue corriendo)
    ///Una vez después de que nos des-suscribamos a los cambios sobre el video, producimos un último cambio.  Ir al final del vídeo, pero con el matiz de la tolerancia, para que no exista un delay.
    ///NOTA: No he hecho la prueba en el viewWillDisappear, pero bajo la acción de un botón, sí que funciona. Por lo que aquí también debería.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Borrar las notificaciones
        NotificationCenter.default.removeObserver(self)
        //Parar el video, se añade la tolerancia para que no tarde en pararse en segundo plano
        player.seek(to: (player.currentItem?.duration)!, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimePositiveInfinity)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
