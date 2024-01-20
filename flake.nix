{
  description = "Nix Flake Templates";

  outputs = {...}: {
    templates = {
      basic = {
        path = ./basic;
        description = "A basic template";
      };
    };
  };
}
