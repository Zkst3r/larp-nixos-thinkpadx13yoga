{ ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      format = "$username$directory$git_branch$git_status$nix_shell$cmd_duration$line_break$character";

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol   = "[❯](bold red)";
      };

      directory = {
        style            = "bold blue";
        truncation_length = 3;
        truncate_to_repo  = true;
      };

      git_branch = {
        symbol = " ";
        style  = "bold mauve";
      };

      git_status = {
        style = "bold red";
      };

      nix_shell = {
        symbol = "❄ ";
        style  = "bold blue";
      };

      cmd_duration = {
        min_time = 2000;
        style    = "bold yellow";
      };
    };
  };
}
