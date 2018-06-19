//
//  MTLComputeCommandEncoder+Util.swift
//  Pods-SecuredCoreML_Example
//
//  Created by user on 6/19/18.
//

import Foundation



extension MTLComputeCommandEncoder {
    func dispatch(pipeline: MTLComputePipelineState, texture: MTLTexture) {
        let w = pipeline.threadExecutionWidth
        let h = pipeline.maxTotalThreadsPerThreadgroup / w
        let threadGroupSize = MTLSizeMake(w, h, 1)
        
        let threadGroups = MTLSizeMake(
            (texture.width       + threadGroupSize.width  - 1) / threadGroupSize.width,
            (texture.height      + threadGroupSize.height - 1) / threadGroupSize.height,
            (texture.arrayLength + threadGroupSize.depth  - 1) / threadGroupSize.depth)
        
        setComputePipelineState(pipeline)
        dispatchThreadgroups(threadGroups, threadsPerThreadgroup: threadGroupSize)
    }
}
