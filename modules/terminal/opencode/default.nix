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
      model = "anthropic/claude-opus-5-5";
      # Anthropic is trying to disallow third-party apps like opencode. For now, changing the system prompt to not mention
      # that it is opencode seems to fix it. See: https://github.com/griffinmartin/opencode-claude-auth/issues/145
      agents = {
        build = {
          model = "anthropic/claude-opus-5-5#medium";
          system = "You are Claude Code, Anthropic's official CLI for Claude.";
        };
        plan = {
          model = "anthropic/claude-opus-5-5#medium";
          system = "You are Claude Code, Anthropic's official CLI for Claude.";
        };
      };
      providers = {
        bifrost = {
          package = "aisdk:@ai-sdk/openai-compatible";
          name = "Bifrost (bifrost.kleboth.de)";
          settings = {
            baseURL = "https://bifrost.kleboth.de/v1";
          };
          models = {
            "qwen3.8" = {
              name = "Qwen3.8 27B NVFP4 MTP (via Bifrost)";
              capabilities = {
                tools = true;
                input = [
                  "text"
                  "image"
                ];
                output = [ "text" ];
                reasoning = {
                  supported = true;
                };
              };
              limit = {
                context = 262144;
                output = 32768;
              };
              variants = [
                {
                  id = "none";
                  settings = {
                    reasoningEffort = "none";
                  };
                }
                {
                  id = "low";
                  settings = {
                    reasoningEffort = "low";
                  };
                }
                {
                  id = "medium";
                  settings = {
                    reasoningEffort = "medium";
                  };
                }
                {
                  id = "xhigh";
                  settings = {
                    reasoningEffort = "xhigh";
                  };
                }
              ];
            };
          };
        };
        litellm = {
          package = "aisdk:@ai-sdk/openai-compatible";
          name = "LiteLLM (litellm.kleboth.de)";
          settings = {
            baseURL = "https://litellm.kleboth.de/v1";
          };
          models = {
            "qwen3.8" = {
              name = "Qwen3.8 27B NVFP4 MTP (via LiteLLM)";
              capabilities = {
                tools = true;
                input = [
                  "text"
                  "image"
                ];
                output = [ "text" ];
                reasoning = {
                  supported = true;
                };
              };
              limit = {
                context = 262144;
                output = 32768;
              };
              variants = [
                {
                  id = "none";
                  settings = {
                    reasoningEffort = "none";
                  };
                }
                {
                  id = "low";
                  settings = {
                    reasoningEffort = "low";
                  };
                }
                {
                  id = "medium";
                  settings = {
                    reasoningEffort = "medium";
                  };
                }
                {
                  id = "xhigh";
                  settings = {
                    reasoningEffort = "xhigh";
                  };
                }
              ];
            };
          };
        };
        llamacpp = {
          package = "aisdk:@ai-sdk/openai-compatible";
          name = "llama.cpp (10.0.1.12)";
          settings = {
            baseURL = "http://10.0.1.12:8080/v1";
          };
          models = {
            "qwen3.8-27b-nvfp4-mtp" = {
              name = "Qwen3.8 27B NVFP4 MTP (llama.cpp)";
              capabilities = {
                tools = true;
                input = [
                  "text"
                  "image"
                ];
                output = [ "text" ];
                reasoning = {
                  supported = true;
                };
              };
              limit = {
                context = 262144;
                output = 32768;
              };
              variants = [
                {
                  id = "none";
                  settings = {
                    reasoningEffort = "none";
                  };
                }
                {
                  id = "low";
                  settings = {
                    reasoningEffort = "low";
                  };
                }
                {
                  id = "medium";
                  settings = {
                    reasoningEffort = "medium";
                  };
                }
                {
                  id = "xhigh";
                  settings = {
                    reasoningEffort = "xhigh";
                  };
                }
              ];
            };
          };
        };
      };
      mcp = {
        servers = {
          context7 = {
            type = "remote";
            url = "https://mcp.context7.com/mcp";
          };
          nixos = {
            type = "local";
            command = [ "${pkgs.mcp-nixos}/bin/mcp-nixos" ];
          };
        };
      };
      plugins = [
        "opencode-claude-auth@3.0.0"
      ];
    };

    # TUI config (cli.json). TUI plugins live here, not in settings.
    cli = {
      theme.name = "tokyonight";
      keybinds = {
        "prompt.editor" = "ctrl+g";
      };
      diffs.wrap = "word";
      session = {
        sidebar = "hide";
        scrollbar = true;
        thinking = "show";
      };
      animations = true;
      plugins = [
        # https://github.com/leohenon/opencode-vim-plugin
        {
          package = "@leohenon/opencode-vim-plugin@beta";
          options = {
            enabled = true;
          };
        }
      ];
    };
  };

  home.sessionVariables = {
    OPENCODE_ENABLE_EXA = "1";
  };

  programs.zsh.shellAliases = {
    oc = "opencode";
  };
}
