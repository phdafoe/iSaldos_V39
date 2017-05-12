//
//  SASplashViewController.swift
//  iSaldos
//
//  Created by formador on 12/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class SASplashViewController: UIViewController {
    
    //MARK: - Variables locales
    var viewAnitor : UIViewPropertyAnimator!
    var timerDesbloqueo = Timer()
    
    //MARK: - IBoutlets
    @IBOutlet weak var myImageSplash: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        viewAnitor = UIViewPropertyAnimator(duration: 1.0,
                                            curve: .easeInOut,
                                            animations: { 
                                                self.myImageSplash.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                                                self.timerDesbloqueo = Timer.scheduledTimer(timeInterval: 1.5,
                                                                                            target: self,
                                                                                            selector: #selector(self.manejadorAutomatico),
                                                                                            userInfo: nil,
                                                                                            repeats: false)
        })
        viewAnitor.startAnimation()
        
        // Do any additional setup after loading the view.
    }

    //MARK: - Utils
    func manejadorAutomatico(){
        let logoAnimacion = UIViewPropertyAnimator(duration: 0.5,
                                                   curve: .easeInOut) { 
                                                    self.myImageSplash.transform = CGAffineTransform(scaleX: 25, y: 25)
        }
        logoAnimacion.startAnimation()
        logoAnimacion.addCompletion { _ in
            self.beginApp()
        }
    }
    
    func beginApp(){
        if (customPrefs.string(forKey: CONSTANTES.CUSTOM_USER_DEFAULTS.VISTA_GALERIA_INICIAL)) != nil{
            if PFUser.current() == nil {
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "SALoginViewController") as! SALoginViewController
                loginVC.modalTransitionStyle = .crossDissolve
                present(loginVC, animated: true, completion: nil)
            }else{
                let revealVC = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                revealVC.modalTransitionStyle = .crossDissolve
                present(revealVC, animated: true, completion: nil)
            }
        }else{
            customPrefs.setValue("OK", forKey: CONSTANTES.CUSTOM_USER_DEFAULTS.VISTA_GALERIA_INICIAL)
            let galeriVC = self.storyboard?.instantiateViewController(withIdentifier: "SAGaleriaImagenesViewController") as! SAGaleriaImagenesViewController
            galeriVC.modalTransitionStyle = .crossDissolve
            present(galeriVC, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
