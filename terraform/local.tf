locals {
  telebot_route   = "/bothandler"
  src_input_path  = "${path.module}/../source" # Path to your Lambda source folder
  src_output_path = "${path.module}/out/lambda_src.zip"

  # Python layers configuration
  requirements_file = "${path.module}/../source/requirements.txt"
  layer_input_path  = "${path.module}/out/layers"
  layer_output_path = "${path.module}/out/layers.zip"
}

locals {
requirements_file_hash = filesha256(local.requirements_file)
}

locals {
  bot_api_endpoint = "${aws_apigatewayv2_api.http_api.api_endpoint}${local.telebot_route}"
}