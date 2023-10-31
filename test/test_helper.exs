Application.put_env(:gen_lsp, :exit_on_end, false)

ExUnit.start(capture_log: true)
