{
  lib,
  pkgs,
  ...
}:
let
  # Pinned snapshot of github/awesome-copilot — skills from this repo are used via
  # programs.opencode.skills. Bump rev + hash to update.
  awesome-copilot = pkgs.fetchFromGitHub {
    owner = "github";
    repo = "awesome-copilot";
    rev = "63d08d51f792d53feec8c1c06897cee870e83c18";
    hash = "sha256-ZCyhl2F6oBj6FYNfPKfS1jpf7RI/OVHJQi1C7kpxDjo=";
  };

  # https://github.com/JuliusBrussee/caveman
  caveman = pkgs.fetchFromGitHub {
    owner = "JuliusBrussee";
    repo = "caveman";
    rev = "v1.9.0";
    hash = "sha256-ocWViFf5KO0Lt0yM/vu4barAOCZBlvvj0iu17XCW1GE=";
  };

  # https://github.com/ayghri/i-have-adhd
  i-have-adhd = pkgs.fetchFromGitHub {
    owner = "ayghri";
    repo = "i-have-adhd";
    rev = "24d22f783e57cb73c957848b588c6f651b6f9cd8";
    hash = "sha256-xTVs8SFhJEil8yjx3ODB7Gn3h1rg4QSq4zHPncWvV3c=";
  };

  # https://github.com/ClickHouse/agent-skills
  clickhouse-agent-skills = pkgs.fetchFromGitHub {
    owner = "ClickHouse";
    repo = "agent-skills";
    rev = "544384f4fab1d6ed59f16a354d1c68296dfa6007";
    hash = "sha256-sfoqJnCEWRcD4S27mYkulC7oB++v36CVPx0urwnt93Q=";
  };

  # https://github.com/alvinunreal/oh-my-opencode-slim
  # Agent orchestration plugin. The plugin itself and its bundled skills are installed by
  # opencode/the plugin at runtime; everything below is the declarative equivalent of
  # `bunx oh-my-opencode-slim@latest install`.
  oh-my-opencode-slim = {
    "$schema" = "https://unpkg.com/oh-my-opencode-slim@latest/oh-my-opencode-slim.schema.json";
    preset = "anthropic";
    presets = {
      # Variants are omitted on purpose: opencode defines no reasoning variants for
      # anthropic models, so the plugin would pass an unknown effort level through.
      anthropic = {
        orchestrator = {
          model = "anthropic/claude-opus-5";
          skills = [ "*" ];
          mcps = [
            "*"
            "!context7"
          ];
        };
        oracle = {
          model = "anthropic/claude-opus-5";
          skills = [ "simplify" ];
          mcps = [ ];
        };
        council = {
          model = "anthropic/claude-opus-5";
          skills = [ ];
          mcps = [ ];
        };
        librarian = {
          model = "anthropic/claude-haiku-4-5";
          skills = [ ];
          mcps = [
            "context7"
            "gh_grep"
          ];
        };
        explorer = {
          model = "anthropic/claude-haiku-4-5";
          skills = [ ];
          mcps = [ ];
        };
        designer = {
          model = "anthropic/claude-sonnet-5";
          skills = [ ];
          mcps = [ ];
        };
        fixer = {
          model = "anthropic/claude-sonnet-5";
          skills = [ ];
          mcps = [ ];
        };
      };
    };
    council = {
      default_preset = "default";
      presets = {
        default = {
          alpha = {
            model = "anthropic/claude-opus-5";
          };
          beta = {
            model = "anthropic/claude-sonnet-5";
          };
          gamma = {
            model = "anthropic/claude-opus-4-8";
          };
        };
      };
    };
    multiplexer = {
      type = "tmux";
      layout = "main-vertical";
      main_pane_size = 60;
    };
  };
in
{
  programs.opencode = {
    enable = lib.mkDefault true;

    skills = {
      excalidraw-diagram-generator = "${awesome-copilot}/skills/excalidraw-diagram-generator";
      caveman = "${caveman}/plugins/caveman/skills/caveman";
      chdb-datastore = "${clickhouse-agent-skills}/skills/chdb-datastore";
      chdb-sql = "${clickhouse-agent-skills}/skills/chdb-sql";
      clickhouse-architecture-advisor = "${clickhouse-agent-skills}/skills/clickhouse-architecture-advisor";
      clickhouse-best-practices = "${clickhouse-agent-skills}/skills/clickhouse-best-practices";
      i-have-adhd = "${i-have-adhd}/skills/i-have-adhd";
    };

    settings = {
      model = "anthropic/claude-opus-5";
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
        "opencode-claude-auth"
        "oh-my-opencode-slim"
        # Disable superpowers for now
        # "superpowers@git+https://github.com/obra/superpowers.git"
      ];
      # oh-my-opencode-slim replaces the built-in subagents with its own pantheon and
      # relies on opencode's LSP tools.
      lsp = true;
      default_agent = "orchestrator";
      agent = {
        explore.disable = true;
        general.disable = true;
      };
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
      plugin = [ "oh-my-opencode-slim" ];
    };
  };

  xdg.configFile."opencode/oh-my-opencode-slim.json" = {
    text = builtins.toJSON oh-my-opencode-slim;
  };

  # TODO: remove this workaround once https://github.com/anomalyco/opencode/issues/16885 is fixed.
  # The migration gate checks for opencode.db but the stable channel uses opencode-stable.db,
  # so the "one time database migration" message appears on every startup.
  home.file.".local/share/opencode/opencode.db".text = "";

  home.sessionVariables = {
    OPENCODE_ENABLE_EXA = "1";
    # Required by oh-my-opencode-slim: the orchestrator dispatches specialists as
    # native background subagents.
    OPENCODE_EXPERIMENTAL_BACKGROUND_SUBAGENTS = "true";
  };

  programs.zsh.shellAliases = {
    oc = "opencode";
  };
}
