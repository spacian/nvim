; extends

(tuple
  "(" @magic.tuple
  (_)
  ")" @magic.tuple
  (#set! priority 91))

(list
  "[" @magic.list
  (_)
  "]" @magic.list
  (#set! priority 91))

(dictionary
  "{" @magic.dict
  (_)
  "}" @magic.dict
  (#set! priority 91))

(set
  ["{" "}"] @magic.set
  (#set! priority 91))

(class_definition
  name: (identifier) @class.name
  (#set! priority 91))

(function_definition
  name: (identifier) @function.definition
  (#set! priority 91))

(import_from_statement
  module_name: (dotted_name) @import.path
  name: (dotted_name)  @import.target
  (#set! priority 92))

(import_statement
  name: (dotted_name)  @import.target
  (#set! priority 92))

(class_definition
  body: (block
    (expression_statement
      (assignment
        left: (identifier) @class.expression)))
  (#set! priority 91))

(decorator
  "@" @decorator
  [
    (identifier) @decorator
    (attribute) @decorator
    (call function: (identifier) @decorator)
    (call function: (attribute) @decorator)
  ]
  (#set! priority 102))

(type
  (_) @type
  (#set! priority 92))

(attribute
  attribute: (identifier) @variable.member
  (#set! priority 91))
