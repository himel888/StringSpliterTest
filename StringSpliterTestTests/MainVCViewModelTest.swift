//
//  MainVCViewModelTest.swift
//  StringSpliterTestTests
//
//  Created by Kazi Abdullah Al Mamun on 29/7/20.
//  Copyright © 2020 Kazi Abdullah Al Mamun. All rights reserved.
//

import XCTest
@testable import StringSpliterTest

class MainVCViewModelTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
           
        }
    }

    func testGetLastCharFunc() {
        
        let text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        let vm = MainVCViewModel(text)
        let shouldLastChar = "."
        var foundLastChar = ""
        vm.getLastChar { (lastChar) in
            foundLastChar = lastChar ?? ""
        }
        XCTAssertEqual(shouldLastChar, foundLastChar, "Should equal")
    }
    
    func testGetAllNthChars() {
        
        let baseText = "123456789012345678901234567890"
        
        let nthIndex = 4
        let lhs = ["4", "8", "2", "6", "0", "4", "8"]
        var rhs = [String]()
        let vm = MainVCViewModel(baseText)
        
        vm.getCharacters(fromStartingIndex: nthIndex) { (nthCharacters) in
            rhs = nthCharacters
        }
        
        XCTAssert(!rhs.isEmpty, "can't empty")
        XCTAssertEqual(7, rhs.count, "Shouid have 7 data")
        XCTAssertEqual("6", rhs[3], "4th index should 6")
        XCTAssertEqual(lhs, rhs, "Both collection should have same data")
    }
    
    func testGetWords() {
        
        let baseText = """
        <div id="Content">
        <div id="bannerL"><div id="div-gpt-ad-1474537762122-2">
"""
        //<script type="text/javascript">googletag.cmd.push(function() { //googletag.display("div-gpt-ad-1474537762122-2"); });</script>
        //</div></div>
        
        let vm = MainVCViewModel(baseText)
        let lhs = ["div", "id", "Content", "div", "id", "bannerL", "div", "id", "div", "gpt", "ad"]
        let rhs = vm.getWords()
        
        XCTAssert(rhs.count == 11, "Should get 11 string")
        XCTAssertEqual("id", rhs[4], "5th string shoul be id")
        XCTAssertEqual(lhs, rhs, "lhs and rhs should equal")
    }
    
    func testGetOccurences() {
        let baseText = """
        <div id="Content">
        <div id="bannerL"><div id="div-gpt-ad-1474537762122-2">""
        //<script type="text/javascript">googletag.cmd.push(function() { //googletag.display("div-gpt-ad-1474537762122-2"); });</script>
        //</div></div>
        """
        let vm = MainVCViewModel(baseText)
        let lhsDivCount = 7
        let lhsBannerLCount = 1
        let lhsJsvaScriptCount = 1
        var occurences = [String: Int]()
        vm.getWordOccurences { (lOccurences) in
            occurences = lOccurences
        }
        let rhsDivCount = occurences["div"]
        let rhsBannerLCount = occurences["bannerL"]
        let rhsJsvaScriptCount = occurences["javascript"]
        
        XCTAssert(rhsDivCount != nil, "should not nil")
        XCTAssert(rhsBannerLCount != nil, "should not nil")
        XCTAssert(rhsJsvaScriptCount != nil, "should not nil")
        XCTAssertEqual(lhsDivCount, rhsDivCount, "should equal")
        XCTAssertEqual(lhsBannerLCount, rhsBannerLCount, "should equal")
        XCTAssertEqual(lhsJsvaScriptCount, rhsJsvaScriptCount, "should equal")
    }
}
