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
      terraformConfigPath = terranix.lib.terranixConfiguration {
        inherit system;
        modules = [
          ./terranix/config.nix
          ./terranix/containers.nix
        ];
      };
    in
    {
      # Generate Terraform config (copy from nix store)
      packages.${system} = {
        default = pkgs.runCommand "main.tf.json" {} ''
          cp ${terraformConfigPath} $out
        '';
      };

      # Dev shell with tools
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          terranix.packages.${system}.default
          terraform
          terragrunt
          jq
        ];
      };

      # App to generate config
      apps.${system}.generate = {
        type = "app";
        program = toString (pkgs.writeShellScript "generate" ''
          echo "Generating Terraform config..."
          nix build . --out-link result-tf
          cp result-tf main.tf.json
          chmod 644 main.tf.json
          rm -f result-tf
          echo "Done! Generated main.tf.json"
        '');
      };
    };
}
