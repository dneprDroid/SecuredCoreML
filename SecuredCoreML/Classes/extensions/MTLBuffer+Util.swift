//
//  MTLBuffer+Util.swift
//  Pods-SecuredCoreML_Example
//
//  Created by user on 6/19/18.
//

import Metal

extension Array where Element:Equatable {
    
    func toMTLBuffer(device: MTLDevice)->MTLBuffer? {
        let length = count * MemoryLayout<Element>.stride
        let buffer = device.makeBuffer(bytes: self, length: length, options: [])
        return buffer
    }
    
}

extension MTLBuffer {
    
    static func createEmpty<Element:Equatable>(repeating: Element,
                                               count: Int,
                                               device: MTLDevice)->MTLBuffer? {
        return [Element].init(repeating: repeating, count: count).toMTLBuffer(device: device)
    }
    
    /**
     Creates a new array of `Float`s and copies the MTLBuffer's data into it.
     */
    public func toFloatArray() -> [Float] {
        return toArray(initial: Float(0))
    }
    
    /**
     Creates a new array of `Int32`s and copies the MTLBuffer's data into it.
     */
    public func toInt32Array() -> [Int32] {
        return toArray(initial: Int32(0))
    }
    
    func toArray<T>(initial: T) -> [T] {
        let count = length / MemoryLayout<T>.stride
        var output = [T](repeating: initial, count: count)
        _ = output.withUnsafeMutableBytes { ptr in
            memcpy(ptr.baseAddress, contents(), length)
        }
        return output
    }
}
