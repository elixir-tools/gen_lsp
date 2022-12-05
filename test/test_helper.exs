Application.put_env(:gen_lsp, :wire_protocol, GenLSPTest.TestWire)

ExUnit.start(capture_log: true)
