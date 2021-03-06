//
//  SAAsociadoModel.swift
//  iSaldos
//
//  Created by formador on 19/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SAAsociadoModel: NSObject {
    
    var id : String?
    var nombre : String?
    var descripcion : String?
    var condicionesEspeciales : String?
    var direccion : String?
    var idActividad : String?
    var idLocalidad : String?
    var imagen : String?
    var telefonoFijo : String?
    var telefonoMovil : String?
    var mail : String?
    var web :  String?
    
    init(pId : String, pNombre : String, pDescripcion : String, pCondicionesEspeciales : String, pDireccion : String, pidActividad : String, pIdLocalidad : String, pImagen : String, pTelefonoFijo : String, pTelefonoMovil : String, pMail : String, pWeb : String) {
        
        self.id = pId
        self.nombre = pNombre
        self.descripcion = pDescripcion
        self.condicionesEspeciales = pCondicionesEspeciales
        self.direccion = pDireccion
        self.idActividad = pidActividad
        self.idLocalidad = pIdLocalidad
        self.imagen = pImagen
        self.telefonoFijo = pTelefonoFijo
        self.telefonoMovil = pTelefonoMovil
        self.mail = pMail
        self.web = pWeb
        super.init()
        
    }
    
    

}
