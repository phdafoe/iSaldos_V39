//
//  SAUserPostModel.swift
//  iSaldos
//
//  Created by formador on 2/6/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class SAUserPostModel: NSObject {
    
    var nombre : String?
    var apellido : String?
    var username : String?
    var imageProfile : PFFile?
    var imagePoster : PFFile?
    var fechaCreacion : Date?
    var descripcionImagen : String?
    
    
    init(pNombre : String, pApellido : String, pUsername : String, pImageProfile : PFFile, pImagePoster : PFFile, pFechaCreacion : Date, pDescripcionImagen : String) {
        self.nombre = pNombre
        self.apellido = pApellido
        self.username = pUsername
        self.imageProfile = pImageProfile
        self.imagePoster = pImagePoster
        self.fechaCreacion = pFechaCreacion
        self.descripcionImagen = pDescripcionImagen
    }
    
    
    

}
