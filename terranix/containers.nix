{ config, lib, pkgs, ... }:

let
  # Load versions from separate file
  versions = import ./versions.nix;

  # Auto-import all container files from the containers directory
  # Uses filename as the container name
  containerFiles = builtins.readDir ./containers;

  importContainer = name: _:
    let
      # Remove .nix extension to get container name
      containerName = lib.removeSuffix ".nix" name;
      containerConfig = import ./containers/${name};
      # Get version from versions.nix (required)
      containerVersion = versions.${containerName} or (throw "Version not found for container: ${containerName}");
    in
    import ./modules/container.nix (containerConfig // {
      name = containerName;
      version = containerVersion;
    });

  containerImports = lib.mapAttrsToList importContainer containerFiles;
in
{
  imports = containerImports;
}
