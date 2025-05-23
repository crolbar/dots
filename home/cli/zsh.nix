{inputs', ...}: {
  home.packages = [inputs'.microfetch.packages.default];
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    history = {
      path = "$HOME/.config/zsh/zsh_history";
      ignorePatterns = ["t"];
    };

    autocd = true;

    initContent = "microfetch";
  };
}
