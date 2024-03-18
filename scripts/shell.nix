with import <nixpkgs> {};

(python3.buildEnv.override {
  extraLibs = with python3Packages; [
    numpy
    pandas
    matplotlib
    pygame
  ];
}).env

