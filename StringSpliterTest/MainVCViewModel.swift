//
//  MainVCViewModel.swift
//  StringSpliterTest
//
//  Created by Kazi Abdullah Al Mamun on 28/7/20.
//  Copyright © 2020 Kazi Abdullah Al Mamun. All rights reserved.
//

import Foundation

class MainVCViewModel {
    
    let text:String
    
    init(_ text: String) {
        self.text = text
    }
    
    /// Generates collection of characters on every nth position from member variable text which is String type.
    /// - Parameter fromStartingIndex: starting index and then will increase by index+index
    /// - Returns: Array of characters that found in every nth index, could be empty also
    func getCharacters(fromStartingIndex index: Int,  dispatchGroup: DispatchGroup? = nil, completion: ([String]) -> Void) {
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
    
    
    /// Search for word in member variable text, ignoring non letter and single character,
    /// can contains redundent word.
    /// - Returns: Array of word found is search
    func getWords() -> [String] {
        
        let wordsSubStr = text.split{ !$0.isLetter }
        
        // reduce single characters
        let exceptSingleCharsSubStr = wordsSubStr.filter { $0.count > 1 ? true : ["a", "A", "i", "I"].contains($0.description)}
        
        // convert SubString to String
        let wordsStr = exceptSingleCharsSubStr.map{ return String($0) }
        
        return wordsStr
    }
    
    
    /// Calculates number of occurences of words found in text of member variable
    /// - Parameters:
    ///   - dispatchGroup: Pass a dispatch group if you want to run this method in a group with other task asynchronously else pass nill or ignore it.
    ///   - completion: Using this closure to return result as if Dispatch group passed we can leave from group after completion of task.
    func getWordOccurences(dispatchGroup: DispatchGroup? = nil, completion: ([String: Int]) -> Void) {
        
        if let group = dispatchGroup { group.enter() }
        var words: [String] = getWords()
        
        var frequencyCount: [String: Int] = [:]
        
        while !words.isEmpty {
            var count = 1
            let firstWord = words[0]
            words.remove(at: 0)
            for word in words {
                if word.lowercased() == firstWord.lowercased() {
                    count += 1
                }
            }
            words = words.filter { $0.lowercased() != firstWord.lowercased()}
            frequencyCount[firstWord] = count
        }
        
        completion(frequencyCount)
    }
    
    
    /// Get last character of member variable text
    /// - Parameters:
    ///   - dispatchGroup: Pass a dispatch group if you want to run this method in a group with other task asynchronously else pass nill or ignore it.
    ///   - completion: Using this closure to return result as if Dispatch group passed we can leave from group after completion of task.
    func getLastChar(dispatchGroup: DispatchGroup? = nil, completion: (String?) -> Void) {
        if let group = dispatchGroup { group.enter() }
        guard !text.isEmpty else { completion(""); return }
        let lastChar = text.last!
        completion(String(lastChar))
    }
    
    
    /// Prepares a presentable string from member variable text to show in textview according to business logic,
    /// last character of text then every 10th characters and then occurences of every words.
    /// - Parameter completion: Notify or return result after completion of task.
    func getPresentableText(completion: @escaping(String) -> Void) {
        
        let dispatchGroup = DispatchGroup()
        var lastChar = ""
        var charsInEvery10th = [String]()
        var wordOccurences = [String: Int]()
        
        getLastChar(dispatchGroup: dispatchGroup) { (char) in
            lastChar = char ?? ""
            dispatchGroup.leave()
        }
        
        getCharacters(fromStartingIndex: 10, dispatchGroup: dispatchGroup) { (charArr) in
            charsInEvery10th = charArr
            dispatchGroup.leave()
        }
        
        getWordOccurences(dispatchGroup: dispatchGroup) { (occurences) in
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
    
}
