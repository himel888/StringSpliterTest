//
//  ViewController.swift
//  StringSpliterTest
//
//  Created by Kazi Abdullah Al Mamun on 27/7/20.
//  Copyright © 2020 Kazi Abdullah Al Mamun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData { (str) in
            guard let lStr = str, !lStr.isEmpty else {
                print("No data found")
                return
            }
            
            print("Found String Data: \(lStr)")
            print("\n========================================\n")
            print("Last Character is: \(lStr.last!)")
            
            print("\n========================================\n")
            print("Every 10th Characters are: \(lStr.getCharacters(fromStartingIndex: 10))")
        }
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
}

