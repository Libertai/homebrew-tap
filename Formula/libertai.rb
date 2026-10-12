class Libertai < Formula
  desc "LibertAI CLI — inference, image generation, and agent-tool launchers"
  homepage "https://github.com/Libertai/libertai-cli"
  version "0.6.0"
  license "MIT"

  on_arm do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.6.0/libertai-macos-aarch64"
    sha256 "d4e2479a5a90e199726c054d1efc54d25dc04ee6621e0e11d99d11da7c981bb8"
  end

  on_intel do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.6.0/libertai-macos-x86_64"
    sha256 "1207890b98e0d70af90713b29886b1ed6bf5560a5abf98ab7bf01e5ec62028f9"
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
