# Flakes

These are some common `flake.nix` files that I find myself using in various development projects.
So far these are all dev shells using the internal `mkShell` command. 

## How to use
You can set up a shell with these by installing Nix (I use the Determinate Systems installer) and then running them as follows (in `fish` shell): 

```fish
> nix develop github:alexbielen/flakes/main?dir=shells/<environment_name>
```

Current environment names are:

- golang
- python
- rust
- typescript


