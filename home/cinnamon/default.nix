{
  home.file = {
    compress-action = {
      source = ./actions/compress.nemo_action;
      target = ".local/share/nemo/actions/compress.nemo_action";
    };

    extract-action = {
      source = ./actions/extract.nemo_action;
      target = ".local/share/nemo/actions/extract.nemo_action";
    };
  };
}
