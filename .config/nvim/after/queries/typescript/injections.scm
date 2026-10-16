; extends

(
  (variable_declaration
    (comment) @injection.language
    (template_string) @injection.content
    (#match? @injection.language "/*\\s*glsl\\s*\\*/")
    (#set! injection.language "glsl")
    ; The next line is important to trim the backticks from the injected area
    (#offset! @injection.content 0 1 0 -1)
  )
)

; Handle cases where the template string is part of an assignment expression rather than a declaration
(
  (assignment_expression
    left: (_)
    right: (template_string) @injection.content
    (comment) @injection.language
    (#match? @injection.language "/*\\s*glsl\\s*\\*/")
    (#set! injection.language "glsl")
    (#offset! @injection.content 0 1 0 -1)
)
