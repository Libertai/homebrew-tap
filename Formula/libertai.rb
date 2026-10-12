class Libertai < Formula
  desc "LibertAI CLI — inference, image generation, and agent-tool launchers"
  homepage "https://github.com/Libertai/libertai-cli"
  version "0.6.0"
  license "MIT"

  on_arm do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.6.0/libertai-macos-aarch64"
    sha256 "46dab277b7e0921a54e43b9a7129a3aa1ae84c129f2f9789738d5519d3093f5e"
  end

  on_intel do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.6.0/libertai-macos-x86_64"
    sha256 "9e369180253d0fba8aa22e59110ab21ffb737f1f458b73ab22fc4b019a44106b"
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
