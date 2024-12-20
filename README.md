# zed-move-aptos

Extension for Zed that adds Move on Aptos syntax highlighting

## zed plugin

https://github.com/caoyang2002/zed-move-aptos

## tree sitter

https://github.com/caoyang2002/tree-sitter-move-aptos



# Other

> I used the code for the following project
>
> I am very grateful to the code and developers of the following projects, as they have helped me identify a multitude of issues.

## zed plugin (sui)

https://github.com/Tzal3x/move-zed-extension (sui move)

## tree-sitter-move (sui)

https://github.com/tzakian/tree-sitter-move


# Docs

zed: https://zed.dev/docs/extensions/languages#bracket-matching

tree sitter: https://tree-sitter.github.io/tree-sitter/playground#about


# Unusable

> [!NOTE]
> Due to the fact that `https://github.com/aptos-labs/tree-sitter-move-on-aptos` cannot be directly compiled into `wasm` in Zed, it is not recommended for use. Please switch to: `https://github.com/tzakian/tree-sitter-move` (sui) or `https://github.com/caoyang2002/tree-sitter-move-aptos` (aptos).
>
> https://github.com/aptos-labs/tree-sitter-move-on-aptos
>
> ```bash
> # first time
> tree-sitter init-config
> #
> pnpm install
> pnpm run format
> tree-sitter generate
>
> tree-sitter build --wasm
> ```
