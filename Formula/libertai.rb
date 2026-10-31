class Libertai < Formula
  desc "LibertAI CLI — inference, image generation, and agent-tool launchers"
  homepage "https://github.com/Libertai/libertai-cli"
  version "0.6.2"
  license "MIT"

  on_arm do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.6.2/libertai-macos-aarch64"
    sha256 "f8257c8dfb5cb8c2fcfe56de7a6f232650c23dfd157b5d9df1c957892d8d23ee"
  end

  on_intel do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.6.2/libertai-macos-x86_64"
    sha256 "ec9d374bff3f93c294d9cc5b5761699c5ef79b59fe043ca771a32a533b67815f"
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
