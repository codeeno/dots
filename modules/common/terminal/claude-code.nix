{
  programs.claude-code = {
    enable = true;
    settings = {
      theme = "dark";

      permissions = {
        allow = [
          # Web
          "WebFetch"
          "WebSearch"

          # Read
          "Read"

          # System
          "Lsof"

          # For network debugging
          "Route"
          "Netstat"
          "Ping"
          "Dig"
          "Nslookup"
          "Ifconfig"
          "Traceroute"
        ];
      };
    };
  };
}
