{
  ...
}:
{
  programs.nixvim = {
    enable = true;
    
    globals = {
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
		extraConfigVim = "";
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
          action = "<cmd>Telescope live_grep_args<CR>";
          key = "<leader>fa";
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
				# action = "<cmd>lua vim.plugins.conform()<cr>";
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

		colorschemes.vscode = {
			enable = true;
			settings = {
				italic_comments = true;
				underline_links = true;
			};
		};
    plugins.telescope = {
			enable = true;
			extensions = {
				live-grep-args = {
					enable = true;
					settings = {
						auto_quoting = true;
						mappings = {
							i = {
								"<leader>i" = {
									__raw = "require(\"telescope-live-grep-args.actions\").quote_prompt({ postfix = \" --iglob \" })";
								};
								"<leader>r" = {
									__raw = "require(\"telescope.actions\").to_fuzzy_refine";
								};
							};
						};
						theme = "dropdown";
					};
				};
			};
		};
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
	plugins.comment = {
			enable = true;
			settings = {
				opleader.line = "<C-b>";
				toggler.line = "<C-b>";
			};
		};
		plugins.todo-comments = {
			enable = true;
			settings = {
				keywords = {
					TODO = {
					  color = "warning";
					  icon = " ";
				  };
				};
				highlight = {
					pattern = ".*<(KEYWORDS)\\s*";
				};
			};
		};
    # plugins.conform-nvim = {
    #   enable = true;
    #   settings = {
    #     formatters_by_ft = {
    #       css = [ "prettier" ];
    # 	javascript = [ "prettier" ];
    #       html = [ "prettier" ];
    #       json = [ "prettier" ];
    #       lua = [ "stylua" ];
    #       markdown = [ "prettier" ];
    # 	nix = [ "alejandra" "nixfmt" "nixpkgs_fmt" ];
    #       python = [ "isort" "black" ];
    #       ruby = [ "rubyfmt" ];
    #       terraform = [ "tofu_fmt" ];
    #       tf = [ "tofu_fmt" ];
    #       yaml = [ "yamlfmt" ];
    #     };
    # format_on_save = {
    #     	lsp_fallback = true;
    #       async = false;
    #       timeout_ms = 1000;
    #     };
    #   };
    # };
		plugins.lsp-format = {
        enable = true;
        lspServersToEnable = "all";
      };
    plugins.lsp = {
      enable = true;
      servers = {
      	dockerls.enable = true;
	      gopls.enable = true;
        nil_ls = {
					enable = true;
				};
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
}
