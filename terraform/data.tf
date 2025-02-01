data "archive_file" "lambda_src_zip" {
  type        = "zip"
  source_dir  = local.src_input_path
  output_path = local.src_output_path
  excludes    = ["venv"]
}

data "archive_file" "lambda_layer_zip" {
  type        = "zip"
  source_dir  = local.layer_input_path
  output_path = local.layer_output_path
  depends_on  = [terraform_data.prepare_lambda_layers]
}