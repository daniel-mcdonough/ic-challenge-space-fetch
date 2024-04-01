
variable "lambda_iam_role" {
  description = "lambda iam role"
  type = string
  sensitive = true
}

variable "space_fetch_version" {
  description = "Space fetch version. ie. v0.1.0"
  type = string
  default = "spacex_data.json"
}

variable "file_name" {
  description = "Output local JSON file name"
  type = string
  default = "spacex_data.json"
}

variable "bucket_name" {
  description = "S3 output bucket"
  type = string
}

variable "path_name" {
  description = "Path for output JSON. Gets concatenated with bucket_name and file_name"
  type = string
  default = ""
}

variable "object_name" {
  description = "Output S3 file name"
  type = string
  default = "spacex_data.json"
}