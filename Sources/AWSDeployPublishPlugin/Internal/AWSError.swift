//
//  AWSError.swift
//  Created by Davis Allie on 27/12/20.
//  Copyright (c) Davis Allie 2020
//  MIT license, see LICENSE file for details
//

internal enum AWSError: Error {
    case noBinaryFound
}

extension AWSError : CustomStringConvertible {
    var description: String {
        switch self {
        case .noBinaryFound:
            return "⚠️  You might not have aws-cli installed! Read how to install here: https://aws.amazon.com/cli/ ⚠️."
        }
    }
}
