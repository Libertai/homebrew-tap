class Libertai < Formula
  desc "LibertAI CLI — inference, image generation, and agent-tool launchers"
  homepage "https://github.com/Libertai/libertai-cli"
  version "0.6.0"
  license "MIT"

  on_arm do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.6.0/libertai-macos-aarch64"
    sha256 "03aa8964c6cdbe3899d34e2e803cdf47808429874683bdf922663dda16f61018"
  end

  on_intel do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.6.0/libertai-macos-x86_64"
    sha256 "ac95a7b1043207d8e4e978e08e452733520538c0fe41cbaf6d8ef850ecf009e2"
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
