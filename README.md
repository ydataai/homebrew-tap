# Homebrew tap

Our formulas for Homebrew

## Table of contents

- [Installation](#installation)
  - [Github Runner](#github-runner-from-our-tap)
- [Formulas](#formulas)
  - [Github Runner](#github-runner)

## Installation 💻

### github-runner from our tap

```bash
brew install ydataai/tap/github-runner
```

## Formulas

### github-runner

This is a formula to install [github actions runner](https://github.com/actions/runner).

The formula copies the `bin` and `external` folders provided by Github into the `libexec` in the Cellar path created to this formula.
Instead of adding `Runner.Listener` binary probided by Github to the PATH, it creates a symlink called `github-runner` to this binary and adds it to the PATH, to make it easier and intuitive on how to use the runner.

#### Configuration 🛠

The configuration is basically the same provided by Github docs, but instead of use `Runner.Listener` or `./config.sh` you should use `github-runner configure`.
(basically `./config.sh` script runs `Runner.Listener` under the hood)

Let's give an example:

Assuming that you have followed the github doc [Adding self-hosted runners](https://help.github.com/en/actions/hosting-your-own-runners/adding-self-hosted-runners) and you have the `URL` and the `TOKEN`, run the following replacing the values

```bash
github-runner configure --url <URL> --token <TOKEN>
```

Follow the indications provided by the tool to configure your runner.
Those are the same as if you ran `./config.sh` as mentioned by Github.

#### Disclaimer ⚠️

YData only provides the formula to make it easy to install the runner os macOS environments, it doesn't modify the content of the runner or has any affiliation with the creation of the runner.

# About 👯‍♂️

With ❤️ from [YData](https://ydata.ai) [Development team](mailto://developers@ydata.ai)

