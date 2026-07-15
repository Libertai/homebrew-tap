class Libertai < Formula
  desc "LibertAI CLI — inference, image generation, and agent-tool launchers"
  homepage "https://github.com/Libertai/libertai-cli"
  version "0.4.2"
  license "MIT"

  on_arm do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.4.2/libertai-macos-aarch64"
    sha256 "b8ea504ea7b11afae04826c59dfccaca76c46a95ec6722e38da5fff4446ca801"
  end

  on_intel do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.4.2/libertai-macos-x86_64"
    sha256 "d697279dd1d65d07da788e8b6a49daf40810620cb54dfdc0df28bd4d5ac80b58"
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
