class Libertai < Formula
  desc "LibertAI CLI — inference, image generation, and agent-tool launchers"
  homepage "https://github.com/Libertai/libertai-cli"
  version "0.4.0"
  license "MIT"

  on_arm do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.4.0/libertai-macos-aarch64"
    sha256 "4d2ef256f25d1a3e82e16732db92aef217ea17374fcd7bbc22a8d94751949d57"
  end

  on_intel do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.4.0/libertai-macos-x86_64"
    sha256 "d79fd36ce1f10cbb55ee74b017ea45edb41dcf75ab4330b5dd0de838466b9a78"
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
