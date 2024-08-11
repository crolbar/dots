{
  services.nfs.server = {
    enable = true;
    exports = ''
      /nas *(rw,sync,no_subtree_check)
    '';
  };
}
