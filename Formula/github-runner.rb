class GithubRunner < Formula
  desc "The official Github Runner"
  homepage "https://github.com/actions/runner"
  url "https://github.com/actions/runner/releases/download/v2.169.1/actions-runner-osx-x64-2.169.1.tar.gz"
  head "https://github.com/actions/runner.git"
  sha256 "d24529d7016b6f281b8c0daa052215381075db377c73cc6221335e13bb9e4a07"

  def install

    libexec.install Dir["bin"]
    libexec.install Dir["externals"]

    ln_s libexec/"bin/Runner.Listener", "github-runner"

    bin.install "github-runner"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/github-runner --version")
  end
end
