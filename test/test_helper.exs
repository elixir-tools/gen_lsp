Application.put_env(:gen_lsp, :wire_protocol, GenLSP.Test.Wire)

ExUnit.start(capture_log: true)
