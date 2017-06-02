//
//  SAActionSheetPersonalizadoViewController.swift
//  iSaldos
//
//  Created by formador on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SAActionSheetPersonalizadoViewController: UIViewController {
    
    //MARK: - Variables locales
    var arrayRedesSociales = ["Facebook", "Twitter"]
    var arrayImagenesRS = ["like", "nation"]
    
    //MARK: - IBOutlets
    @IBOutlet weak var myCustomView: UIView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var myCancelarBTN: UIButton!
    
    @IBAction func hideVC(_ sender: Any) {
        dismiss(animated: true,
                completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Aqui manejamos la transparencia del VC
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        
        myCustomView.layer.cornerRadius = 5
        myCancelarBTN.layer.cornerRadius = 5
        
        
        myCustomView.layer.masksToBounds = false
        myCustomView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        myCustomView.layer.shadowColor = CONSTANTES.COLORES.GRIS_NAV_TAB.cgColor
        myCustomView.layer.shadowRadius = 20.0
        myCustomView.layer.shadowOpacity = 1.0
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    

    

}//FIN DE LA CLASE


extension SAActionSheetPersonalizadoViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRedesSociales.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let modelText = arrayRedesSociales[indexPath.row]
        let modelImage = arrayImagenesRS[indexPath.row]
        
        customCell.textLabel?.text = modelText
        customCell.detailTextLabel?.text = "\(Date())"
        customCell.imageView?.image = UIImage(named: modelImage)
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    
}









