# CHANGELOG

## [0.6.0](https://github.com/elixir-tools/gen_lsp/compare/v0.5.0...v0.6.0) (2023-08-06)


### ⚠ BREAKING CHANGES

* allow > 1 lsp servers to be started during async tests ([#37](https://github.com/elixir-tools/gen_lsp/issues/37))

### Bug Fixes

* allow &gt; 1 lsp servers to be started during async tests ([#37](https://github.com/elixir-tools/gen_lsp/issues/37)) ([8f586dc](https://github.com/elixir-tools/gen_lsp/commit/8f586dc2f471af577e6d26f3942fdb2fe15bc42e)), closes [#29](https://github.com/elixir-tools/gen_lsp/issues/29)

## [0.5.0](https://github.com/elixir-tools/gen_lsp/compare/v0.4.0...v0.5.0) (2023-07-14)


### Features

* server to client requests ([#35](https://github.com/elixir-tools/gen_lsp/issues/35)) ([f38c761](https://github.com/elixir-tools/gen_lsp/commit/f38c761496a3fd9b7aee9080451cd42ceef5246d)), closes [#34](https://github.com/elixir-tools/gen_lsp/issues/34)

## [0.4.0](https://github.com/elixir-tools/gen_lsp/compare/v0.3.0...v0.4.0) (2023-07-12)


### Features

* update codegen ([#32](https://github.com/elixir-tools/gen_lsp/issues/32)) ([ef91d21](https://github.com/elixir-tools/gen_lsp/commit/ef91d2167710a680918764ea7777c9b481950e8c))

## [0.3.0](https://github.com/elixir-tools/gen_lsp/compare/v0.2.1...v0.3.0) (2023-06-25)


### ⚠ BREAKING CHANGES

* bump min elixir version ([#27](https://github.com/elixir-tools/gen_lsp/issues/27))

### Features

* bump min elixir version ([#27](https://github.com/elixir-tools/gen_lsp/issues/27)) ([a0fe869](https://github.com/elixir-tools/gen_lsp/commit/a0fe86943fae8c8b8f84e42a74b08187edcdf01d))

## [0.2.1](https://github.com/elixir-tools/gen_lsp/compare/v0.2.0...v0.2.1) (2023-06-23)


### Bug Fixes

* send error log on exception during loop ([#25](https://github.com/elixir-tools/gen_lsp/issues/25)) ([c194f44](https://github.com/elixir-tools/gen_lsp/commit/c194f441378fb265b5551d6b4261040cb49495cc))

## [0.2.0](https://github.com/elixir-tools/gen_lsp/compare/v0.1.2...v0.2.0) (2023-06-22)


### Features

* bump schematic to 0.2 ([10359fd](https://github.com/elixir-tools/gen_lsp/commit/10359fd8b66f70f4ffee5727ebcdd907207c636c))

## v0.1.2

feat: respect :assert_receive_timeout config (#21)

## v0.1.1

fix: enumerations respect supports_custom_values (#19)

## v0.1.0

- chore: update schematic (#18)

## v0.0.12

- feat: error response by @mhanberg in https://github.com/elixir-tools/gen_lsp/pull/14

## v0.0.11

- fix: handle recursive structures by @mhanberg in https://github.com/mhanberg/gen_lsp/pull/13
