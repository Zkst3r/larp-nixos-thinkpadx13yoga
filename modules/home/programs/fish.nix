{ ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fastfetch
    '';
    functions.fish_greeting = "";
    shellInit = ''
      function fish_prompt
          set_color blue
          echo -n (prompt_pwd)
          set_color normal
          echo -n ' > '
      end
    '';
  };
}
