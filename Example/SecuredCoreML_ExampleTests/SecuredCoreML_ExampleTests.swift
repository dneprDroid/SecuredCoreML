//
//  SecuredCoreML_ExampleTests.swift
//  SecuredCoreML_ExampleTests
//
//  Created by user on 6/19/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import SecuredCoreML


class SecuredCoreML_ExampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDecryption() {
        let encrypted:[Float32] = [-7.65761924e-32, -4.41620109e-08, -4.12600125e-15, -9.30024058e-08,
                                   -4.23103401e-08, -5.29963646e-14, -2.33502263e-07, -1.28548752e-14,
                                   -2.60575280e+07, -3.64221600e+08, -1.58905697e+15, -9.63227920e+07,
                                   -1.28828848e+08, -8.72321783e+13, -2.86682180e+07, -5.44418445e+14]
        let key = "some key lll bla-bla-bla"
        let expected:[Float32] = [0.0, 0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0, 2.25, 2.5, 2.75, 3.0, 3.25, 3.5, 3.75]
        MetalCryptoTest.testDecryption(encrypted: encrypted,
                                       key: key,
                                       expectedDecrypted:  expected,
                                       failCallback: XCTFail)
    }
    
}
