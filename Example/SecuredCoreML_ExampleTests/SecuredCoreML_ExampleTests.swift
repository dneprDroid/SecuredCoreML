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
        let encrypted:[Float32] = [-6.06177128e-23,  -3.68551082e-05,  -4.19440828e-12,  -1.43397043e-18,
                                   -5.00144107e-19,  -6.08564325e-19,  -4.46225449e+31,  -1.36937288e+34,
                                   -2.06271388e+16,  -1.77384355e+04,  -1.54256002e+12,  -5.89491230e+18,
                                   -7.62428741e+18,  -7.04782665e+18,  -6.65616506e-32,  -2.78038439e-34]

        let key = "some key lll bla-bla-bla12345678"
        let expected:[Float32] = [0.0, 0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0, 2.25, 2.5, 2.75, 3.0, 3.25, 3.5, 3.75]
        MetalCryptoTest.testDecryption(encrypted: encrypted,
                                       key: key,
                                       expectedDecrypted:  expected,
                                       failCallback: XCTFail)
    }
    
}
