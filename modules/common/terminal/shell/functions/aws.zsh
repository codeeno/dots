# AWS-related shell functions

# Get a parameter from AWS SSM using fzf
param() {
  aws ssm get-parameter \
    --name $(aws ssm describe-parameters --output text --query 'Parameters[].[Name]' | fzf) \
    --output text \
    --with-decryption \
    --query 'Parameter.Value'
}

# Get a secret from AWS Secrets Manager using fzf
secret() {
  aws secretsmanager get-secret-value \
    --secret-id $(aws secretsmanager list-secrets --output text --query 'SecretList[].[Name]' | fzf) \
    --query 'SecretString'
}

# Tail logs from a CloudWatch log group selected via fzf
logs() {
  aws logs tail \
    $(aws logs describe-log-groups --output text --query 'logGroups[*].[logGroupName]' | fzf) \
    --follow \
    --since 30m
}
