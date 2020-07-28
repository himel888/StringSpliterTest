//
//  ViewController.swift
//  StringSpliterTest
//
//  Created by Kazi Abdullah Al Mamun on 27/7/20.
//  Copyright © 2020 Kazi Abdullah Al Mamun. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak private var dataPresenterTxtView: UITextView!
    @IBOutlet weak private var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataPresenterTxtView.isEditable = false
    }

    private func getData(completion: @escaping(String?) -> Void) {
        
        guard let url = URL(string: "https://bongobd.com/disclaimer") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let lData = data, lData.count > 0 else {
                completion(nil)
                return
            }
            
            completion(String(data: lData, encoding: .utf8))
        }.resume()
    }
    
    @IBAction
    private func btnPresentDataAction(_ sender: UIButton) {
        
        loader.startAnimating()
        getData { (str) in
            guard let lStr = str, !lStr.isEmpty else {
                self.dataPresenterTxtView.text = "No data fround"
                return
            }
            
            let vm = MainVCViewModel(lStr)
            vm.getPresentableText() { (presentableText) in
                DispatchQueue.main.async {
                    self.loader.stopAnimating()
                    self.dataPresenterTxtView.text = presentableText
                }
            }
        }
    }
}

