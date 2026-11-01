{
  lib,
  pkgs,
  ...
}:
{
  programs.opencode = {
    enable = lib.mkDefault true;

    # Skills are managed by modules/terminal/agent-skills.nix (programs.agent-skills),
    # which syncs the selected skill set into ~/.config/opencode/skills.

    settings = {
      model = "anthropic/claude-opus-5-5#medium";
      provider = {
        bifrost = {
          npm = "@ai-sdk/openai-compatible";
          name = "Bifrost (bifrost.kleboth.de)";
          options = {
            baseURL = "https://bifrost.kleboth.de/v1";
          };
          models = {
            "qwen3.8" = {
              name = "Qwen3.8 27B NVFP4 MTP (via Bifrost)";
              tool_call = true;
              reasoning = true;
              attachment = true;
              modalities = {
                input = [
                  "text"
                  "image"
                ];
                output = [ "text" ];
              };
              limit = {
                context = 262144;
                output = 32768;
              };
              variants = {
                none = {
                  reasoningEffort = "none";
                };
                low = {
                  reasoningEffort = "low";
                };
                medium = {
                  reasoningEffort = "medium";
                };
                xhigh = {
                  reasoningEffort = "xhigh";
                };
              };
            };
          };
        };
        litellm = {
          npm = "@ai-sdk/openai-compatible";
          name = "LiteLLM (litellm.kleboth.de)";
          options = {
            baseURL = "https://litellm.kleboth.de/v1";
          };
          models = {
            "qwen3.8" = {
              name = "Qwen3.8 27B NVFP4 MTP (via LiteLLM)";
              tool_call = true;
              reasoning = true;
              attachment = true;
              modalities = {
                input = [
                  "text"
                  "image"
                ];
                output = [ "text" ];
              };
              limit = {
                context = 262144;
                output = 32768;
              };
              variants = {
                none = {
                  reasoningEffort = "none";
                };
                low = {
                  reasoningEffort = "low";
                };
                medium = {
                  reasoningEffort = "medium";
                };
                xhigh = {
                  reasoningEffort = "xhigh";
                };
              };
            };
          };
        };
        llamacpp = {
          npm = "@ai-sdk/openai-compatible";
          name = "llama.cpp (10.0.1.12)";
          options = {
            baseURL = "http://10.0.1.12:8080/v1";
          };
          models = {
            "qwen3.8-27b-nvfp4-mtp" = {
              name = "Qwen3.8 27B NVFP4 MTP (llama.cpp)";
              tool_call = true;
              reasoning = true;
              attachment = true;
              modalities = {
                input = [
                  "text"
                  "image"
                ];
                output = [ "text" ];
              };
              limit = {
                context = 262144;
                output = 32768;
              };
              variants = {
                none = {
                  reasoningEffort = "none";
                };
                low = {
                  reasoningEffort = "low";
                };
                medium = {
                  reasoningEffort = "medium";
                };
                xhigh = {
                  reasoningEffort = "xhigh";
                };
              };
            };
          };
        };
      };
      mcp = {
        context7 = {
          type = "remote";
          url = "https://mcp.context7.com/mcp";
        };
        nixos = {
          type = "local";
          command = [ "${pkgs.mcp-nixos}/bin/mcp-nixos" ];
          enabled = true;
        };
      };
      plugin = [
        # Pinned: opencode resolves an unversioned spec once and never refreshes it.
        "opencode-claude-auth@2.2.1"
        # Disable superpowers for now
        # "superpowers@git+https://github.com/obra/superpowers.git"
      ];
      # Anthropic is trying to disallow third-party apps like opencode. For now, changing the system prompt to not mention
      # that it is opencode seems to fix it. See: https://github.com/griffinmartin/opencode-claude-auth/issues/145
      mode = {
        plan = {
          prompt = "You are Claude Code, Anthropic's official CLI for Claude.";
        };
        build = {
          prompt = "You are Claude Code, Anthropic's official CLI for Claude.";
        };
      };
    };
  };

  xdg.configFile."opencode/tui.json" = {
    text = builtins.toJSON {
      theme = "tokyonight";
      keybinds = {
        editor_open = "ctrl+g";
      };
    };
  };

  home.sessionVariables = {
    OPENCODE_ENABLE_EXA = "1";
  };

  programs.zsh.shellAliases = {
    oc = "opencode";
  };
}
