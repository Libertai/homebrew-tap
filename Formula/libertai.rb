class Libertai < Formula
  desc "LibertAI CLI — inference, image generation, and agent-tool launchers"
  homepage "https://github.com/Libertai/libertai-cli"
  version "0.5.0"
  license "MIT"

  on_arm do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.5.0/libertai-macos-aarch64"
    sha256 "d9304b100b8e30be4acdc4a7f1910b16f8814fc8ff15c32995b530696665b026"
  end

  on_intel do
    url "https://github.com/Libertai/libertai-cli/releases/download/v0.5.0/libertai-macos-x86_64"
    sha256 "2fddbf0fb68b01c123a8e158c7835b5cc8ea76c16072259aeab651a23f6723e6"
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
