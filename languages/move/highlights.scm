;; Types
(type_parameters) @type
(type_parameter) @type
(type_parameter_identifier) @type
(apply_type) @type
(ref_type) @type.ref
(primitive_type) @type.builtin

;; Comments
(line_comment) @comment
(block_comment) @comment

;; Annotations
(annotation) @annotation
(annotation_item) @annotation.item

;; Constants
(constant name: (constant_identifier) @constant.name)
(constant expr: (num_literal) @constant.value)
((identifier) @constant.name
 (#match? @constant.name "^[A-Z][A-Z\\d_]+$"))

;; Function definitions
(function_definition name: (function_identifier) @function)
(macro_function_definition name: (function_identifier) @macro)
(native_function_definition name: (function_identifier) @function)
(usual_spec_function name: (function_identifier) @function)
(function_parameter name: (variable_identifier) @variable.parameter)

;; Module definitions
(module_identity address: (module_identifier) @namespace.module.address)
(module_identity module: (module_identifier) @namespace.module.name)

;; Function calls -
(function_call_expression
  (name_expression
    access: (module_access
      module: (module_identifier) @namespace.module.name)))

(function_call_expression
  (name_expression
    access: (module_access
      member: (identifier) @function.call)))

;; function call
(function_call_expression
  (name_expression
    access: (module_access
      member: (identifier) @function.call)))

(label (identifier) @label)

;; Macro calls
(macro_function_call_expression
  access: (macro_module_access) @macro.call)

;; Literals
(num_literal) @number
(bool_literal) @boolean
(hex_string_literal) @string.hex
(byte_string_literal) @string.byte
(address_literal) @number.address

;; Uses
(use_member member: (identifier) @include.member)
(use_module alias: (module_identifier) @namespace.module.name)
; (use_fun (module_access module: (module_identifier) @namespace.module.name))
; (use_fun (module_access member: (identifier) @include.member))
(function_identifier) @function.name

;; Structs
(struct_definition name: (struct_identifier) @type.definition.struct)
(ability) @type.ability
(field_annotation field: (field_identifier) @field.identifier)
(field_identifier) @field.identifier

;; Enums
(enum_definition name: (enum_identifier) @type.definition.struct)
(variant variant_name: (variant_identifier) @constructor.name)

;; Packs
(pack_expression
  (name_expression
    access: (module_access) @constructor.name))

;; Unpacks
(bind_unpack (name_expression) @type.name)

;; Module access with macro variables
(module_access "$" (identifier) @macro.variable)
"$" @macro.variable

(module_access
  module: (module_identifier)
  member: (identifier) @constructor.name)

;; Special expressions
(abort_expression) @keyword
(mut_ref) @keyword

;; Operators
(binary_operator) @operator
(unary_op) @operator
; "=>" @operator
; "@" @operator
; "->" @operator

;; Specs
(spec_block target: (identifier) @function.spec.target)
(spec_pragma) @preproc.annotation.spec
(spec_condition kind: (condition_kind) @condition.spec)
(condition_properties) @preproc.spec.condition.properties

;; Keywords
[
    "address"
    "module"
    "script"
 "pragma"
 "fun"
 "return"
 "if"
 "else"
 "while"
 "for"
 "in"
 "native"
 "struct"
 "use"
 "public"
 "package"
 "spec"

 "abort"
 "const"
 "let"
 "has"
 "as"
 "&"
 "friend"
 "entry"
 "mut"
 "macro"
 "enum"
 "break"
 "continue"
 "loop"
 "acquires"
 "match"
] @keyword
