#This is some boilerplate Terraform to deploy space-fetch from Github's
#container registry to a Kubernetes cluster. 


##### AWS keys to upload to S3. This can be changed to use OIDC.

# resource "kubernetes_secret" "aws_credentials" {
#   metadata {
#     name = "aws-credentials"
#   }

#   data = {
#     AWS_ACCESS_KEY_ID     = ""
#     AWS_SECRET_ACCESS_KEY = ""
#   }
# }

##### The kubernetes cron job. It launches the space fetch container daily. You can bump the version by changing the space_fetch_version variable in Terraform.

# resource "kubernetes_cron_job" "space_fetch_cronjob" {
#   metadata {
#     name = "space-fetch-cronjob"
#   }

#   spec {
#     schedule = "0  0 * * *"

#     job_template {
#       metadata {
        
#       }
#       spec {
#         template {
#           metadata {
            
#           }
#           spec {
#             container {
#               image = "ghcr.io/daniel-mcdonough/space-fetch:${var.space_fetch_version}"
#               name  = "space-fetch"

#               env {
#                 name  = "BUCKET_NAME"
#                 value = "${var.bucket_name}"
#               }

#               env {
#                 name  = "OBJECT_NAME"
#                 value = "${var.object_name}"
#               }

#               env {
#                 name  = "PATH_NAME"
#                 value = "${var.path_name}"
#               }

#               env {
#                 name = "AWS_ACCESS_KEY_ID"
#                 value_from {
#                   secret_key_ref {
#                     name = kubernetes_secret.aws_credentials.metadata[0].namee
#                     key  = "aws-access-key-id"
#                   }
#                 }
#               }

#               env {
#                 name = "AWS_SECRET_ACCESS_KEY"
#                 value_from {
#                   secret_key_ref {
#                     name = kubernetes_secret.aws_credentials.metadata[0].name
#                     key  = "aws-secret-access-key"
#                   }
#                 }
#               }
#             }
#             restart_policy = "OnFailure"
#           }
#         }
#       }
#     }
#   }
# }
