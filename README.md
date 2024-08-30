# zed-move-aptos

Extension for Zed that adds Move on Aptos syntax highlighting


# Sync

```bash
id = "move"
name = "Move"
description = "Move on Aptos language support for Zed"
version = "0.0.2"
schema_version = 1
authors = ["simons <reggiesimons2cy@gmial.com>"]
repository = "https://github.com/caoyang2002/zed-move-aptos"

[language_servers.aptos-language-server]
name = "Move"
language = "move"

[grammars.move]
repository = "https://github.com/caoyang2002/tree-sitter-move-aptos"
commit = "efa97bcab7e605640e267fc944c89e2b7e3d4964"
```
