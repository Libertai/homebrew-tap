class Libertai < Formula
  desc "LibertAI CLI — inference, image generation, and agent-tool launchers"
  homepage "https://github.com/Libertai/libertai-cli"
  version "0.6.0"
  license "MIT"

  on_arm do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.6.0/libertai-macos-aarch64"
    sha256 "ea9e9bfeb57ba0ed6d79cea860673545edd2ffe274344ffe7f300a3da7264fb0"
  end

  on_intel do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.6.0/libertai-macos-x86_64"
    sha256 "21375c12ddbd23f659c6e7522ea7351443350290a30b2f95c5e6c5d33e725178"
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
