{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # Внешний вид
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "mocha"; # mocha (dark), latte (light)
        transparent_background = false;
      };
    };

    # Основные настройки
    opts = {
      number = true;         # Номера строк
      relativenumber = true; # Относительные номера

      tabstop = 2;           # Размер таба
      shiftwidth = 2;
      expandtab = true;      # Пробелы вместо табов

      smartindent = true;
      wrap = false;

      swapfile = false;
      backup = false;

      hlsearch = false;      # Не подсвечивать поиск после
      incsearch = true;      # Инкрементальный поиск

      termguicolors = true;
      scrolloff = 8;         # Отступ от края при скролле
      signcolumn = "yes";    # Колонка для git/lsp символов

      updatetime = 50;
      timeoutlen = 300;
    };

    # Глобальные переменные
    globals = {
      mapleader = " ";       # Leader key - пробел
      maplocalleader = " ";
    };

    plugins = {
      # Файловый браузер
      neo-tree = {
        enable = true;
        settings = {
          close_if_last_window = true;
          window.width = 30;
        };
      };

      # LSP (автодополнение, go-to-definition, ошибки)
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;           # Nix
          pyright.enable = true;        # Python
          lua_ls.enable = true;         # Lua (исправлено: lua_ls вместо lua-ls)
          bashls.enable = true;         # Bash
        };

        keymaps = {
          diagnostic = {
            "<leader>j" = "goto_next";
            "<leader>k" = "goto_prev";
          };
          lspBuf = {
            "gd" = "definition";
            "gD" = "declaration";
            "gi" = "implementation";
            "gr" = "references";
            "K" = "hover";
            "<leader>ca" = "code_action";
            "<leader>rn" = "rename";
          };
        };
      };

      # Автодополнение
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };

      # Подсветка синтаксиса (treesitter)
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      # Fuzzy finder (поиск файлов/текста)
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
        };
      };

      # Показывает доступные хоткеи
      which-key = {
        enable = true;
      };

      # Git интеграция
      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "│";
          change.text = "│";
          delete.text = "_";
          topdelete.text = "‾";
          changedelete.text = "~";
          untracked.text = "┆";
        };
      };

      # Комментирование (gcc для строки, gc в visual mode)
      comment.enable = true;

      # Автопары скобок
      nvim-autopairs.enable = true;

      # Красивый статусбар
      lualine = {
        enable = true;
        settings = {
          options.theme = "catppuccin";
        };
      };

      # Отступы с линиями
      indent-blankline = {
        enable = true;
        settings = {
          scope.enabled = true;
        };
      };

      # Подсветка TODO, FIXME, etc
      todo-comments.enable = true;
    };

    # Дополнительные хоткеи
    keymaps = [
      # Файловый браузер
      {
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options.desc = "Toggle file tree";
      }

      # Сохранить файл
      {
        key = "<leader>w";
        action = "<cmd>w<cr>";
        options.desc = "Save file";
      }

      # Перемещение выделенных строк
      {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
        options.desc = "Move line down";
      }
      {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
        options.desc = "Move line up";
      }

      # Навигация между окнами
      {
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Go to left window";
      }
      {
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Go to lower window";
      }
      {
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Go to upper window";
      }
      {
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Go to right window";
      }

      # Сброс подсветки поиска
      {
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR>";
        options.desc = "Clear search highlight";
      }
    ];

    # Дополнительные пакеты для LSP и инструментов
    extraPackages = with pkgs; [
      # LSP серверы
      nil              # Nix LSP (альтернатива nixd)
      pyright
      lua-language-server
      bash-language-server

      # Форматтеры
      nixfmt           # Nix formatter
      black            # Python
      stylua           # Lua

      # Утилиты
      ripgrep          # Для telescope live_grep
      fd               # Для telescope find_files
      tree-sitter
    ];
  };
}
