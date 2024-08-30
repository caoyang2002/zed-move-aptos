;; Special forms
[
  "module"
  "script"
  "use"
  "entry"
  "public"
  "fun"
  "let"
  "const"
  "acquires"
  "u8"
  "u16"
  "u32"
  "u64"
  "u128"
  "u256"
  "struct"
  "has"
  "mut"
  "friend"
  "while"
  "for"
  "loop"
  "if"
  "return"
] @keyword

;; Function definitions
[
 "defun"
 "defsubst"
 ] @keyword
(function_definition name: (symbol) @function)
(function_definition parameters: (list (symbol) @variable.parameter))
(function_definition docstring: (string) @comment)

;; Highlight macro definitions the same way as function definitions.
"defmacro" @keyword
(macro_definition name: (symbol) @function)
(macro_definition parameters: (list (symbol) @variable.parameter))
(macro_definition docstring: (string) @comment)

(comment) @comment

(integer) @number
(float) @number
(char) @number

(string) @string

[
  "("
  ")"
  "#["
  "["
  "]"
] @punctuation.bracket

[
  "`"
  "#'"
  "'"
  ","
  ",@"
] @operator

;; Highlight nil and t as constants, unlike other symbols
[
  "nil"
  "t"
] @constant.builtin
