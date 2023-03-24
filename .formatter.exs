# Used by "mix format"
[
  locals_without_parens: [
    assert_result: 2,
    assert_notification: 2,
    assert_result: 3,
    assert_notification: 3,
    notify: 2,
    request: 2
  ],
  import_deps: [:typed_struct],
  inputs: ["{mix,.formatter}.exs", "{config,lib,test,}/**/*.{ex,exs}"]
]
