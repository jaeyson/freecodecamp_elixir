# Freecodecamp exercises using Elixir

Solving exercises from Freecodecamp.org using Elixir programming language. Includes benchmarks and tests for every functions.

[//]: # "Badges"

[![Last Commit][commit-badge]](https://github.com/jaeyson/freecodecamp_elixir/commit/main)
[![Commit activity][pulse-badge]](https://github.com/jaeyson/freecodecamp_elixir/pulse)
[![Dependabot][dependabot-badge]](https://github.com/jaeyson/freecodecamp_elixir/pulls/app%2Fdependabot)
[![Actions Status][actions-badge]](https://github.com/jaeyson/freecodecamp_elixir/actions)
[![Coverage][coverage-badge]](https://coveralls.io/github/jaeyson/freecodecamp_elixir?branch=main)
[![Hex.pm][hex-badge]](https://hex.pm/packages/freecodecamp_elixir)
[![Hexdocs][hexdocs-badge]](https://hexdocs.pm/freecodecamp_elixir)

<!--
[//]: # This didn't render well on hexdocs, idk why
[//]: # "Badges"
[![Last Commit][commit-badge]][commit]
[![Commit activity][pulse-badge]][pulse]
[![Dependabot][dependabot-badge]][dependabot]
[![Actions Status][actions-badge]][actions]
[![Coverage][coverage-badge]][coverage]
[![Hex.pm][hex-badge]][hex]

[//]: # "Links"
[commit]: https://github.com/jaeyson/freecodecamp_elixir/commit/main
[pulse]: https://github.com/jaeyson/freecodecamp_elixir/pulse
[dependabot]: https://github.com/jaeyson/freecodecamp_elixir/pulls/app%2Fdependabot
[actions]: https://github.com/jaeyson/freecodecamp_elixir/actions
[coverage]: https://coveralls.io/github/jaeyson/freecodecamp_elixir?branch=main
[hex]: https://hex.pm/packages/freecodecamp_elixir
[hexdocs]: https://hexdocs.pm/freecodecamp_elixir
-->

[//]: # "Image sources"
[commit-badge]: https://img.shields.io/github/last-commit/jaeyson/freecodecamp_elixir.svg
[pulse-badge]: https://img.shields.io/github/commit-activity/m/jaeyson/freecodecamp_elixir
[dependabot-badge]: https://img.shields.io/badge/Dependabot-enabled-green
[actions-badge]: https://github.com/jaeyson/freecodecamp_elixir/actions/workflows/ci.yml/badge.svg
[coverage-badge]: https://coveralls.io/repos/github/jaeyson/freecodecamp_elixir/badge.svg?branch=main
[hex-badge]: https://img.shields.io/hexpm/v/freecodecamp_elixir
[hexdocs-badge]: https://img.shields.io/badge/hex-docs-blue

Folders that are interesting to read can be found at:

- [`lib/`](https://github.com/jaeyson/freecodecamp_elixir/tree/main/lib/)
- [`test/`](https://github.com/jaeyson/freecodecamp_elixir/tree/main/test/)

## Elixir installation

Either use [Docker](https://docs.docker.com/get-docker/), this Docker automated install script `curl -sSL https://get.docker.com/ | sh`, or use [`asdf`](https://asdf-vm.com/#/core-manage-asdf).

## Using Docker

using `docker_start` shell script (use wsl on windows or git bash, otherwise this works both ?mac? and linux), or see the file if you want to use docker commands instead.

```bash
# I haven't tried this both on windows and mac, YMMV
source docker_start
```

Why `source docker_start` instead of `chmod +x ./docker_start`? read [run bash script doesn't work alias command](https://unix.stackexchange.com/a/386455/437416).

#### Getting dependencies

```bash
mix deps.get --only test
```

#### Launch REPL

```bash
iex -S mix
```

#### Stopping **Elixir** container, remove alias created by shell script

```bash
# where "elixir" is the name of the container
docker container stop elixir

# temporary alias are not persisted across different sessions
# but if you want to remove them
unalias elixir iex mix elixirc
```

## Create Pre-commit Hook

```bash
mix precommit
```

## Test

```bash
mix test
```

#### Coverage

```bash
mix text --cover
```

#### Selective tests

```bash
# i.e. you want to test only "Basic Algorithms"
mix selective_test basic_algo

# or more, separated by spaces
mix selective_test basic_algo intermediate_algo

# basic_algo        = Basic Algorithm Scripting
# intermediate_algo = Intermediate Algorithm Scripting
```

## Generate `HTML` Docs

```bash
# running this generates docs in "doc/" directory
mix docs
```

## Benchmarks (using Benchee)

```bash
# view benchmark commands
mix help benchmark
```

```bash
# list available functions
mix benchmark --list
```

```bash
# specific function
mix benchmark mutation
```

```bash
# benchmark results saved as html in "benchmarks/" directory
mix benchmark mutation --html
```
