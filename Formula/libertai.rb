class Libertai < Formula
  desc "LibertAI CLI — inference, image generation, and agent-tool launchers"
  homepage "https://github.com/Libertai/libertai-cli"
  version "0.6.1"
  license "MIT"

  on_arm do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.6.1/libertai-macos-aarch64"
    sha256 "9bd3e50f3eb275dd93db337afd7c839c9203ea6edc111610f2771bec12985ba4"
  end

  on_intel do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.6.1/libertai-macos-x86_64"
    sha256 "f5ea3a98abfe0f68bd3d2d3d9ae6c334a1df7543b4b5549022ca47b8aa64d5d7"
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
