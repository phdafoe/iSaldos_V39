//
//  SATerminosYCondicionesViewController.swift
//  iSaldos
//
//  Created by formador on 19/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SATerminosYCondicionesViewController: UIViewController {
    
    //MARK: - IBactions
    @IBAction func hideVC(_ sender: Any) {
        dismiss(animated: true,
                completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
