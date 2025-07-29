{
  description = "Top level flake for the dev shell flake";

  outputs =
    { self }:
    {
      templates = {
        golang = {
          path = ./shells/golang;
          description = "A shell for a Golang project";
          welcomeText = ''
            Welcome to the Golang dev shell!
            This is a shell for a Golang project.
          '';
        };
        rust = {
          path = ./shells/rust;
          description = "A shell for a Rust project";
          welcomeText = ''
            Welcome to the Rust dev shell!
            This is a shell for a Rust project.
          '';
        };
        typescript = {
          path = ./shells/typescript;
          description = "A shell for a Typescript project";
          welcomeText = ''
            Welcome to the Typescript dev shell!
            This is a shell for a Typescript project.
          '';
        };
        python = {
          path = ./shells/python;
          description = "A shell for a Python project";
          welcomeText = ''
            Welcome to the Python dev shell!
            This is a shell for a Python project.
          '';
        };
      };
    };
}
