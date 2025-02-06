class Lokio < Formula
  desc 'Lokio CLI tool'
  homepage 'https://github.com/any-source/lokio'
  version '1.0.1'
  url 'https://github.com/any-source/lokio/releases/download/v1.0.1/lokio-darwin-x64.tar.gz'
  sha256 "6e3ccf72d7ee6f1a530c88c4019311a4ea4b34ae382f66c9972cd9c3d08d8003"

  def install
    if Hardware::CPU.arm?
      bin.install 'lokio' => 'lokio'
    else
      bin.install 'lokio-x64' => 'lokio'
    end
  end

  test do
    assert_match "1.0.1", shell_output("\#{bin}/lokio --version")
  end
end
