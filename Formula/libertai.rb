class Libertai < Formula
  desc "LibertAI CLI — inference, image generation, and agent-tool launchers"
  homepage "https://github.com/Libertai/libertai-cli"
  version "0.4.4"
  license "MIT"

  on_arm do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.4.4/libertai-macos-aarch64"
    sha256 "b792c8d937eafc2f27a458595462bbf2a151c5dd1c9836c7d85cbe66fec0c28b"
  end

  on_intel do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.4.4/libertai-macos-x86_64"
    sha256 "5fb2e9c50de388ff8fc04ee5dd3a979542314a0e633ca1a1793cf47be961778e"
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
