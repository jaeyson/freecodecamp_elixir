defmodule Mix.Tasks.Precommit do
  @moduledoc """
  Usage: `mix precommit [--force]`

  Generates `pre-commit` git hook. Visit [this link]
  (https://git-scm.com/book/en/Customizing-Git-Git-Hooks)
  to know more about git hooks.

  Add option `--force` to generate a new precommit file
  """
  @moduledoc since: "0.1.0"
  @shortdoc "Adds git precommit"

  @hook_name "pre-commit"
  @git_hooks_dir ".git/hooks/"
  @sh_script """
  #!/bin/sh

  set -euo

  MIX_ENV=test mix format --check-formatted
  MIX_ENV=test mix credo --strict
  MIX_ENV=test mix coveralls
  """

  use Mix.Task

  @impl Mix.Task
  @spec run([String.t()]) :: IO.puts()
  def run([]), do: run([""])

  def run([option | _] = _args) do
    @git_hooks_dir
    |> File.ls()
    |> check_hook_files()
    |> gen_precommit(option)
  end

  @spec check_hook_files(File.ls()) :: [String.t()] | IO.puts()
  defp check_hook_files({:ok, hook_files}) do
    Enum.filter(hook_files, &(&1 === @hook_name))
  end

  defp check_hook_files({:error, error_code}) do
    error_code
    |> :file.format_error()
    |> Kernel.++("... oops, do we have git in this directory?")
    |> IO.puts()
  end

  @spec gen_precommit([String.t()], String.t()) :: IO.puts()
  defp gen_precommit(_, "--force") do
    :ok = File.write(@git_hooks_dir <> @hook_name, @sh_script, [:write])

    ~s("--force" option added. Generating new precommit file @git_hooks_dir... done!)
    |> IO.puts()
  end

  defp gen_precommit([], "") do
    :ok = File.write(@git_hooks_dir <> @hook_name, @sh_script, [:write])

    ~s(Generating new precommit file to @git_hooks_dir... done!)
    |> IO.puts()
  end

  defp gen_precommit(_, option)
       when option !== "--force" and
              option !== "",
       do: IO.puts("unknown_option: #{option}")

  defp gen_precommit(_precommit_exists, _),
    do: IO.puts("precommit already exists")
end
