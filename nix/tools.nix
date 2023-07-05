{
  perSystem = {
    devshells.default.commands = [
      {
        category = "Tools";
        name = "check";
        help = "Check nix flake";
        command = "nix flake check";
      }
      {
        category = "Tools";
        name = "fmt";
        help = "Format the source tree";
        command = "nix fmt";
      }
    ];
  };
}
