{
  inputs,
  ...
}:
let
  agentLib = inputs.agent-skills.lib.agent-skills;
in
{
  imports = [ inputs.agent-skills.homeManagerModules.default ];

  # Skill IDs are the paths of the SKILL.md directories relative to each
  # source's subdir; the selected skills are synced to ~/.config/opencode/skills
  # by home-manager activation. Sources are pinned in registry/sources.lock.json
  # (npins); add a repo by dropping a manifest in registry/sources/ and running
  # `nix run .#skills-sources-lock`.
  programs.agent-skills = {
    enable = true;

    sources = agentLib.sourcesFromLock {
      manifestsDir = ../../registry/sources;
      lockFile = ../../registry/sources.lock.json;
    };

    skills.enable = [
      "caveman"
      "chdb-datastore"
      "chdb-sql"
      "clickhouse-architecture-advisor"
      "clickhouse-best-practices"
      "excalidraw-diagram-generator"
      "i-have-adhd"
    ];

    targets.opencode.enable = true;
  };
}
