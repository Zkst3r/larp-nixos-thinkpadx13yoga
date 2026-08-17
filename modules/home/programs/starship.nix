{ ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      # Верхняя строка: время | директория | git | nix | длительность | статус
      # Нижняя строка: prompt
      format = "$time$directory$git_branch$git_status$nix_shell$cmd_duration$status$line_break$character";

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol   = "[❯](bold red)";
      };

      time = {
        disabled = false;
        format   = "[$time]($style) ";
        style    = "bold dimmed white";
      };

      directory = {
        style             = "bold blue";
        truncation_length = 3;
        truncate_to_repo  = true;
      };

      git_branch = {
        symbol = " ";
        style  = "bold purple";
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

      status = {
        disabled = false;
        symbol   = "✗ ";
        style    = "bold red";
        format   = "[$symbol$status]($style) ";
      };

      # Версии языков — показываются автоматически в папке с проектом
      python = {
        symbol = " ";
        style  = "bold yellow";
      };

      nodejs = {
        symbol = " ";
        style  = "bold green";
      };

      rust = {
        symbol = " ";
        style  = "bold red";
      };

      java = {
        symbol = " ";
        style  = "bold red";
      };
    };
  };
}
