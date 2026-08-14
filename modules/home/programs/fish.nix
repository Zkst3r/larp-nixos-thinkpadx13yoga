{ ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fastfetch
    '';
    functions.fish_greeting = "";
  };
}
