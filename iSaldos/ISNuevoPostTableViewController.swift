//
//  ISNuevoPostTableViewController.swift
//  iSaldos
//
//  Created by formador on 2/6/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class ISNuevoPostTableViewController: UITableViewController {
    
    //MARK: - variables locales
    var fotoSeleccionada = false
    let fechaHumana = Date()
    
    
    //MARK: - IBOUtlets
    @IBOutlet weak var myImagenPerfil: UIImageView!
    @IBOutlet weak var myUsernamePerfil: UILabel!
    @IBOutlet weak var myNombreApellidoPerfil: UILabel!
    @IBOutlet weak var myfechaHumanaPerfil: UILabel!
    @IBOutlet weak var myDescripcionPoster: UITextView!
    @IBOutlet weak var myImagenPoster: UIImageView!
    
    //MARK: - IBactions
    @IBAction func hideVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        myDescripcionPoster.delegate = self
        
        //BLOQUE DE TOOLBAR
        let barraFlexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let colorBB = CONSTANTES.COLORES.BLANCO_TEXTO_NAV
        let colorTO = CONSTANTES.COLORES.GRIS_NAV_TAB
        
        let camara = UIBarButtonItem(image: UIImage(named:"camara"), style: .done, target: self, action: #selector(pickPhoto))
        let guardar = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(self.salvarDatos))
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolbar.barStyle = .blackOpaque
        toolbar.tintColor = colorBB
        toolbar.barTintColor = colorTO
        
        toolbar.items = [camara, barraFlexible, guardar]
        myDescripcionPoster.inputAccessoryView = toolbar
        
        let customDateFor = DateFormatter()
        customDateFor.dateStyle = .medium
        myfechaHumanaPerfil.text = "fecha" + " " + customDateFor.string(from: fechaHumana)
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.bajarTeclado))
        tableView.addGestureRecognizer(tapGR)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myDescripcionPoster.becomeFirstResponder()
        informacionUsuario()
    }
    
    
    //MARK: - Utils
    func bajarTeclado(){
        myDescripcionPoster.resignFirstResponder()
    }
    
    func salvarDatos(){
        
    }
    
    func informacionUsuario(){
        //1.consulta
        let queryUser = PFUser.query()
        queryUser?.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryUser?.findObjectsInBackground(block: { (objectUno, errorUno) in
            if errorUno == nil{
                if let objectUnoDes = objectUno?[0]{
                    self.myNombreApellidoPerfil.text = objectUnoDes["nombre"] as? String
                    self.myUsernamePerfil.text = "@ " + (PFUser.current()?.username)!
                    //2 consulta
                    let imagenPerfil = PFQuery(className: "ImageProfile")
                    imagenPerfil.whereKey("username", equalTo: (PFUser.current()?.username)!)
                    imagenPerfil.findObjectsInBackground(block: { (objectDos, errorDos) in
                        if errorDos == nil{
                            if let objectDosDes = objectDos?[0]{
                                let imageUserData = objectDosDes["imageProfile"] as! PFFile
                                imageUserData.getDataInBackground(block: { (imageData, errorData) in
                                    if errorData == nil{
                                        if let imageDataDes = imageData{
                                            self.myImagenPerfil.image = UIImage(data: imageDataDes)
                                        }
                                    }
                                })
                            }
                        }
                    })
                }
            }else{
                print("Error:\(errorUno?.localizedDescription)")
            }
        })
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1{
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }

   

}//TODO: - Fin de la clase

extension ISNuevoPostTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func pickPhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            muestraMenu()
        }else{
            muestraLibreriaFotos()
        }
    }
    
    func muestraMenu(){
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let tomaFotoCamarAction = UIAlertAction(title: "Toma foto", style: .default) { _ in
            self.muestraCamaraDisposito()
        }
        let seleccionaFotoAction = UIAlertAction(title: "Selecciona desde la Librería", style: .default) { _ in
            self.muestraLibreriaFotos()
        }
        alertVC.addAction(cancelAction)
        alertVC.addAction(tomaFotoCamarAction)
        alertVC.addAction(seleccionaFotoAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func muestraLibreriaFotos(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func muestraCamaraDisposito(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imageData = info[UIImagePickerControllerOriginalImage] as? UIImage{
            myImagenPoster.image = imageData
            if myImagenPoster != nil{
               fotoSeleccionada = true
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}//FIN DE LA EXTENSION

extension ISNuevoPostTableViewController : UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray{
            textView.text = nil
            textView.textColor = UIColor.black
            self.navigationController?.setToolbarHidden(true, animated: true)
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty{
            textView.text = "¿Qué está pasando?"
            textView.textColor = UIColor.lightGray
            self.navigationController?.setToolbarHidden(false, animated: true)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.setContentOffset(currentOffset, animated: false)
    }
    
}











