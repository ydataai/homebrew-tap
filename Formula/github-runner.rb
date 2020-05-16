class GithubRunner < Formula
  desc "The official Github Runner"
  homepage "https://github.com/actions/runner"
  url "https://github.com/actions/runner/releases/download/v2.169.1/actions-runner-osx-x64-2.169.1.tar.gz"
  head "https://github.com/actions/runner.git"
  sha256 "d24529d7016b6f281b8c0daa052215381075db377c73cc6221335e13bb9e4a07"
  version "2.169.1"

  depends_on "nvm"

  def install

    libexec.install "env.sh"
    libexec.install Dir["bin"]
    libexec.install Dir["externals"]

    runner = (libexec/"github-runner")
    runner.atomic_write <<~EOS
    #!/bin/sh

    SOURCE="${BASH_SOURCE[0]}"
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
      DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
      SOURCE="$(readlink "$SOURCE")"
      [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    cd $DIR

    sh ./env.sh

    ./bin/Runner.Listener "$@"
    EOS
    runner.chmod 0755

    ohai "Write plist path to .service file"
    (libexec/".service").write plist_path

    bin.install_symlink runner
  end

  def caveats
    <<~EOS
    To configure the runner, make sure you configure it with the url and token from github
      github-runner configure --url <URL to repo|organization> --token <TOKEN>

    To remove it from launchd
      brew services stop github-runner
    EOS
  end

  def plist
    <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>WorkingDirectory</key>
        <string>#{libexec}</string>
        <key>RunAtLoad</key>
        <true/>
        <key>StandardOutPath</key>
        <string>#{ENV["HOME"]}/Library/Logs/#{plist_name}/stdout.log</string>
        <key>StandardErrorPath</key>
        <string>#{ENV["HOME"]}/Library/Logs/#{plist_name}/stderr.log</string>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{libexec}/bin/runsvc.sh</string>
        </array>
        <key>EnvironmentVariables</key>
        <dict>
          <key>ACTIONS_RUNNER_SVC</key>
          <string>1</string>
        </dict>
      </dict>
    </plist>
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/github-runner --version")
  end
end
