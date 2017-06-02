//
//  SACuponDetalleTableViewController.swift
//  iSaldos
//
//  Created by formador on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SACuponDetalleTableViewController: UITableViewController {
    
    //MARK: - Variables locales
    var cupon : SAPromocionesModel?
    var detalleImagen : UIImage?
    
    //MARK: - Variables CB
    var qrData : String?
    var imageGroupTag = 3
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagenOferta: UIImageView!
    @IBOutlet weak var myNombreOferta: UILabel!
    @IBOutlet weak var myfechaFin: UILabel!
    @IBOutlet weak var myMasInformacion: UILabel!
    @IBOutlet weak var myNombreAsociado: UILabel!
    @IBOutlet weak var myDescripcionAsociado: UILabel!
    @IBOutlet weak var myDireccionAsociado: UILabel!
    @IBOutlet weak var myTelefonoMovilAsociado: UILabel!
    @IBOutlet weak var myEmailAsociado: UILabel!
    @IBOutlet weak var myTelefonoFijoAsociado: UILabel!
    @IBOutlet weak var myWebAsociado: UILabel!
    @IBOutlet weak var myIdActividadAsociado: UILabel!
    
    
    @IBAction func muestraCDACTION(_ sender: Any) {
        
        let customBackgroud = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 2))
        customBackgroud.backgroundColor = CONSTANTES.COLORES.GRIS_NAV_TAB
        customBackgroud.alpha = 0.0
        customBackgroud.tag = imageGroupTag
        
        let cusBackAnim = UIViewPropertyAnimator(duration: 0.3,
                                                 curve: .easeInOut) { 
                                                    customBackgroud.alpha = 0.5
                                                    self.view.addSubview(customBackgroud)
        }
        cusBackAnim.startAnimation()
        cusBackAnim.addCompletion { _ in
            self.muestraImagenCD()
        }
        
        let tapGR = UITapGestureRecognizer(target: self,
                                           action: #selector(quitarCB))
        view.addGestureRecognizer(tapGR)
        
        
    }
    
    func quitarCB(){
        for c_subvista in self.view.subviews{
            if c_subvista.tag == self.imageGroupTag{
                c_subvista.removeFromSuperview()
            }
        }
    }
    
    
    func muestraImagenCD(){
        if myIdActividadAsociado.text == qrData{
            let anchoImagen = self.view.frame.width / 1.5
            let altoImagen = self.view.frame.height / 3
            
            let imageView = UIImageView(frame: CGRect(x: (self.view.frame.width / 2 - anchoImagen / 2), y: (self.view.frame.height / 2 - altoImagen / 2), width: anchoImagen, height: altoImagen))
            
            imageView.contentMode = .scaleAspectFit
            imageView.tag = imageGroupTag
            imageView.image = fromString(qrData!)
            self.view.addSubview(imageView)
        }else{
            //Aqui Error
        }
    }
    
    func fromString(_ string : String) -> UIImage{
        let data = string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter!.setValue(data, forKey: "inputMessage")
        return UIImage(ciImage: filter!.outputImage!)
    }
    
    
    @IBAction func muestraActionSheetPersonalizadoACTION(_ sender: Any) {
        let sbData = UIStoryboard(name: "ActionSheetStoryboard", bundle: nil)
        let actionSheetVC = sbData.instantiateInitialViewController()
        actionSheetVC?.modalPresentationStyle = .overCurrentContext
        show(actionSheetVC as! UINavigationController, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        myImagenOferta.image = detalleImagen
        myNombreOferta.text = cupon?.nombre
        myfechaFin.text = cupon?.fechaFin
        myMasInformacion.text = cupon?.masInformacion
        myNombreAsociado.text = cupon?.asociado?.nombre
        myDescripcionAsociado.text = cupon?.asociado?.descripcion
        myDireccionAsociado.text = cupon?.asociado?.direccion
        myTelefonoMovilAsociado.text = cupon?.asociado?.telefonoMovil
        myTelefonoFijoAsociado.text = cupon?.asociado?.telefonoFijo
        myEmailAsociado.text = cupon?.asociado?.mail
        myWebAsociado.text = cupon?.asociado?.web
        myIdActividadAsociado.text = cupon?.asociado?.idActividad
        
        qrData = cupon?.asociado?.idActividad
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 1{
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    

}
