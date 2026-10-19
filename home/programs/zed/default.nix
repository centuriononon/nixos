{ config, pkgs, lib, ... }:
{
  home.file.".config/zed/tasks.json".text = ''
  [
    {
      "label": "tv:find-files",
      "command": "zed $(tv files)",
      "hide": "always",
      "allow_concurrent_runs": false,
      "use_new_terminal": true,
    },
    {
      "label": "tv:find-in-files",
      "command": "zed $(tv text)",
      "hide": "always",
      "allow_concurrent_runs": false,
      "use_new_terminal": true,
    }
  ]
  '';

  programs.zed-editor = {
    enable = true;

    # This populates the userSettings "auto_install_extensions"
    extensions = [
      # Themes
      "kanagawa-themes"

      # LSP
      "nix"
      "toml"
      "elixir"
      "sql"
      "latex"
      "make"
      "html"
      "dockerfile"
      "terraform"
    ];


    # Everything inside of these brackets are Zed options
    userSettings = {
      auto_update = false;

      terminal = {
	alternate_scroll = "off";
	blinking = "off";
	copy_on_select = false;
	dock = "bottom";
	detect_venv = {
	  on = {
	    directories = [ ".env" "env" ".venv" "venv" ];
	    activate_script = "default";
	  };
	};
	env = {
	  TERM = "kitty";
	};
	font_family = "FiraCode Nerd Font";
	font_features = null;
	font_size = null;
	line_height = "comfortable";
	option_as_meta = false;
	button = false;
	shell = "system";
	working_directory = "current_project_directory";
      };

      lsp = {
        expert = {
          settings = {
            workspaceSymbols = {
              minQueryLength = 2;
            };
          };
          binary = {
            arguments= ["--stdio"];
          };
        };
      };

      languages = {
	"Elixir" = {
	  language_servers = [ "expert" "!elixir-ls" "!next-ls" "!lexical" ];
	  format_on_save = "on";
	};

	"HEEX" = {
	  language_servers = [ "expert" "!elixir-ls" "!next-ls" "!lexical" ];
	  format_on_save = "on";
	};

        "EEX" = {
          language_servers = [ "expert" "!elixir-ls" "!next-ls" "!lexical" ];
	  format_on_save = "on";
        };

	"TypeScript" = {
          language_servers = [ "typescript-language-server" ];
	  format_on_save = "on";
	};

	"TSX" = {
          language_servers = [ "typescript-language-server" ];
	};

	"YAML" = {
          language_servers = [ "yaml-language-server" ];
	};

	"JSON" = {
          language_servers = [ "json-language-server" ];
	};

	"Dockerfile" = {
          language_servers = [ "dockerfile-language-server" ];
	};

	"C" = {
          language_servers = [ "clangd" ];
	};
      };

      vim_mode = true;

      # Tell Zed to use direnv and direnv can use a flake.nix environment
      load_direnv = "shell_hook";
      base_keymap = "VSCode";

      theme = lib.mkForce {
	mode = "dark";
	dark = "Kanagawa Dragon";
	light = "One Light";
      };

      show_whitespaces = "all";
      ui_font_size = lib.mkForce 16;
      buffer_font_size = lib.mkForce 16;
    };


    userKeymaps = [
      {
	context = "Editor && vim_mode == insert";
	bindings = {
	  "j k" = "vim::NormalBefore";
	};
      }

      {
	context = "Editor && vim_mode == normal";
	bindings = {
	  "g d" = "editor::GoToDefinition";
	  "g i" = "editor::GoToImplementation";
	  "g t" = "editor::GoToTypeDefinition";

	  "] d" = "editor::GoToDiagnostic";
	  "[ d" = "editor::GoToPreviousDiagnostic";

	  "] e" = "editor::GoToDiagnostic";
	  "[ e" = "editor::GoToPreviousDiagnostic";
	};
      }

      {
	context = "ProjectPanel && not_editing";
	bindings = {
	  "a" = "project_panel::NewFile";
	  "A" = "project_panel::NewDirectory";
	  "r" = "project_panel::Rename";
	  "d" = "project_panel::Delete";
	  "x" = "project_panel::Cut";
	  "c" = "project_panel::Copy";
	  "p" = "project_panel::Paste";
	  "q" = "workspace::ToggleRightDock";
	  "space e" = "workspace::ToggleRightDock";
	};
      }

      {
	context = "Editor && vim_mode == normal";
	bindings = {
	  "space space" = "project_panel::ToggleFocus";
	  "space q" = "workspace::ToggleLeftDock";
	  "g d" = "editor::GoToDefinition";
	  "space f" = [
	    "task::Spawn"
	    { task_name = "tv:find-in-files"; reveal_target = "center"; }
	  ];
	  "space t" = [
	    "task::Spawn"
	    { task_name = "tv:find-files"; reveal_target = "center"; }
	  ];
	};
      }
    ];
  };
}

