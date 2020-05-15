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

This is a formula to install [github actions runner](https://github.com/actions/runner)

The formula copies the `bin` and `external` folders provided by Github into the `libexec` folder in the Cellar path created to this formula.
Instead of adding `Runner.Listener` binary probided by Github to the binaries folder, it creates a symlink called `github-runner` which is then added to the binaries folder, usually `/usr/local/bin`.
The Github runner is prepared to create all the configuration files in the same folder where it is installed, which means that all the files will be placed in the `libexec` folder, which from our point of view is not ideal, they should be on an etc folder or in the user home folder, but for now is what we can do.

#### Configuration 🛠

The configuration is basically the same provided by Github docs, but instead of use `Runner.Listener` or `./config.sh` you should use `github-runner configure`.
(basically `./config.sh` script runs `Runner.Listener` under the hood)

As example, assuming that you have followed the github doc [Adding self-hosted runners](https://help.github.com/en/actions/hosting-your-own-runners/adding-self-hosted-runners) and you have the `URL` and the `TOKEN`, run the following command replacing the values:

```bash
github-runner configure --url <URL> --token <TOKEN>
```

Follow the indications provided by the tool to configure your runner.
Those are the same as if you ran `./config.sh` as mentioned by Github.

#### Service

The formula supports homebrew services so you can easily add and manage github-runner through launchd.

Make sure you [configure](#configuration) the runner before start the service, otherwise it will not work, the service depends on a file created by the configuration (YET).

To start the runner and register it in launchd

```bash
brew services start github-runner
```

To stop the runner and un-register it in launchd

```bash
brew services stop github-runner
```

#### Disclaimer ⚠️

YData only provides the formula to make it easy to install the runner os macOS environments, it doesn't modify the content of the runner or has any affiliation with the creation of the runner.

## Contributing 🙏

You are more than welcome to submit any kind of contribution, issues, pull requests or just feedback. 🙇‍

# About 👯‍♂️

With ❤️ from [YData](https://ydata.ai) [Development team](mailto://developers@ydata.ai)

