//
//  AWS.swift
//  Created by John Behnke on 27/12/20.
//  Copyright (c) Davis Allie 2020
//  MIT license, see LICENSE file for details
//

import ShellOut
import Publish

struct AWS<Site: Website> {
    let context: PublishingContext<Site>
    let binPath: String
    let bucket: String
    let cdnDistribution: String?
    let sourcePath: String
    let sync: Bool
    
    /// Deploy website to AWS
    /// - Throws: ShelloutError if an error happens during the upload process
    /// - Throws: AWSError if the AWS Binary file couldn't be located
    func deploy() throws {
        try checkAWSBinaryLocation()
        try uploadFilesToS3()
        try invalidateCdnIfNeeded()
    }
    
    private func checkAWSBinaryLocation() throws {
        do {
            let binPath = try shellOut(
                to: "which aws"
            )
            if binPath.isEmpty {
                throw AWSError.noBinaryFound
            }
        } catch let error as ShellOutError {
            throw error
        }
    }
    
    private func uploadFilesToS3() throws {
        var shellCommand = "\(binPath) s3 sync . s3://\(bucket)"
        
        // Add delete flag to command to fully sync destination with source files
        // This deletes any files from S3 that aren't present in the upload
        if sync {
            shellCommand += " --delete"
        }
        
        do {
            try shellOut(
                to: shellCommand,
                at: sourcePath
            )
        } catch let error as ShellOutError {
            throw PublishingError(infoMessage: error.message)
        } catch {
            throw error
        }
    }
    
    private func invalidateCdnIfNeeded() throws {
        // We don't need to do anything if no CloudFront distribution is provided
        guard let distribution = cdnDistribution else {
            return
        }
        
        do {
            try shellOut(
                to: "aws cloudfront create-invalidation --distribution-id \(distribution) --paths \"/*\"",
                at: sourcePath
            )
        } catch let error as ShellOutError {
            throw PublishingError(infoMessage: error.message)
        } catch {
            throw error
        }
    }
    
}
