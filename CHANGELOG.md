# CHANGELOG

## [0.9.0](https://github.com/elixir-tools/gen_lsp/compare/v0.8.1...v0.9.0) (2024-05-20)


### ⚠ BREAKING CHANGES

* be resilient to LSP protocol errors ([#56](https://github.com/elixir-tools/gen_lsp/issues/56))

### Features

* be resilient to LSP protocol errors ([#56](https://github.com/elixir-tools/gen_lsp/issues/56)) ([fce380f](https://github.com/elixir-tools/gen_lsp/commit/fce380fb12faa56bbb83e28a04cbb8ab8612c10f))

## [0.8.1](https://github.com/elixir-tools/gen_lsp/compare/v0.8.0...v0.8.1) (2024-02-28)


### Bug Fixes

* add timeout parameter to GenLSP.request/3 ([b6963bb](https://github.com/elixir-tools/gen_lsp/commit/b6963bbdac99780d90719a2c7edca9fbbb7a401f))
* unify result in server to client request ([f2f0ba0](https://github.com/elixir-tools/gen_lsp/commit/f2f0ba0c217b3a4272dcb4c93bab48a25dd52d9c))

## [0.8.0](https://github.com/elixir-tools/gen_lsp/compare/v0.7.3...v0.8.0) (2024-02-28)


### Features

* **test:** shutdown_client!/1 and shutdown_server!/1 ([470dae6](https://github.com/elixir-tools/gen_lsp/commit/470dae62148b8e77a4734cb1abca1166bfb8bf55))

## [0.7.3](https://github.com/elixir-tools/gen_lsp/compare/v0.7.2...v0.7.3) (2024-02-15)


### Bug Fixes

* handle {:more, L} from decode_packet ([fb0cbd4](https://github.com/elixir-tools/gen_lsp/commit/fb0cbd4ef4b700f2d0dfaefae45c8cc5f73b128c))

## [0.7.2](https://github.com/elixir-tools/gen_lsp/compare/v0.7.1...v0.7.2) (2024-02-14)


### Bug Fixes

* avoid FunctionClauseError in transport stream ([5504b17](https://github.com/elixir-tools/gen_lsp/commit/5504b17c0d214fd3a79755022d54accc2218863a))

## [0.7.1](https://github.com/elixir-tools/gen_lsp/compare/v0.7.0...v0.7.1) (2024-01-02)


### Bug Fixes

* protect String.split from &gt;2 parts ([#50](https://github.com/elixir-tools/gen_lsp/issues/50)) ([9988f4a](https://github.com/elixir-tools/gen_lsp/commit/9988f4aa4b1ca6e8d061ab737ceda231f65c1117))

## [0.7.0](https://github.com/elixir-tools/gen_lsp/compare/v0.6.3...v0.7.0) (2023-11-29)


### Features

* telemetry ([#48](https://github.com/elixir-tools/gen_lsp/issues/48)) ([6ef68c4](https://github.com/elixir-tools/gen_lsp/commit/6ef68c4b939e5a7150a072bb30548d1e0697bf85))

## [0.6.3](https://github.com/elixir-tools/gen_lsp/compare/v0.6.2...v0.6.3) (2023-11-07)


### Bug Fixes

* clarify errors by handling more clauses ([#45](https://github.com/elixir-tools/gen_lsp/issues/45)) ([610b17f](https://github.com/elixir-tools/gen_lsp/commit/610b17f7e9268c1312a2b5131e22919e3e2a06aa))

## [0.6.2](https://github.com/elixir-tools/gen_lsp/compare/v0.6.1...v0.6.2) (2023-10-31)


### Bug Fixes

* conditionally stop on buffer close ([c548f4c](https://github.com/elixir-tools/gen_lsp/commit/c548f4c62a57ee19d5cde3973de22cce73091b4c))

## [0.6.1](https://github.com/elixir-tools/gen_lsp/compare/v0.6.0...v0.6.1) (2023-10-27)


### Bug Fixes

* shutdown when the transport closes ([#42](https://github.com/elixir-tools/gen_lsp/issues/42)) ([4650300](https://github.com/elixir-tools/gen_lsp/commit/465030084dc7700edf149d3e4b6d526380667b62))

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
