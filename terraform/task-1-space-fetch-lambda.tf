

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
