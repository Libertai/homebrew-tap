class Libertai < Formula
  desc "LibertAI CLI — inference, image generation, and agent-tool launchers"
  homepage "https://github.com/Libertai/libertai-cli"
  version "0.4.3"
  license "MIT"

  on_arm do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.4.3/libertai-macos-aarch64"
    sha256 "eec85b26260d5b2db63199a96ec2af8a86dad9ddad1841783ea9db821a3b2fde"
  end

  on_intel do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.4.3/libertai-macos-x86_64"
    sha256 "5fdad11c85215bd3d6ef07ab400a7dbe9fdc43d96b7f5806e66265d618177bd8"
  end

  def install
    if Hardware::CPU.arm?
      bin.install "libertai-macos-aarch64" => "libertai"
    else
      bin.install "libertai-macos-x86_64" => "libertai"
    end
    # Bare release asset arrives as 0644; make it executable before we run it.
    chmod 0755, bin/"libertai"
    generate_completions_from_executable(bin/"libertai", "completions")
    (man1/"libertai.1").write Utils.safe_popen_read(bin/"libertai", "man")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/libertai --version")
  end
end
