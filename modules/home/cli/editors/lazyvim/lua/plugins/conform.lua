return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      hcl = { "packer_fmt" },
      terraform = { "tofu_fmt" },
      tf = { "tofu_fmt" },
      tofu = { "tofu_fmt" },
      ["terraform-vars"] = { "tofu_fmt" },
      ["opentofu-vars"] = { "tofu_fmt" },
    },
  },
}
