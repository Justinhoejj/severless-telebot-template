# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "${var.bot_name}_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_basic_execution" {
  name       = "${var.bot_name}_policy"
  roles      = [aws_iam_role.lambda_exec_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_layer_version" "lambda_layer" {
  layer_name = "${var.bot_name}_layer"
  filename   = data.archive_file.lambda_layer_zip.output_path
  source_code_hash = data.archive_file.lambda_layer_zip.output_md5

  compatible_runtimes = ["python3.11"]
  depends_on          = [data.archive_file.lambda_layer_zip]
}

# Lambda function
resource "aws_lambda_function" "telebot" {
  function_name    = "${var.bot_name}_telebot"
  role             = aws_iam_role.lambda_exec_role.arn
  runtime          = "python3.11"
  handler          = "index.lambda_handler"
  filename         = local.src_output_path
  timeout          = 10
  source_code_hash = data.archive_file.lambda_src_zip.output_md5
  environment {
    variables = {
      TELEGRAM_BOT_TOKEN = var.bot_token
    }
  }
  layers     = [aws_lambda_layer_version.lambda_layer.arn]
  depends_on = [data.archive_file.lambda_src_zip, aws_lambda_layer_version.lambda_layer]
}