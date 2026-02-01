{
  programs = {
    git = {
      enable = true;
      config = {
        core.autocrlf = "input";
        merge.autoStash = true;
        pull.autoStash = true;
        # pull.rebase = true;
        rebase.autoStash = true;
        safe.directory = "*";
      };
    };
  };
}
