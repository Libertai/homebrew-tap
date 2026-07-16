class Libertai < Formula
  desc "LibertAI CLI — inference, image generation, and agent-tool launchers"
  homepage "https://github.com/Libertai/libertai-cli"
  version "0.4.5"
  license "MIT"

  on_arm do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.4.5/libertai-macos-aarch64"
    sha256 "4ffbb89e65c0c03b65a677a8af2b531f041662afe4cf60e4a6d11d52c85939b2"
  end

  on_intel do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.4.5/libertai-macos-x86_64"
    sha256 "7d6c674407fd98aa5a2f6c9233e231ae87913dd1e2bb8768cee1c07ad7f0b8a6"
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
