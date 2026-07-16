; extends

(tuple
  "(" @magic.tuple
  (_)
  ")" @magic.tuple
  (#set! priority 100))

(list
  "[" @magic.list
  (_)
  "]" @magic.list
  (#set! priority 100))

(dictionary
  "{" @magic.dict
  (_)
  "}" @magic.dict
  (#set! priority 100))

(set
  ["{" "}"] @magic.set
  (#set! priority 100))

(class_definition
  name: (identifier) @class.name
  (#set! priority 100))

(function_definition
  name: (identifier) @function.definition
  (#set! priority 100))

(import_from_statement
  module_name: (dotted_name) @import.path
  name: (dotted_name)  @import.target
  (#set! priority 200))

(import_statement
  name: (dotted_name)  @import.target
  (#set! priority 200))

(class_definition
  body: (block
    (expression_statement
      (assignment
        left: (identifier) @class.expression)))
  (#set! priority 100))

(decorator
  "@" @decorator
  [
    (identifier) @decorator
    (attribute) @decorator
    (call function: (identifier) @decorator)
    (call function: (attribute) @decorator)
  ]
  (#set! priority 200))

(type
  [
    (identifier) @type
    (attribute) @type
    (list
      ["[" "]"] @punctuation.bracket)
  ]
  (#set! priority 200))
