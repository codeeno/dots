return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      terraform = { "tflint" },
      tf = { "tflint" },
      tofu = { "tflint" },
    },
  },
}
