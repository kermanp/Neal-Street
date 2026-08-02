config {
  format = "compact"
  plugin_dir = "~/.tflint.d/plugins"
}

# Enables AWS-specific rules and checks
plugin "aws" {
  enabled = true
  version = "0.30.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}