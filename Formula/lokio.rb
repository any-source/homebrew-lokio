class Lokio < Formula
  desc 'Lokio CLI tool'
  homepage 'https://github.com/any-source/lokio'
  version '0.0.4'
  url 'https://github.com/any-source/lokio/releases/download/v0.0.4/lokio-darwin-x64.tar.gz'
  sha256 "b57bd2964e6314d454e7bfb64bb121f2abb5a6c9fc3a8223c873b1a96f296ff6"

  def install
    if Hardware::CPU.arm?
      bin.install 'lokio' => 'lokio'
    else
      bin.install 'lokio-x64' => 'lokio'
    end
  end

  test do
    assert_match "0.0.4", shell_output("\#{bin}/lokio --version")
  end
end
