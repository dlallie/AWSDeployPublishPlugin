//
//  AWSDeploy.swift
//  Created by Davis Allie on 27/12/20.
//  Copyright (c) Davis Allie 2020
//  MIT license, see LICENSE file for details
//

import Foundation
import Publish
import ShellOut

public extension DeploymentMethod {
    
    /// Deploy a website to a specified S3 Bucket and (optionally) CloudFront distribution
    /// - Parameters:
    ///   - bucketName: The name of the bucket that the website should be uploaded to.
    ///   - cloudFrontDistributionId: The ID of the CloudFront distribution to be invalidated when deploying the website
    ///   - awsBinaryPath: Path to the AWS binary if you have a non-standard installation
    ///   - syncFullBucket: Whether a sync operation is done or not. If true, any file not present in the S3 bucket that _is_ present in the output directory will be removed.
    static func aws(
        bucketName: String,
        cloudFrontDistributionId: String?,
        awsBinaryPath: String = "/usr/local/bin/aws",
        syncFullBucket: Bool = true
    ) -> Self {
        
        Self(name: "AWS \(bucketName)") { context in
            let deploymentFolder = try! context.createDeploymentFolder(withPrefix: "AWS-") { _ in }
            let aws = AWS(
                context: context,
                binPath: awsBinaryPath,
                bucket: bucketName,
                cdnDistribution: cloudFrontDistributionId,
                sourcePath: deploymentFolder.path,
                sync: syncFullBucket
            )
            
            try aws.deploy()
            try deploymentFolder.delete()
        }
        
    }
}
