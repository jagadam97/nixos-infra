{
  description = "NixOS Infrastructure as Code with Terranix and Terragrunt";

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

      # Helper to generate Terraform JSON from Terranix config
      mkTerraformConfig = environment:
        terranix.lib.terranixConfiguration {
          inherit system;
          modules = [
            ./terranix/config.nix
            ./terranix/environments/${environment}.nix
          ];
        };
    in
    {
      # Generate Terraform configs for each environment
      packages.${system} = {
        dev = mkTerraformConfig "dev";
        prod = mkTerraformConfig "prod";

        # Default package generates all configs
        default = pkgs.symlinkJoin {
          name = "terraform-configs";
          paths = [
            (pkgs.writeTextDir "environments/dev/main.tf.json" (builtins.toJSON (mkTerraformConfig "dev")))
            (pkgs.writeTextDir "environments/prod/main.tf.json" (builtins.toJSON (mkTerraformConfig "prod")))
          ];
        };
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

      # Apps for convenience
      apps.${system} = {
        generate = {
          type = "app";
          program = toString (pkgs.writeShellScript "generate" ''
            echo "Generating Terraform configs..."
            mkdir -p environments/dev environments/prod

            nix build .#dev --out-link generated-dev
            cp -L generated-dev/* environments/dev/main.tf.json 2>/dev/null || true

            nix build .#prod --out-link generated-prod
            cp -L generated-prod/* environments/prod/main.tf.json 2>/dev/null || true

            echo "Done! Generated configs in environments/*/"
          '');
        };
      };
    };
}
