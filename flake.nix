{
  description = "fill out password forms in qutebrowser with bitwarden";
    
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
  
  outputs = {self, nixpkgs, ... }: {

    packages."x86_64-linux".qute-bitwarden = nixpkgs.legacyPackages.x86_64-linux.python3Packages.buildPythonApplication {
      pname = "qute-bitwarden";
      version = "0.1";

      src = ./.;

      propagatedBuildInputs = [ nixpkgs.legacyPackages.x86_64-linux.python3Packages.tldextract ];
    };
    
    defaultPackage."x86_64-linux" = self.packages.x86_64-linux.qute-bitwarden;
    
    defaultApp."x86_64-linux" = {
      type = "app";
      program = "${self.packages.x86_64-linux.qute-bitwarden}/bin/qute-bitwarden";
    };

  };
  
}
