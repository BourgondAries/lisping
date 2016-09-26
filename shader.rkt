[module shader racket

[provide make-shader]

[require opengl ffi/vector]

[define [make-shader file type]
  [define shader [glCreateShader type]]
  [define code [file->string file]]
  [glShaderSource shader 1 [vector code] [s32vector [string-length code]]]
  [glCompileShader shader]
  [define compile-status [glGetShaderiv shader GL_COMPILE_STATUS]]
  [define log-length [glGetShaderiv shader GL_INFO_LOG_LENGTH]]
  [printf "compile-status ~a\n" compile-status]
  [when [= compile-status 1]
    [printf "Compiled shader OK\n"]]
  [when [> log-length 0]
    [define-values [count bytes] [glGetShaderInfoLog shader log-length]]
    [printf "compile-error "]
    [writeln bytes]]
  shader]

]