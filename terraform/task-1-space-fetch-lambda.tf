#### The Terrform resource for the AWS Lambda that runs the space fetch script. Every Github tag release will change the space_fetch_version which
#### causes Terraform to update the Lambda with the new package from S3.

resource "aws_lambda_function" "space_fetch" {
  function_name = "space_fetch"

  s3_bucket = var.bucket_name
  s3_key    = "lambdas/space-fetch-${var.space_fetch_version}.zip"
  timeout = 10
  handler = "fetch_data.lambda_handler"
  runtime = "python3.10"
  role    = var.lambda_iam_role

  environment {
    variables = {
      FILE_NAME    = var.file_name
      BUCKET_NAME  = var.bucket_name
      PATH_NAME    = var.path_name
      OBJECT_NAME  = var.object_name
    }
  }
}


#### This is the cron for space fetch. This resource is located in another git repo along with all the roles and policies to support the Lambda and Github actions.
 

# resource "aws_scheduler_schedule" "cron_space_fetch" {
#   name       = "cron_space_fetch"
#   group_name = "default"

#   flexible_time_window {
#     mode = "OFF"
#   }

#   schedule_expression = "rate(1 days)"

#   target {
#     arn      = aws_lambda_function.space_fetch.arn
#     role_arn = aws_iam_role.space_fetch_lambda_role.arn
#   }
# }