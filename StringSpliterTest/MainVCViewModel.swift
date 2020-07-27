//
//  MainVCViewModel.swift
//  StringSpliterTest
//
//  Created by Kazi Abdullah Al Mamun on 28/7/20.
//  Copyright © 2020 Kazi Abdullah Al Mamun. All rights reserved.
//

import Foundation

class MainVCViewModel {
    
    var data = ""
    
    /// Generates collection of characters on every nth position.
    /// - Parameter fromStartingIndex: starting index and then will increase by index+index
    /// - Parameter ofText: String from where charcters will extract
    /// - Returns: Array of characters that found in every nth index, could be empty also
    func getCharacters(ofText text: String, fromStartingIndex index: Int,  dispatchGroup: DispatchGroup? = nil, completion: ([String]) -> Void) {
        if let group = dispatchGroup { group.enter() }
        var results = [String]()
        var offsetBy = index
        
        let selfStartIndex = text.startIndex
        
        while offsetBy <= text.count {
            let lindex = text.index(selfStartIndex, offsetBy: offsetBy - 1)
            results.append(String(text[lindex]))
            offsetBy += index
        }
        
        completion(results)
    }
    
    func getWords(fromText text: String) -> [String] {
        
        let wordsSubStr = text.split{ !$0.isLetter }
        
        // reduce single characters
        let exceptSingleCharsSubStr = wordsSubStr.filter { $0.count > 1 ? true : ["a", "A", "i", "I"].contains($0.description)}
        
        // convert SubString to String
        let wordsStr = exceptSingleCharsSubStr.map{ return String($0) }
        
        return wordsStr
    }
    
    func getWordOccurences(fromText text: String, dispatchGroup: DispatchGroup? = nil, completion: ([String: Int]) -> Void) {
        
        if let group = dispatchGroup { group.enter() }
        var words: [String] = getWords(fromText: text)
        
        var frequencyCount: [String: Int] = [:]
        
        while !words.isEmpty {
            var count = 0
            let firstWord = words[0]
            for word in words {
                if word == firstWord {
                    count += 1
                }
            }
            words = words.filter { $0 != firstWord}
            frequencyCount[firstWord] = count
        }
        
        completion(frequencyCount)
    }
    
    func getLastChar(fromText text: String, dispatchGroup: DispatchGroup? = nil, completion: (String?) -> Void) {
        if let group = dispatchGroup { group.enter() }
        guard !text.isEmpty else { completion(""); return }
        let lastChar = text.last!
        completion(String(lastChar))
    }
    
    func getPresentableText(fromText text: String, completion: @escaping(String) -> Void) {
        
        let dispatchGroup = DispatchGroup()
        var lastChar = ""
        var charsInEvery10th = [String]()
        var wordOccurences = [String: Int]()
        
        getLastChar(fromText: text, dispatchGroup: dispatchGroup) { (char) in
            lastChar = char ?? ""
            dispatchGroup.leave()
        }
        
        getCharacters(ofText: text, fromStartingIndex: 10, dispatchGroup: dispatchGroup) { (charArr) in
            charsInEvery10th = charArr
            dispatchGroup.leave()
        }
        
        getWordOccurences(fromText: text, dispatchGroup: dispatchGroup) { (occurences) in
            wordOccurences = occurences
            dispatchGroup.leave()
        }
        
        let presentableStr = """
        Last Character: \(lastChar)\n\n
        
        Every 10th character===\n\n \(charsInEvery10th)\n\n
        Words occured====\n\n \(wordOccurences.description)
        """
        
        dispatchGroup.notify(queue: .main) {
            completion(presentableStr)
        }
    }
    
    func getData(completion: @escaping(String?) -> Void) {
        
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
