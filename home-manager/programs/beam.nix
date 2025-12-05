{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    beam.packages.erlang_28.erlang
    beam.packages.erlang_28.elixir_1_18
  ];
}
