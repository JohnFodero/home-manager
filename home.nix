{ config, pkgs, ... }:
{
	imports = [
    ./nixvim.nix
  ];
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
		ruff

	
		# cloud
		google-cloud-sdk

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    (pkgs.writeShellScriptBin "my-hello" ''
      echo "Hello, ${config.home.username}!"
    '')
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
    EDITOR = "nvim";
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
  

  programs.starship = {
    enable = true;
    enableZshIntegration = true; 
    settings =
          builtins.fromTOML (builtins.readFile ./.starship.toml);
  };

  programs.tmux = {
    enable = true;
    mouse = true;
		terminal = "tmux-256color";
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.vim-tmux-navigator
			tmuxPlugins.tmux-fzf
			{

				plugin = tmuxPlugins.gruvbox;
				extraConfig = ''
					set -g @tmux-gruvbox 'light'
					'';
			}
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
				# graphite
				gtm = "gt modify";
				gts = "gt submit";
        # nix
        hmu = "home-manager switch --flake ~/.config/home-manager/.";
				dep-dev = "thor deploy-pr dev $(gh pr view --json number | jq -r '.number')";
    };
    initExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
    # initExtraFirst = "";
    # initExtra = builtins.readFile ./zshrc;
  };
}
