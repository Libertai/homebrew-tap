class Libertai < Formula
  desc "LibertAI CLI — inference, image generation, and agent-tool launchers"
  homepage "https://github.com/Libertai/libertai-cli"
  version "0.4.1"
  license "MIT"

  on_arm do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.4.1/libertai-macos-aarch64"
    sha256 "2c30b6dd1184e23d3ce0e183e9fc24a8ed172268cdf5cdb246c87b172e919f8f"
  end

  on_intel do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.4.1/libertai-macos-x86_64"
    sha256 "040a56279e6234f07be1a5fe47e7ba13b425b181cb82391f073ccd188f8eebfe"
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
