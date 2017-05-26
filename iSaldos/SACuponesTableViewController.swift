//
//  SACuponesTableViewController.swift
//  iSaldos
//
//  Created by formador on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Kingfisher
import PKHUD
import PromiseKit

class SACuponesTableViewController: UITableViewController {
    
    //MARK: - Variables
    var arrayCupones = [SAPromocionesModel]()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //LLAMADA
        llamadaCupones()
        
        //TODO: - Mostramos el menu lateral
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //REGISTRO DE LA CELDA
        tableView.register(UINib(nibName: "ISOfertaCustomCell", bundle: nil), forCellReuseIdentifier: "ISOfertaCustomCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayCupones.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let customOfertascell = tableView.dequeueReusableCell(withIdentifier: "ISOfertaCustomCell", for: indexPath) as! ISOfertaCustomCell
        
        let model = arrayCupones[indexPath.row]
        
        customOfertascell.myNombreOferta.text = model.nombre
        customOfertascell.myFechaOferta.text = model.fechaFin
        customOfertascell.myInformacionOferta.text = model.masInformacion
        customOfertascell.myImporteOferta.text = model.importe
        
        customOfertascell.myImagenOferta.kf.setImage(with: ImageResource(downloadURL: URL(string: getImagePath(CONSTANTES.LLAMADAS.CUPON, id: model.id!, name: model.imagen!))!),
                                                     placeholder: #imageLiteral(resourceName: "placeholder"),
                                                     options: nil,
                                                     progressBlock: nil,
                                                     completionHandler: nil)
        return customOfertascell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let customOfertascell = tableView.dequeueReusableCell(withIdentifier: "ISOfertaCustomCell", for: indexPath) as! ISOfertaCustomCell
        //indexImagenData = customOfertascell.myImagenOferta.image
        performSegue(withIdentifier: "showCuponSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCuponSegue"{
            let detalleVC = segue.destination as! SACuponDetalleTableViewController
            let selectInd = tableView.indexPathForSelectedRow?.row
            let objInd = arrayCupones[selectInd!]
            detalleVC.cupon = objInd
            //detalleVC.detalleImagen = indexImagenData
            
            do{
                let url = URL(string: CONSTANTES.LLAMADAS.BASE_URL_PHOTO + (objInd.id!) + "/" + (objInd.imagen!))!
                let customData = try Data(contentsOf: url)
                let imageData = UIImage(data: customData)
                detalleVC.detalleImagen = imageData
            }catch{
                
            }
            
        }
    }
    
    
    
    //LLAMADA
    func llamadaCupones(){
        let datosOferta = SAParserPromociones()
        let idLocalidad = "11"
        let tipoOferta = CONSTANTES.LLAMADAS.CUPON
        let tipoParametro = CONSTANTES.LLAMADAS.PROMOCIONES_SERVICE
        
        HUD.show(.progress)
        firstly{
            return when(resolved: datosOferta.getDatosPromociones(idLocalidad, idTipo: tipoOferta, idParametro: tipoParametro))
            }.then{_ in
                self.arrayCupones = datosOferta.getParserPromociones()
            }.then{_ in
                self.tableView.reloadData()
            }.then{_ in
                HUD.hide(afterDelay: 0)
            }.catch{ error  in
                self.present(muestraAlertVC("AQUI", messageData: "PROBLEMAS DE DESCARGA \(error.localizedDescription)"), animated: true, completion: nil)
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
