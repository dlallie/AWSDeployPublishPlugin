# AWSDeployPublishPlugin

A deployment method for [Publish](https://github.com/johnsundell/publish) to upload static website files to S3 with optional support for a CloudFront CDN..

## Preface
If you want to learn how to configure a S3 bucket for static site hosting, you can learn how to [here](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html)

Ensure you have the AWS CLI installed and configured. You should have a file located at `~/.aws/config` that contains a default AWS region. You should also have a file located at `~/.aws/credentials` that contains your Access Key Id and Secret Access Key. _

Download and installation for the AWS CLI are located [here](https://aws.amazon.com/cli/) 

## Installation


Add AWSDeployPublishPlugin to your `Package.swift` file.

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/dlallie/AWSDeployPublishPlugin", from: "0.1.0")
    ],
    targets: [
        .target(
            ...
            dependencies: [
                ...
                "AWSDeployPublishPlugin"
            ]
        )
    ]
    ...
)
```



## Usage

You can then declare your deployment method in your pipeline:
```swift
import AWSDeployPublishPlugin
...
try Website().publish(using: [
    ...
    .deploy(using: .aws(s3Bucket: "<name>", cloudFrontDistributionId: "<id>"))
])
```
By default, the package assumes you have the AWS CLI installed at `/usr/local/bin/aws`. If you want to provide a different AWS binary, you can pass the `pathToAWSBinary` and give the _full_ path to the binary. 

By defualt, the package will deploy using the `sync` argument set to `true`. This will ensure the state of the S3 bucket matches the state of the Output directory _exactly_. If you have files in your bucket that are not present in your static site directory and you _don't_ want those files to be removed, set the `sync` argument to false.


## Acknowledgement

Thanks to John Sundell (@johnsundell) for creating [Publish](https://github.com/johnsundell/publish) and John Behnke for creating the base [S3PublishDeploy](https://github.com/JohnBehnke/S3PublishDeploy) on which this plugin is based.

## License
MIT License
