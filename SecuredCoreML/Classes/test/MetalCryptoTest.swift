//
//  MetalCryptoTest.swift
//  Pods-SecuredCoreML_Example
//
//  Created by user on 6/19/18.
//

import Metal
import Accelerate

import Metal

public class MetalCryptoTest {
    public typealias FailCallback = (_ message: String, _ file: StaticString, _ line: UInt)->Void
    
    public static func testDecryption(encrypted:[Float32],
                                      key:String,
                                      expectedDecrypted:[Float32],
                                      failCallback: @escaping FailCallback) {
        let base64Encoded = key._base64Encoded()
        guard let key64Data = base64Encoded.data(using: .utf8) else {
            failCallback("key64Data creation failed", #file, #line)
            return
        }
        testDecryption(encrypted: encrypted, key: key64Data, expectedDecrypted: expectedDecrypted, failCallback: failCallback)
    }
    
    public static func testDecryption(encrypted:[Float32],
                                      key:Data,
                                      expectedDecrypted:[Float32],
                                      failCallback: @escaping FailCallback) {
        
        let device:MTLDevice = MTLCreateSystemDefaultDevice()!
        guard let library = try? device.makeDefaultLibrary(bundle: Bundle(for: self)) else {
            failCallback("DefaultLibrary not found in this bundle: \(Bundle(for: self))", #file, #line)
            return
        }
        let swishFunction = library.makeFunction(name: "CMLSecure_test")!
        let swishPipeline = try! device.makeComputePipelineState(function: swishFunction)
        
        
        let pxFormat:MTLPixelFormat = .r32Float//MTLPixelFormat.init(rawValue: 115)!// MTLPixelFormat :: rgba16Float
        

        let w = encrypted.count
        let h = 1
        
        print("Key size: \(key.count * 8) bits")
        guard
            let inTexture  = device.makeTexture(array: encrypted, width: w, height: h,
                                                featureChannels: 1, pixelFormat: pxFormat, usage: .shaderRead),
            let outTexture = device.makeTexture(type: Float32.self, width: w, height: h,
                                                featureChannels: 1, pixelFormat: pxFormat, usage: .shaderWrite),
            let keyTexture = device.makeTexture(data: key, type: UInt32.self, pixelFormat: .r32Uint, usage: .shaderRead)
        else {
            failCallback("Texture & buffer creation is failed.", #file, #line)
            return
        }
        
        print("Encrypted Array [size=\(encrypted.count)]: \(encrypted)\n")
        print("---------------------------------------------------------\n\n")
        if  let queue = device.makeCommandQueue(),
            let buffer = queue.makeCommandBuffer(),
            let encoder:MTLComputeCommandEncoder = buffer.makeComputeCommandEncoder() {
            encoder.setTexture(inTexture, index: 0)
            encoder.setTexture(outTexture, index: 1)
            encoder.setTexture(keyTexture, index: 2)
            encoder.dispatch(pipeline: swishPipeline, texture: inTexture)
            encoder.endEncoding()
            buffer.commit()
            buffer.waitUntilCompleted()
            let output = outTexture.toFloatArray(width: outTexture.width, height: outTexture.height, featureChannels: 1)
            print("Decrypted array: \(output)")
            if expectedDecrypted.count != output.count {
                failCallback("Output array length != `expectedDecrypted` length", #file, #line)
                return
            }
            for i in 0..<output.count {
                let outVal = output[i]
                let expectedVal = expectedDecrypted[i]
                if outVal != expectedVal {
                    failCallback("Output array != `expectedDecrypted`", #file, #line)
                    return
                }
            }
        }
    }
}




