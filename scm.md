# [Language Extensions 语言扩展](https://zed.dev/docs/extensions/languages#language-extensions)

Zed 中的语言支持有几个组成部分：

- 语言元数据和配置
- 语法
- 查询
- 语言服务器

## [语言元数据](https://zed.dev/docs/extensions/languages#language-metadata)

Zed支持的每种语言都必须在扩展的`languages`目录下的一个目录中定义。

此配置文件必须包含一个名为`config.toml的`文件，该文件具有以下结构：

```toml
name = "My Language"
grammar = "my-language"
path_suffixes = ["myl"]
line_comments = ["# "]
```

- `name`（必需）是将显示在Select Language选项卡中的人类可读名称。
- `grammar`（必需）是语法的名称。语法是单独注册的，如下所述。
- `path_suffixes`是应该与该语言相关联的文件后缀的数组。与设置中的`file_types`不同，它不支持glob模式。
- `line_comments`是一个字符串数组，用于标识语言中的行注释。这用于`编辑器：：ToggleComments`keybind：`<kbd class=“keybinding”>| </kbd>`用于切换代码行。
- `tab_size`定义该语言使用的缩进/制表符大小（默认值为`4`）。
- `hard_tabs`是否使用制表符（`true`）或空格（`false`，默认值）。
- `first_line_pattern`是一个正则表达式，除了`path_suffixes`（上面）或`file_types之外，还`可以用来匹配应该使用这种语言的文件。例如，Zed通过匹配脚本第一行中的[shebangs行](https://github.com/zed-industries/zed/blob/main/crates/languages/src/bash/config.toml)来识别Shell脚本。

## [语法](https://zed.dev/docs/extensions/languages#grammar)

Zed 使用[Tree-Sitter](https://tree-sitter.github.io/)解析库来提供内置的特定于语言的特性。许多语言都有可用的语法，您也可以[开发自己的语法](https://tree-sitter.github.io/tree-sitter/creating-parsers#writing-the-grammar)。Zed功能的不断增长的列表是通过使用Tree-sitter查询在语法树上进行模式匹配来构建的。如上所述，在扩展中定义的每种语言都必须指定用于解析的Tree-Sitter语法的名称。这些语法然后在扩展的`扩展名.toml`文件中单独注册，如下所示：

```toml
[grammars.gleam]
repository = "https://github.com/gleam-lang/tree-sitter-gleam"
rev = "58b7cac8fc14c92b0677c542610d8738c373fa81"
```

`repository`字段必须指定加载Tree-sitter语法的仓库，`rev`字段必须包含要使用的Git版本号，比如Git commit的SHA。一个扩展可以通过引用多个tree-sitter存储库来提供多种语法。

## [Tree-sitter Queries 树栖鸟](https://zed.dev/docs/extensions/languages#tree-sitter-queries)

Zed uses the syntax tree produced by the [Tree-sitter](https://tree-sitter.github.io/) query language to implement several features:
Zed使用[Tree-sitter](https://tree-sitter.github.io/)查询语言生成的语法树来实现几个功能：

- 语法高亮
- 括号匹配
- 代码大纲/结构
- 自动缩进
- 代码注入
- 超控
- 文本编辑
- 可运行代码检测
- 选择类、函数等。

下面的部分详细介绍了[树保姆查询](https://tree-sitter.github.io/tree-sitter/using-parsers#query-syntax)如何在Zed中启用这些功能，使用[JSON语法](https://www.json.org/json-en.html)作为指导示例。

### [语法高亮](https://zed.dev/docs/extensions/languages#syntax-highlighting)

在Tree-sitter中，`highlights.scm`文件为特定语法定义语法突出显示规则。

下面是一个JSON的`highlights.scm`示例：

```scheme
(string) @string

(pair
  key: (string) @property.json_key)

(number) @number
```

此查询将字符串、对象键和数字标记为突出显示。以下是主题支持的捕获的完整列表：

| Capture 捕获             | Description 描述                                             |
| :----------------------- | :----------------------------------------------------------- |
| @attribute               | Captures attributes 捕获属性                                 |
| @boolean                 | Captures boolean values 捕获布尔值                           |
| @comment                 | Captures comments 捕获评论                                   |
| @comment.doc             | Captures documentation comments 捕获文档注释                 |
| @constant                | Captures constants 捕获常量                                  |
| @constructor             | Captures constructors 捕获建筑商                             |
| @embedded                | Captures embedded content 捕获嵌入式内容                     |
| @emphasis                | Captures emphasized text 捕获强调文本                        |
| @emphasis.strong         | Captures strongly emphasized text 捕获强调文本               |
| @enum                    | Captures enumerations 捕获枚举                               |
| @function                | Captures functions 捕获功能                                  |
| @hint                    | Captures hints 捕捉提示                                      |
| @keyword                 | Captures keywords 捕获关键字                                 |
| @label                   | Captures labels 捕获标签                                     |
| @link_text               | Captures link text 捕获链接文本                              |
| @link_uri                | Captures link URIs 捕获链接URI                               |
| @number                  | Captures numeric values 捕获数值                             |
| @operator                | Captures operators 捕获操作员                                |
| @predictive              | Captures predictive text 捕获预测文本                        |
| @preproc                 | Captures preprocessor directives 捕获预处理器指令            |
| @primary                 | Captures primary elements 捕获主要元素                       |
| @property                | Captures properties 捕获属性                                 |
| @punctuation             | Captures punctuation 捕获标点符号                            |
| @punctuation.bracket     | Captures brackets 捕获括号                                   |
| @punctuation.delimiter   | Captures delimiters 捕获分隔符                               |
| @punctuation.list_marker | Captures list markers 捕获列表标记                           |
| @punctuation.special     | Captures special punctuation 捕获特殊标点符号                |
| @string                  | Captures string literals 捕获字符串文字                      |
| @string.escape           | Captures escaped characters in strings 捕获字符串中的转义字符 |
| @string.regex            | Captures regular expressions 捕获正则表达式                  |
| @string.special          | Captures special strings 捕捉特殊字符串                      |
| @string.special.symbol   | Captures special symbols 捕获特殊符号                        |
| @tag                     | Captures tags 捕获标签                                       |
| @tag.doctype             | Captures doctypes (e.g., in HTML) 捕获文档类型（例如，HTML） |
| @text.literal            | Captures literal text 捕获文本                               |
| @title                   | Captures titles 捕获标题                                     |
| @type                    | Captures types 捕获类型                                      |
| @variable                | Captures variables 捕获变量                                  |
| @variable.special        | Captures special variables 捕获特殊变量                      |
| @variant                 | Captures variants 捕获变体                                   |

### [Bracket matching 括号匹配](https://zed.dev/docs/extensions/languages#bracket-matching)

The `brackets.scm` file defines matching brackets.
`scm`文件定义匹配的方括号。

Here's an example from a `brackets.scm` file for JSON:

```scheme
("[" @open "]" @close)
("{" @open "}" @close)
("\"" @open "\"" @close)
```

This query identifies opening and closing brackets, braces, and quotation marks.

| Capture | Description                                   |
| :------ | :-------------------------------------------- |
| @open   | Captures opening brackets, braces, and quotes |
| @close  | Captures closing brackets, braces, and quotes |

### [Code outline/structure](https://zed.dev/docs/extensions/languages#code-outlinestructure)

The `outline.scm` file defines the structure for the code outline.

Here's an example from an `outline.scm` file for JSON:

```scheme
(pair
  key: (string (string_content) @name)) @item
```

This query captures object keys for the outline structure.

| Capture        | Description                                                  |
| :------------- | :----------------------------------------------------------- |
| @name          | Captures the content of object keys                          |
| @item          | Captures the entire key-value pair                           |
| @context       | Captures elements that provide context for the outline item  |
| @context.extra | Captures additional contextual information for the outline item |
| @annotation    | Captures nodes that annotate outline item (doc comments, attributes, decorators)[1](https://zed.dev/docs/extensions/languages#1) |

1

These annotations are used by Assistant when generating code modification steps.

### [Auto-indentation](https://zed.dev/docs/extensions/languages#auto-indentation)

The `indents.scm` file defines indentation rules.

Here's an example from an `indents.scm` file for JSON:

```scheme
(array "]" @end) @indent
(object "}" @end) @indent
```

This query marks the end of arrays and objects for indentation purposes.

| Capture | Description                                        |
| :------ | :------------------------------------------------- |
| @end    | Captures closing brackets and braces               |
| @indent | Captures entire arrays and objects for indentation |

### [Code injections](https://zed.dev/docs/extensions/languages#code-injections)

The `injections.scm` file defines rules for embedding one language within another, such as code blocks in Markdown or SQL queries in Python strings.

Here's an example from an `injections.scm` file for Markdown:

```scheme
(fenced_code_block
  (info_string
    (language) @language)
  (code_fence_content) @content)

((inline) @content
 (#set! "language" "markdown-inline"))
```

This query identifies fenced code blocks, capturing the language specified in the info string and the content within the block. It also captures inline content and sets its language to "markdown-inline".

| Capture   | Description                                                |
| :-------- | :--------------------------------------------------------- |
| @language | Captures the language identifier for a code block          |
| @content  | Captures the content to be treated as a different language |

Note that we couldn't use JSON as an example here because it doesn't support language injections.

### [Syntax overrides](https://zed.dev/docs/extensions/languages#syntax-overrides)

The `overrides.scm` file defines syntactic *scopes* that can be used to override certain editor settings within specific language constructs.

For example, there is a language-specific setting called `word_characters` that controls which non-alphabetic characters are considered part of a word, for filtering autocomplete suggestions. In JavaScript, "$" and "#" are considered word characters. But when your cursor is within a *string* in JavaScript, "-" is *also* considered a word character. To achieve this, the JavaScript `overrides.scm` file contains the following pattern:

```scheme
[
  (string)
  (template_string)
] @string
```

And the JavaScript `config.toml` contains this setting:

```toml
word_characters = ["#", "$"]

[overrides.string]
word_characters = ["-"]
```

You can also disable certain auto-closing brackets in a specific scope. For example, to prevent auto-closing `'` within strings, you could put the following in the JavaScript `config.toml`:

```toml
brackets = [
  { start = "'", end = "'", close = true, newline = false, not_in = ["string"] },
  # other pairs...
]
```

#### [Range inclusivity](https://zed.dev/docs/extensions/languages#range-inclusivity)

By default, the ranges defined in `overrides.scm` are *exclusive*. So in the case above, if you cursor was *outside* the quotation marks delimiting the string, the `string` scope would not take effect. Sometimes, you may want to make the range *inclusive*. You can do this by adding the `.inclusive` suffix to the capture name in the query.

For example, in JavaScript, we also disable auto-closing of single quotes within comments. And the comment scope must extend all the way to the newline after a line comment. To achieve this, the JavaScript `overrides.scm` contains the following pattern:

```scheme
(comment) @comment.inclusive
```

### [Text objects](https://zed.dev/docs/extensions/languages#text-objects)

The `textobjects.scm` file defines rules for navigating by text objects. This was added in Zed v0.165 and is currently used only in Vim mode.

Vim provides two levels of granularity for navigating around files. Section-by-section with `[]` etc., and method-by-method with `]m` etc. Even languages that don't support functions and classes can work well by defining similar concepts. For example CSS defines a rule-set as a method, and a media-query as a class.

For languages with closures, these typically should not count as functions in Zed. This is best-effort however, as languages like Javascript do not syntactically differentiate syntactically between closures and top-level function declarations.

For languages with declarations like C, provide queries that match `@class.around` or `@function.around`. The `if` and `ic` text objects will default to these if there is no inside.

If you are not sure what to put in textobjects.scm, both [nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects), and the [Helix editor](https://github.com/helix-editor/helix) have queries for many languages. You can refer to the Zed [built-in languages](https://github.com/zed-industries/zed/tree/main/crates/languages/src) to see how to adapt these.

| Capture          | Description                                                  | Vim mode                                        |
| :--------------- | :----------------------------------------------------------- | :---------------------------------------------- |
| @function.around | An entire function definition or equivalent small section of a file. | `[m`, `]m`, `[M`,`]M`motions. `af` text object  |
| @function.inside | The function body (the stuff within the braces).             | `if` text object                                |
| @class.around    | An entire class definition or equivalent large section of a file. | `[[`, `]]`, `[]`, `][`motions. `ac` text object |
| @class.inside    | The contents of a class definition.                          | `ic` text object                                |
| @comment.around  | An entire comment (e.g. all adjacent line comments, or a block comment) | `gc` text object                                |
| @comment.inside  | The contents of a comment                                    | `igc` text object (rarely supported)            |

For example:

```scheme
; include only the content of the method in the function
(method_definition
    body: (_
        "{"
        (_)* @function.inside
        "}")) @function.around

; match function.around for declarations with no body
(function_signature_item) @function.around

; join all adjacent comments into one
(comment)+ @comment.around
```

### [Text redactions](https://zed.dev/docs/extensions/languages#text-redactions)

The `redactions.scm` file defines text redaction rules. When collaborating and sharing your screen, it makes sure that certain syntax nodes are rendered in a redacted mode to avoid them from leaking.

Here's an example from a `redactions.scm` file for JSON:

```scheme
(pair value: (number) @redact)
(pair value: (string) @redact)
(array (number) @redact)
(array (string) @redact)
```

This query marks number and string values in key-value pairs and arrays for redaction.

| Capture | Description                    |
| :------ | :----------------------------- |
| @redact | Captures values to be redacted |

### [Runnable code detection](https://zed.dev/docs/extensions/languages#runnable-code-detection)

The `runnables.scm` file defines rules for detecting runnable code.

Here's an example from an `runnables.scm` file for JSON:

```scheme
(
    (document
        (object
            (pair
                key: (string
                    (string_content) @_name
                    (#eq? @_name "scripts")
                )
                value: (object
                    (pair
                        key: (string (string_content) @run @script)
                    )
                )
            )
        )
    )
    (#set! tag package-script)
    (#set! tag composer-script)
)
```

This query detects runnable scripts in package.json and composer.json files.

The `@run` capture specifies where the run button should appear in the editor. Other captures, except those prefixed with an underscore, are exposed as environment variables with a prefix of `ZED_CUSTOM_$(capture_name)` when running the code.

| Capture | Description                                            |
| :------ | :----------------------------------------------------- |
| @_name  | Captures the "scripts" key                             |
| @run    | Captures the script name                               |
| @script | Also captures the script name (for different purposes) |

## [Language Servers](https://zed.dev/docs/extensions/languages#language-servers)

Zed uses the [Language Server Protocol](https://microsoft.github.io/language-server-protocol/) to provide advanced language support.

An extension may provide any number of language servers. To provide a language server from your extension, add an entry to your `extension.toml` with the name of your language server and the language(s) it applies to:

```toml
[language_servers.my-language]
name = "My Language LSP"
languages = ["My Language"]
```

Then, in the Rust code for your extension, implement the `language_server_command`method on your extension:

```rust
impl zed::Extension for MyExtension {
    fn language_server_command(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        Ok(zed::Command {
            command: get_path_to_language_server_executable()?,
            args: get_args_for_language_server()?,
            env: get_env_for_language_server()?,
        })
    }
}
```

You can customize the handling of the language server using several optional methods in the `Extension` trait. For example, you can control how completions are styled using the `label_for_completion` method. For a complete list of methods, see the [API docs for the Zed extension API](https://docs.rs/zed_extension_api).
