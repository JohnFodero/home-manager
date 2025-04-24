{ config, pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "johnfodero";
  home.homeDirectory = "/Users/johnfodero";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
  
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # utils
    bat
    tree
    htop
    just
    
    # containers
    qemu
    minikube 

    # apple-specific
    apple-sdk
    
    # source control
    graphite-cli
    gh
    
    # lang
    uv
    rustup
#    cargo
#    rustc
	

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/johnfodero/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      dialect = "us";
      style = "compact";
      inline_height = 15;
      keymap_mode = "vim-normal";
      enter_accept = false;
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = false;
    nix-direnv.enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.go.enable = true;
  
  programs.git = {
    enable = true;
    diff-so-fancy.enable = true;
    includes = [
      { path = "~/.gitconfig"; }
    ];
    aliases = {};
    extraConfig = {
      pull.ff = "only";
    };
  };
  
  programs.nixvim = {
    enable = true;
    
    globals = {
      # Set <space> as the leader key
      # See `:help mapleader`
      mapleader = " ";
      maplocalleader = " ";

      have_nerd_font = true;
    };
    opts = {
      relativenumber = true;
      showmode = false;
      tabstop = 2;
      shiftwidth = 2;
      ignorecase = true;
      smartcase = true;

    };
    keymaps = [
    	#### telescope ####
        {
          action = "<cmd>Telescope find_files<CR>";
          key = "<leader>ff";
        }
        {
          action = "<cmd>Telescope live_grep<CR>";
          key = "<leader>fg";
        }
        {
          action = "<cmd>Telescope buffers<CR>";
          key = "<leader>fb";
        }
        {
          action = "<cmd>Telescope help_tags<CR>";
          key = "<leader>fh";
        }
				{
					action = "<cmd>lua vim.lsp.buf.hover()<cr>";
					key = "<leader>K";
				}
				{
					action = "<cmd>lua vim.lsp.buf.definition()<cr>";
					key = "<leader>gd";
				}
				{
					action = "<cmd>lua vim.lsp.buf.declaration()<cr>";
					key = "<leader>gD";
				}
				{
					action = "<cmd>lua vim.lsp.buf.implementation()<cr>";
					key = "<leader>gi";
				}
				{
					action = "<cmd>lua vim.lsp.buf.type_definition()<cr>";
					key = "<leader>go";
				}
				{
					action = "<cmd>lua vim.lsp.buf.references()<cr>";
					key = "<leader>gr";
				}
				{
					action = "<cmd>lua vim.lsp.buf.signature_help()<cr>";
					key = "<leader>gs";
				}
				{
					action = "<cmd>lua vim.lsp.buf.rename()<cr>";
					key = "<leader>rn";
				}
				{
				  action = "<cmd>lua vim.lsp.buf.format({async = true})<cr>";
				# action = "<cmd>lua conform.format({lsp_fallback=true, async=true, timeout_ms=1000})<cr>";
					key = "<leader>fm";
				}
				{
					action = "<cmd>lua vim.lsp.buf.code_action()<cr>";
					key = "<leader>ga";
				}
				#### HARPOON ####
				# does not work yet...
				{
					action.__raw = "function() require'harpoon':list():add() end";
					key = "<leader>a";
					mode = "n";
				}
				{
					action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
					key = "<C-e>";
					mode = "n";
				}
				{
					action.__raw = "function() require'harpoon':list():select(1) end";
					key = "<C-h>";
					mode = "n";
				}
				{
					action.__raw = "function() require'harpoon':list():select(2) end";
					key = "<C-j>";
					mode = "n";
				}
    ];

    colorschemes.catppuccin.enable = true;
	
    plugins.telescope.enable = true;
		plugins.harpoon = {
			enable = true;
			enableTelescope = true;
		};

    plugins.treesitter = {
          enable = true;
          folding = false;
          settings.indent.enable = true;
        };
    plugins.web-devicons.enable = true;
    plugins.which-key = {
          enable = true;
          settings.preset = "helix";
        };
    plugins.copilot-vim.enable = false;
    plugins.copilot-chat.enable = true;
    plugins.lualine.enable = true;
    
    plugins.gitblame.enable = true;
    plugins.gitsigns = {
      enable = true;
      settings = {
        signs = {
          add = {text = "+";};
          change = {text = "~";};
          delete = {text = "_";};
          topdelete = {text = "‾";};
          changedelete = {text = "~";};
        };
      };
    };
	plugins.startify = {
    enable = true;

    settings = {
      custom_header = [
        ""
        "     ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
        "     ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
        "     ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
        "     ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
        "     ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
        "     ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
      ];

      # When opening a file or bookmark, change to its directory.
      change_to_dir = false;

      # By default, the fortune header uses ASCII characters, because they work for everyone.
      # If you set this option to 1 and your 'encoding' is "utf-8", Unicode box-drawing characters will
      # be used instead.
      use_unicode = true;

      lists = [ { type = "dir"; } ];
      files_number = 30;

      skiplist = [
        "flake.lock"
      ];
    };
  };
    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          css = [ "prettier" ];
          html = [ "prettier" ];
          json = [ "prettier" ];
          lua = [ "stylua" ];
          markdown = [ "prettier" ];
          nix = [ "alejandra" ];
          python = [ "black" ];
          ruby = [ "rubyfmt" ];
          terraform = [ "tofu_fmt" ];
          tf = [ "tofu_fmt" ];
          yaml = [ "yamlfmt" ];
        };
				format_on_save = {
        	lsp_fallback = true;
          async = false;
          timeout_ms = 500;
        };
      };
    };
    plugins.lsp = {
      enable = true;
      servers = {
      	dockerls.enable = true;
	gopls.enable = true;
        nil_ls.enable = true;
        ruff.enable = true;
	rust_analyzer = {
	  enable = true;
	  installCargo = false;
	  installRustc = false;
	};
	terraform_lsp.enable = true;
      };
    };
    plugins.nvim-autopairs.enable = true;
    plugins.cmp = {
      enable = true;

      settings = {
        snippet = {
          expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
        };

        completion = {
          completeopt = "menu,menuone,noinsert";
        };

        # For an understanding of why these mappings were
        # chosen, you will need to read `:help ins-completion`
        #
        # No, but seriously, Please read `:help ins-completion`, it is really good!
        mapping = {
          # Select the [n]ext item
          "<C-n>" = "cmp.mapping.select_next_item()";
          # Select the [p]revious item
          "<C-p>" = "cmp.mapping.select_prev_item()";
          # Scroll the documentation window [b]ack / [f]orward
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          # Accept ([y]es) the completion.
          #  This will auto-import if your LSP supports it.
          #  This will expand snippets if the LSP sent a snippet.
          "<C-y>" = "cmp.mapping.confirm { select = true }";
          # If you prefer more traditional completion keymaps,
          # you can uncomment the following lines.
          # "<CR>" = "cmp.mapping.confirm { select = true }";
          # "<Tab>" = "cmp.mapping.select_next_item()";
          # "<S-Tab>" = "cmp.mapping.select_prev_item()";

          # Manually trigger a completion from nvim-cmp.
          #  Generally you don't need this, because nvim-cmp will display
          #  completions whenever it has completion options available.
          "<C-Space>" = "cmp.mapping.complete {}";

          # Think of <c-l> as moving to the right of your snippet expansion.
          #  So if you have a snippet that's like:
          #  function $name($args)
          #    $body
          #  end
          #
          # <c-l> will move you to the right of the expansion locations.
          # <c-h> is similar, except moving you backwards.
          "<C-l>" = ''
            cmp.mapping(function()
              if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              end
            end, { 'i', 's' })
          '';
          "<C-h>" = ''
            cmp.mapping(function()
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              end
            end, { 'i', 's' })
          '';

          # For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          #    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        };

        # Dependencies
        #
        # WARNING: If plugins.cmp.autoEnableSources Nixivm will automatically enable the
        # corresponding source plugins. This will work only when this option is set to a list.
        # If you use a raw lua string, you will need to explicitly enable the relevant source
        # plugins in your nixvim configuration.
        sources = [
          {
            name = "luasnip";
          }
          {
            name = "nvim_lsp";
          }
          {
            name = "path";
          }
        ];
      };
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true; 
    settings =
          builtins.fromTOML (builtins.readFile ./.starship.toml);
  };

  programs.tmux = {
    enable = true;
    mouse = true;
  
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.catppuccin
      tmuxPlugins.vim-tmux-navigator
    ];
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = false;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    shellAliases = {
        # git	
        ga = "git add -p";
	gs = "git status";
	gb = "git branch --sort=-committerdate | head -n 5";
        # nix
        hmu = "home-manager switch --flake ~/.config/home-manager/.";
    };
    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
    # initExtraFirst = "";
    # initExtra = builtins.readFile ./zshrc;
  };
}
