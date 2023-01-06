## Technical Challenge
`Challenge #2`: We need to write code that will query the meta data of an instance within AWS or Azure or GCP and provide a json formatted output. 
The choice of language and implementation is up to you.

Bonus Points:
The code allows for a particular data key to be retrieved individually

# Pre requisites:

### To query instance meta data within the AWS instance:
1.	`allow instance meta data tags`: The instances on which this program runs must have the "Allow Instance MetaData Tags" settings enabled. If the infrastructure is managed by terraform, this can be done like:

```sh
metadata_options {
    instance_metadata_tags = "enabled"
    http_endpoint = "enabled"
  }
``` 
### To query instance meta data from outside the instance with AWS Lambda:
1.	The role assumed by AWS Lambda function must have EC2 permission. In our case, DescribeInstances permission alone is sufficient to get the metadata of a particular instance in AWS.