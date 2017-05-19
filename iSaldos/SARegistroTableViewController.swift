//
//  SARegistroTableViewController.swift
//  iSaldos
//
//  Created by formador on 12/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class SARegistroTableViewController: UITableViewController {
    
    //MARK: - Variables locales
    var fotoSeleccionada = false
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagePerfil: UIImageView!
    @IBOutlet weak var myusernameTF: UITextField!
    @IBOutlet weak var myPasswordTF: UITextField!
    @IBOutlet weak var myNombreTF: UITextField!
    @IBOutlet weak var myApellidoTF: UITextField!
    @IBOutlet weak var myEmailTF: UITextField!
    @IBOutlet weak var myMovilTF: UITextField!
    @IBOutlet weak var myActInd: UIActivityIndicatorView!
    
    //MARK: - IBActions
    @IBAction func hideVC(_ sender: Any) {
        dismiss(animated: true,
                completion: nil)
    }
    
    @IBAction func registroEnParse(_ sender: Any) {
        
        var errorInicial = ""
        if verificatextField(myusernameTF.text) || verificatextField(myPasswordTF.text) || verificatextField(myNombreTF.text) || verificatextField(myApellidoTF.text) || verificatextField(myEmailTF.text) || myImagePerfil.image == nil{
            
            errorInicial = "Estimado usuario por favor rellene los campos"
            
        }else{
            
            let newUser = PFUser()
            newUser.username = myusernameTF.text
            newUser.password = myPasswordTF.text
            newUser.email = myEmailTF.text
            newUser["nombre"] = myNombreTF.text
            newUser["apellido"] = myApellidoTF.text
            newUser["movil"] = myMovilTF.text
            
            myActInd.isHidden = false
            myActInd.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            newUser.signUpInBackground(block: { (exitoso, errorRegistro) in
                
                self.myActInd.isHidden = true
                self.myActInd.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if errorRegistro != nil{
                    errorInicial = "Error al registrar"
                }else{
                    
                    self.signUpWithPhoto()
                    self.performSegue(withIdentifier: "jumpFromRegisterVC", sender: self)
                }
            })
        }
        
        if errorInicial != ""{
            present(muestraAlertVC("Atención",
                                   messageData: errorInicial),
                    animated: true,
                    completion: nil)
        }
        
    }
    
    //MARK: - Utils
    func verificatextField(_ string : String?) -> Bool{
        return string?.trimmingCharacters(in: .whitespaces) == ""
    }
    
    func signUpWithPhoto(){
        
        if fotoSeleccionada{
            
            let imageProfile = PFObject(className: "ImageProfile")
            let imageDataProfile = UIImageJPEGRepresentation(myImagePerfil.image!, 0.3)
            let imageProfileFile = PFFile(name: "userImageProfile.jpg", data: imageDataProfile!)
            
            imageProfile["imageProfile"] = imageProfileFile
            imageProfile["username"] = PFUser.current()?.username
            
            imageProfile.saveInBackground()
            
        }else{
            self.present(muestraAlertVC("Atención",
                                        messageData: "foto no seleccionada"),
                         animated: true,
                         completion: nil)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag

        //mostrar o ocultar el Activity indicator
        myActInd.isHidden = true
        
        //gesto sobre la imagen para que el usurio pueda interactuar
        myImagePerfil.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self,
                                           action: #selector(pickerPhoto))
        myImagePerfil.addGestureRecognizer(tapGR)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}//TODO: - Fin e la clase

extension SARegistroTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func pickerPhoto(){
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
            myImagePerfil.image = imageData
            fotoSeleccionada = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

