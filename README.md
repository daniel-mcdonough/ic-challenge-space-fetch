### Space Fetch

Space Fetch pulls rocket and payload data from SpaceX and uploads it to S3.

### Usage:

This is designed to be run in a Lambda or a container but can be run directly.

Set the environment variables:

`BUCKET_NAME` `Default: None. Required`

`OBJECT_NAME` `Default: spacex_data.json`

`PATH_NAME` `Default: None` This is to specify the path before the file name to create the object. (eg. s3://bucket/YOURPATHHERE/spacex_data.json

#### AWS Lambda:

- Upload to Lambda and set the environment variables.
- Attach an IAM role with PUT permissions for the desired bucket.

Tested with Python 3.10.

#### EKS:

- Set the configmap.
- Set the appropriate service role.



### Using Cron

#### Lambda:

Use [Eventbridge](https://aws.amazon.com/eventbridge/) to trigger the Lambda on a schedule.


#### Kubernetes:

Use a [Kubernetes CronJob](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/).



### TODO

- Add linting
  
### Best practice
- Add code coverage
- Lock package versions