with import <pkgs-stable> {};

(python3.buildEnv.override {
  extraLibs = with python311Packages; [
    pygame
  ];
}).env

