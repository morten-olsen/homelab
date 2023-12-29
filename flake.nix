{
  description = "server environment";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
  };

  outputs = { nixpkgs, ... }:
    let system = "x86_64-linux";
    in {
      devShell.${system} = let
        pkgs = import nixpkgs {
          inherit system;
        };
      in (({ pkgs, ... }:
        pkgs.mkShell {
          buildInputs = with pkgs; [
            kind
            kubectl
            kubernetes-helm
            istioctl
            argocd
            cloudflared
          ];

          shellHook = ''
            source ./scripts/env.sh
          '';

        }) { pkgs = pkgs; });
    };
}