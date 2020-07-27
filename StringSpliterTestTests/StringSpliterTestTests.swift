//
//  StringSpliterTestTests.swift
//  StringSpliterTestTests
//
//  Created by Kazi Abdullah Al Mamun on 27/7/20.
//  Copyright © 2020 Kazi Abdullah Al Mamun. All rights reserved.
//

import XCTest
@testable import StringSpliterTest

class StringSpliterTestTests: XCTestCase {

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
        self.measure {}
    }
    
    func testPerformanceExample1() {
            // This is an example of a performance test case.
            self.measure {
                let vm = MainVCViewModel()
                vm.getData { (str) in
                    let vm = MainVCViewModel()
                    vm.getPresentableText(fromText: str ?? "") { (presentableText) in
                        print(presentableText)
                    }
                }
            }
        }

}
