//
//  SAMenuLateralTableViewController.swift
//  iSaldos
//
//  Created by formador on 19/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse
import MessageUI

class SAMenuLateralTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenPerfil: UIImageView!
    @IBOutlet weak var myNombrePerfil: UILabel!
    @IBOutlet weak var myApellidoPerfil: UILabel!
    @IBOutlet weak var myEmailPerfil: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //LLamada a parse
        dameInformacionParse()
        
        myImagenPerfil.layer.cornerRadius = myImagenPerfil.frame.width / 2
        myImagenPerfil.layer.borderColor = CONSTANTES.COLORES.GRIS_NAV_TAB.cgColor
        myImagenPerfil.layer.borderWidth = 1
        myImagenPerfil.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Utils
    func dameInformacionParse(){
        
        //1. primera consulta
        let queryData = PFUser.query()
        queryData?.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryData?.findObjectsInBackground(block: { (objBusquedaUno, errorUno) in
            if errorUno == nil{
                if let objBusquedaUnoDes = objBusquedaUno?[0]{
                    self.myNombrePerfil.text = objBusquedaUnoDes["nombre"] as? String
                    self.myApellidoPerfil.text = objBusquedaUnoDes["apellido"] as? String
                    self.myEmailPerfil.text = objBusquedaUnoDes["email"] as? String
                    
                    //2.segunda consulta
                    let queryFoto = PFQuery(className: "ImageProfile")
                    queryFoto.whereKey("username", equalTo: (PFUser.current()?.username)!)
                    queryFoto.findObjectsInBackground(block: { (objBusquedaDos, errorDos) in
                        if errorDos == nil{
                            if let objBusquedaDosDes = objBusquedaDos?[0]{
                                let imageDataFile = objBusquedaDosDes["imageProfile"] as! PFFile
                                imageDataFile.getDataInBackground(block: { (imageDataTres, errorTres) in
                                    if errorTres == nil{
                                        if let imageDataTresDes = imageDataTres{
                                            let imageDataFinal = UIImage(data: imageDataTresDes)
                                            self.myImagenPerfil.image = imageDataFinal
                                        }
                                    }
                                })
                            }
                        }
                    })
                }
            }
        })
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
}
