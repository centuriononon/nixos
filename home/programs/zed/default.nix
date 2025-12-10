{ config, pkgs, lib, ... }:
{
  home.file.".config/zed/tasks.json".text = ''
  [
    {
      "label": "tv:find-files",
      "command": "zed \"$(tv files)\"",
      "hide": "always",
      "allow_concurrent_runs": false,
      "use_new_terminal": true,
    },
    {
      "label": "tv:find-in-files",
      "command": "zed \"$(tv text)\"",
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
      "kanagawa"

      # LSP
      "nix"
      "toml"
      "json"
      "yaml"
      "markdown"
      "git"
      "elixir"
      "make"
      "c"
      "cpp"
      "node"
      "typescript"
      "react"
      "html"
      "css"
      "docker"
      "packer"

      # Helpers
      "television" # fuzzy-search
    ];


    # Everything inside of these brackets are Zed options
    userSettings = {
      assistant = {
	enabled = true;
	version = "2";
	default_open_ai_model = null;

	# Provider options:
	# - zed.dev models (claude-3-5-sonnet-latest) requires GitHub connected
	# - anthropic models (claude-3-5-sonnet-latest, claude-3-haiku-latest, claude-3-opus-latest) requires API_KEY
	# - copilot_chat models (gpt-4o, gpt-4, gpt-3.5-turbo, o1-preview) requires GitHub connected
	# default_model = {
	#   provider = "zed.dev";
	#   model = "claude-3-5-sonnet-latest";
	# };

	# inline_alternatives = [
	#   {
	#     provider = "copilot_chat";
	#     model = "gpt-3.5-turbo";
	#   }
	# ];
      };

      hour_format = "hour24";
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
	toolbar = {
	  title = true;
	};
	working_directory = "current_project_directory";
      };

      lsp = {
	rust-analyzer = {
	  binary = {
	    path_lookup = true;
	  };
	};

	nix = {
	  binary = {
	    path_lookup = true;
	  };
	};

	elixir-ls = {
	  binary = {
	    path_lookup = true;
	  };
	  settings = {
	    dialyzerEnabled = true;
	  };
	};
      };

      languages = {
	"Elixir" = {
	  language_servers = [ "!lexical" "elixir-ls" "!next-ls" ];
	  format_on_save = {
	    external = {
	      command = "mix";
	      arguments = [ "format" "--stdin-filename" "{buffer_path}" "-" ];
	    };
	  };
	};

	"HEEX" = {
	  language_servers = [ "!lexical" "elixir-ls" "!next-ls" ];
	  format_on_save = {
	    external = {
	      command = "mix";
	      arguments = [ "format" "--stdin-filename" "{buffer_path}" "-" ];
	    };
	  };
	};

	"TypeScript" = {
		language_servers = [ "typescript-language-server" ];
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

	"C++" = {
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
	context = "Editor";
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

