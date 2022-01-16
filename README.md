# Freecodecamp exercises using Elixir

Solving exercises from Freecodecamp.org using Elixir programming language. Includes benchmarks and tests for every functions.

[//]: # "Badges"
[![Last Commit][commit badge]][commit]
[![Commit activity][pulse badge]][pulse]
[![Dependabot][dependabot badge]][dependabot]
[![Actions Status][actions badge]][actions]

[//]: # "Links"
[commit]: https://github.com/jaeyson/freecodecamp-elixir/commit/master
[pulse]: https://github.com/jaeyson/freecodecamp-elixir/pulse
[dependabot]: https://github.com/jaeyson/freecodecamp-elixir/pulls/app%2Fdependabot
[actions]: https://github.com/jaeyson/freecodecamp-elixir/actions

[//]: # "Image sources"
[commit badge]: https://img.shields.io/github/last-commit/jaeyson/freecodecamp-elixir.svg
[pulse badge]: https://img.shields.io/github/commit-activity/m/jaeyson/freecodecamp-elixir
[dependabot badge]: https://img.shields.io/badge/Dependabot-enabled-green
[actions badge]: https://github.com/jaeyson/freecodecamp-elixir/actions/workflows/elixir.yml/badge.svg

Folders/files that are interesting to read can be found at:

- `benchmarks/`
- `lib/freecodecamp/`
- `test/basic_algo_test.exs`
- `test/intermediate_algo_test.exs`

## Elixir installation

Either use [Docker](https://docs.docker.com/get-docker/), this Docker automated install script `curl -sSL https://get.docker.com/ | sh`, or use [`asdf`](https://asdf-vm.com/#/core-manage-asdf).

## Using Docker

### using `docker_start` shell script (use wsl on windows or git bash, otherwise this works both ?mac? and linux), or see the file if you want to use docker commands instead.

```bash
# I haven't tried this both on windows and mac, YMMV
source docker_start
```

Why `source docker_start` instead of `chmod +x ./docker_start`? read [run bash script doesn't work alias command](https://unix.stackexchange.com/a/386455/437416).

```bash
# getting dependencies
mix deps.get --only test

# repl with code loaded
iex -S mix

# runnig scripts
elixir sample.exs

# compile
elixirc solution.ex
```

### stopping **Elixir** container, remove alias created by shell script

```bash
# where "elixir" is the name of the container
docker container stop elixir

# temporary alias are not persisted across different sessions
# but if you want to remove them
unalias elixir iex mix elixirc
```

### Create Pre-commit Hook

```bash
mix precommit
```

### Test

```bash
mix test

# coverage
mix text --cover

# i.e. you want to test only "Basic Algorithms"
mix selective_test basic_algo

# or more, separated by spaces
mix selective_test basic_algo intermediate_algo

# basic_algo        = Basic Algorithm Scripting
# intermediate_algo = Intermediate Algorithm Scripting
# algo_projects     = Algorithm Projects
```

### Generate `HTML` Docs

```bash
# running this generates docs in "doc/" directory
mix docs
```

### Benchmarks (using Benchee)

If you want to benchmark a specific function:

```bash (path=benchmarks/basic_algo.exs)
# freecodecamp-elixir/benchmarks/basic_algo.exs

# Example: change the function name from
# "mutation" to "repeat_string"
# BasicAlgo.run("mutation", HTML)
# or uncomment lines to use that instead
BasicAlgo.run("repeat_string", HTML)

# you can use the default formatter (console)
BasicAlgo.run("repeat_string", Console)
```

```bash
mix run benchmarks/basic_algo.exs
```
