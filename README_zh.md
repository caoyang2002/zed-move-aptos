# zed-move-aptos

Extension for Zed that adds Move on Aptos syntax highlighting

# Zed Blog

关于拓展的文章：[Zed 扩展的生命周期：Rust、WIT、Wasm](https://zed.dev/blog/zed-decoded-extensions)

API 文档：[zed_extension_api](https://docs.rs/zed_extension_api/latest/zed_extension_api/index.html)

参考：

- [rust-analyzer](https://github.com/rust-lang/rust-analyzer)
- [aptos-move-analyzer](https://github.com/movebit/aptos-move-analyzer)
- [pylyzer](https://github.com/mtshiba/pylyzer)
- [example](https://github.com/Tecvan-fe/vscode-lsp-sample)

1. 克隆仓库

```bash
git clone https://github.com/caoyang2002/zed-move-aptos.git
cd zed-move-aptos
```

3. 格式化代码
4. 生成语法文件
5. 编译为 wasm
6. 安装扩展

6. 提 PR

# TIP

Sorry, this extension only implements syntax highlighting and does not implement code completion, as there are no open-source solutions available for Aptos Move code completion.

Sorry again.

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


# 错误

检查日志

```bash
cat ~/Library/Logs/Zed/Zed.log
```

1. `Error: failed to install dev extension`

```bash
# Mac OS:
cd ~/Library/Application\ Support/Zed/extensions

# Linux
cd ~/.local/share/zed/extensions
```


1. delete `/target` `extension.wasm` `/grammars`
2. restart
3. reinstall
