# Freecodecamp Elixir
Solving exercises from Freecodecamp.org using Elixir programming language. Includes benchmarks and tests for every functions.

[//]: # "Badges"
[![Last Commit][commit badge]][commit]
[![Commit activity][pulse badge]][pulse]
[![Dependabot][dependabot badge]][dependabot]
[![Actions Status][actions badge]][actions]

[//]: # "Links"
[commit]: https://github.com/jaeyson/freecodecamp-elixir/commit/master
[pulse]: https://github.com/jaeyson/freecodecamp-elixir/pulse
[dependabot]: https://github.com/jaeyson/freecodecamp-elixir
[actions]: https://github.com/jaeyson/freecodecamp-elixir/actions

[//]: # "Image sources"
[commit badge]: https://img.shields.io/github/last-commit/jaeyson/freecodecamp-elixir.svg
[pulse badge]: https://img.shields.io/github/commit-activity/m/jaeyson/freecodecamp-elixir
[dependabot badge]: https://badgen.net/dependabot/jaeyson/freecodecamp-elixir/111643794?icon=dependabot
[actions badge]: https://github.com/jaeyson/freecodecamp-elixir/workflows/Elixir%20CI/badge.svg

### Pre-commit Hook

```bash
chmod +x create_pre_commit_hook.sh

./create_pre_commit_hook
```

### Using Docker (or use [`asdf`](https://asdf-vm.com/#/core-manage-asdf))

```plaintext
freecodecamp-elixir/
├── ...
├── lib/
│   ├── freecodecamp/
│   │   ├── algo_projects.ex
│   │   ├── basic_algo.ex
│   │   └── intermediate_algo.ex
│   └── freecodecamp.ex
├── test/
│   ├── basic_algo_test.exs
│   └── test_helper.exs
├── .formatter.exs
├── .gitattributes
├── .gitignore
├── docker-compose.yml
├── elixir.dockerfile
├── mix.exs
└── ...
```

### Build

```bash
docker-compose build && docker-compose up -d

# check if it is running
docker ps
```

### Create Elixir Project

```bash
# get deps
docker exec -it app mix deps.get

# use API v2 (ie resource limits)
docker-compose --compatibility up
```

### Test

```bash
# should be inside app/ folder before running command
docker exec -it app mix test
```

### Generate `HTML` Docs

```bash
docker exec -it app mix docs
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
docker exec -it app mix run benchmarks/basic_algo.exs
```

### Other useful commands

```bash
# check ip of running container
docker inspect <CONTAINER_NAME> | grep IPAddress

# runtime metrics of a container
docker stats <CONTAINER_NAME>

# list open ports
sudo lsof -i -P -n | grep LISTEN
```
