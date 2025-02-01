resource "terraform_data" "prepare_lambda_layers" {
  triggers_replace = [local.requirements_file_hash]
  provisioner "local-exec" {
    command     = "bash scripts/prepare_layers.sh"
    working_dir = path.module
    environment = {
      REQUIREMENTS_FILE = local.requirements_file
      OUTPUT_DIR        = local.layer_input_path
    }

    on_failure = fail
  }
}

resource "terraform_data" "register_web_token" {
  triggers_replace = [local.bot_api_endpoint, var.bot_token]
  depends_on       = [aws_apigatewayv2_stage.default_stage]
  provisioner "local-exec" {
    command     = "bash scripts/register_telebot.sh"
    working_dir = path.module
    environment = {
      TOKEN   = nonsensitive(var.bot_token) # Assumes script developer will never print bot token
      API_URL = local.bot_api_endpoint
    }

    on_failure = fail
  }
}