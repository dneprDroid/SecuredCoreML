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
        MetalCryptoTest.testDecryption(encrypted:      [3.08285662e-44, 2.53311366e-01, 5.00000000e-01, 7.50264883e-01,
                                                        1.00000525e+00, 1.25005281e+00, 1.50276947e+00, 1.75000131e+00,
                                                        2.01059628e+00, 2.25000525e+00, 2.52649093e+00, 2.75000000e+00,
                                                        3.00105953e+00, 3.25001049e+00, 3.50010562e+00, 3.75553894e+00],
                                       key:                 [22, 111111, 0, 4444, 44, 443, 23232, 11, 44444],
                                       expectedDecrypted:   [0.0, 0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0, 2.25, 2.5, 2.75, 3.0, 3.25, 3.5, 3.75],
                                       failCallback: XCTFail)
    }
    
}
