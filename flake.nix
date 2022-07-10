{
  description = "fill out password forms in qutebrowser with bitwarden";
    
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
  
  outputs = {self, nixpkgs, ... }: {

    packages."x86_64-linux".qute-bitwarden = nixpkgs.legacyPackages.x86_64-linux.python3Packages.buildPythonApplication {
      pname = "qute-bitwarden";
      version = "0.1";

      src = ./.;


      propagatedBuildInputs = [
        nixpkgs.legacyPackages.x86_64-linux.python3Packages.tldextract
        nixpkgs.legacyPackages.x86_64-linux.keyutils
        nixpkgs.legacyPackages.x86_64-linux.fuzzel
        nixpkgs.legacyPackages.x86_64-linux.pinentry_qt5
      ];
    };
    
    packages."x86_64-linux".default = self.packages."x86_64-linux".qute-bitwarden;
    
    apps."x86_64-linux".qute-bitwarden = {
      type = "app";
      program = "${self.packages.x86_64-linux.qute-bitwarden}/bin/qute-bitwarden";
    };
    apps."x86_64-linux".default = self.apps."x86_64-linux".qute-bitwarden;

    devShell."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".mkShell {
      buildInputs = [
        nixpkgs.legacyPackages.x86_64-linux.python3
        nixpkgs.legacyPackages.x86_64-linux.python3Packages.tldextract
        nixpkgs.legacyPackages.x86_64-linux.keyutils
        nixpkgs.legacyPackages.x86_64-linux.fuzzel
        nixpkgs.legacyPackages.x86_64-linux.pinentry_qt5
      ];
    };
  

  };
  
}
