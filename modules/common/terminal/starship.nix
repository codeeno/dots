{
  lib,
  ...
}:

{
  programs.starship = {
    enable = lib.mkDefault true;
    settings = {
      format = lib.concatStrings [
        "[╭](fg:current_line)"
        "$directory"
        "$git_branch"
        "$git_status"
        "$fill"
        "$nodejs"
        "$python"
        "$cmd_duration"
        "$kubernetes"
        "$time"
        "$line_break"
        "$character"
      ];
      add_newline = true;

      palette = "tokyo_night";
      palettes.tokyo_night = {
        foreground = "#D8D8D8";
        background = "#1A1B26";
        current_line = "#333544";
        primary = "#292E42";
        box = "#363948";
        black = "#1d202f";
        blue = "#7aa2f7";
        cyan = "#7dcfff";
        green = "#9ece6a";
        magenta = "#bb9af7";
        orange = "#FF9E64";
        red = "#f7768e";
        white = "#a9b1d6";
        yellow = "#e0af68";
      };

      directory = {
        format = "[─](fg:current_line)[](fg:purple)[󰷏 ](fg:primary bg:purple)[](fg:purple bg:box)[ $read_only$truncation_symbol$path](fg:foreground bg:box)[](fg:box)";
        home_symbol = " ~/";
        truncation_symbol = " ";
        truncation_length = 2;
        read_only = "󱧵 ";
        read_only_style = "";
      };

      git_branch = {
        format = "[─](fg:current_line)[](fg:cyan)[$symbol](fg:primary bg:cyan)[](fg:cyan bg:box)[ $branch](fg:foreground bg:box)";
        symbol = " ";
      };

      git_status = {
        format = "[$all_status](fg:orange bg:box)[](fg:box)";
        conflicted = " =";
        up_to_date = "";
        untracked = " ?\${count}";
        stashed = " \\$";
        modified = " !\${count}";
        staged = " +";
        renamed = " »";
        deleted = " ✘";
        ahead = " ⇡\${count}";
        diverged = " ⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = " ⇣\${count}";
      };

      nodejs = {
        format = "[─](fg:current_line)[](fg:green)[$symbol](fg:primary bg:green)[](fg:green bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
        symbol = "󰎙 Node.js";
      };

      python = {
        format = "[─](fg:current_line)[](fg:green)[$symbol](fg:primary bg:green)[](fg:green bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
        symbol = " python";
      };

      golang = {
        format = "[─](fg:current_line)[](fg:red)[$symbol](fg:primary bg:red)[](fg:red bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
        symbol = "󰑮 Go";
      };

      fill = {
        symbol = "─";
        style = "fg:current_line";
      };

      cmd_duration = {
        min_time = 500;
        format = "[─](fg:current_line)[](fg:orange)[ ](fg:primary bg:orange)[](fg:orange bg:box)[ $duration ](fg:foreground bg:box)[](fg:box)";
      };

      kubernetes = {
        disabled = false;
        format = "[─](fg:current_line)[](fg:$style)[$symbol](fg:primary bg:$style)[](fg:$style bg:box)[ $context ](fg:foreground bg:box)[](fg:box)";
        symbol = " ";

        contexts = [
          {
            context_pattern = "*production*";
            style = "red";
            context_alias = "prod";
          }
          {
            context_pattern = "*sandbox*";
            style = "green";
            context_alias = "dev";
          }
        ];
      };

      time = {
        format = "[─](fg:current_line)[](fg:blue)[󰦖 ](fg:primary bg:blue)[](fg:blue bg:box)[ $time](fg:foreground bg:box)[](fg:box)";
        time_format = "%H:%M";
        disabled = true;
      };

      character = {
        format = ''[╰─$symbol](fg:current_line) '';
      };
    };
  };
}
