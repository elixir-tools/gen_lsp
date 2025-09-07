# Used by "mix format"
locals = [
  assert_result: 2,
  assert_error: 2,
  assert_notification: 2,
  assert_result: 3,
  assert_error: 3,
  assert_notification: 3,
  notify: 2,
  request: 2
]

[
  locals_without_parens: locals,
  import_deps: [:typed_struct, :stream_data],
  inputs: ["{mix,.formatter}.exs", "{config,lib,test,}/**/*.{ex,exs}"],
  export: [
    locals_without_parens: locals
  ]
]
