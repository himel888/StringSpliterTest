//
//  String+Extension.swift
//  StringSpliterTest
//
//  Created by Kazi Abdullah Al Mamun on 27/7/20.
//  Copyright © 2020 Kazi Abdullah Al Mamun. All rights reserved.
//

import Foundation

extension String {
    
    
    /// Generates collection of characters on every nth position.
    /// - Parameter fromStartingIndex: starting index and then will increase by index+index
    /// - Returns: Array of characters that found in every nth index, could be empty also
    func getCharacters(fromStartingIndex index: Int) -> [String] {
        
        var results = [String]()
        var offsetBy = index
        
        let selfStartIndex = self.startIndex
        //let selfEndIndex = self.endIndex
        
        while offsetBy <= self.count {
            let lindex = self.index(selfStartIndex, offsetBy: offsetBy - 1)
            results.append(String(self[lindex]))
            offsetBy += index
        }
        
        return results
    }
}
