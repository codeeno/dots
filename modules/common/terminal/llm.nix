{ pkgs, ... }:

{
  home.sessionVariables = {
    LLM_MODEL = "github_copilot/claude-haiku-4.5";
  };

  home.packages = with pkgs; [
    glow
    (python313.withPackages (ps: [
      ps.llm
      ps.llm-github-copilot
    ]))
  ];

  programs.zsh.initContent = ''
    ask() {
      export CLICOLOR_FORCE=1
      local system_prompt="Respond in well-formatted markdown. Use ## headers, fenced code blocks with language tags, bullet lists for multiple items, and bold for emphasis. Be concise, no yapping."
      local output=$(llm -s "$system_prompt" "$*")
      echo "$output" | glow -w 100 -
    }
  '';
}
