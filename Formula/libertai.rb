class Libertai < Formula
  desc "LibertAI CLI - inference, image generation, and agent-tool launchers"
  homepage "https://github.com/Libertai/libertai-cli"
  version "0.3.0"
  license "MIT"

  on_arm do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.3.0/libertai-macos-aarch64"
    sha256 "ecf192a072b6731e7cf816b37b4a6331d0fb2a3101cd41a835a0ba8b5f6e7554"
  end

  on_intel do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.3.0/libertai-macos-x86_64"
    sha256 "2abe953770cbeb62afcad3ccfc71aa5af465bd706dc9b143ffe531641096f2ae"
  end

  def install
    if Hardware::CPU.arm?
      bin.install "libertai-macos-aarch64" => "libertai"
    else
      bin.install "libertai-macos-x86_64" => "libertai"
    end
    generate_completions_from_executable(bin/"libertai", "completions")
    (man1/"libertai.1").write Utils.safe_popen_read(bin/"libertai", "man")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/libertai --version")
  end
end
