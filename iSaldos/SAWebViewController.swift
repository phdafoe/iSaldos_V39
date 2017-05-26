//
//  SAWebViewController.swift
//  iSaldos
//
//  Created by formador on 26/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class SAWebViewController: UIViewController {
    
    //MARK: - Variables locales
    var urlWeb : String?
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var myActInd: UIActivityIndicatorView!
    
    
    //MARK: - IBACTIONS
    @IBAction func hideVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.delegate = self
        myActInd.isHidden = true
        let customUrl = URL(string: "http://" + urlWeb!)
        let cusUrlRequest = URLRequest(url: customUrl!)
        myWebView.loadRequest(cusUrlRequest)
    }


}

extension SAWebViewController : UIWebViewDelegate{
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        myActInd.isHidden = false
        myActInd.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        myActInd.isHidden = true
        myActInd.stopAnimating()
    }
    
}












