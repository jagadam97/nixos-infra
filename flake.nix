{
  description = "NixOS Infrastructure as Code with Terranix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    terranix = {
      url = "github:terranix/terranix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, terranix }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # Generate Terraform JSON from Terranix config
      terraformConfig = terranix.lib.terranixConfiguration {
        inherit system;
        modules = [
          ./terranix/config.nix
          ./terranix/containers.nix
        ];
      };
    in
    {
      # Generate Terraform config
      packages.${system} = {
        default = pkgs.writeTextFile {
          name = "main.tf.json";
          text = builtins.toJSON terraformConfig;
        };
      };

      # Dev shell with tools
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          terranix.packages.${system}.default
          terraform
          jq
        ];
      };

      # App to generate config
      apps.${system}.generate = {
        type = "app";
        program = toString (pkgs.writeShellScript "generate" ''
          echo "Generating Terraform config..."
          nix build . --out-link result
          cp -L result main.tf.json
          echo "Done! Generated main.tf.json"
        '');
      };
    };
}
