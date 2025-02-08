class Lokio < Formula
  desc "Structuring Code, One Command at a Time"
  homepage "https://lokio.dev/"
  license "MIT"
  version "1.0.1"

  livecheck do
    url "https://github.com/any-source/lokio/releases/latest"
    regex(%r{href=.*?/tag/bun-v?(\d+(?:\.\d+)+)["' >]}i)
  end

  if OS.mac?
    if Hardware::CPU.arm? || Hardware::CPU.in_rosetta2?
      url "https://github.com/any-source/lokio/releases/download/lokio-v#{version}/lokio-darwin-aarch64.zip"
      sha256 "c4d58e06c5c33885b526f4d91a38ca9ebdb9fc3fb4cd547f7d3302055c98e41c" # lokio-darwin-aarch64.zip
    elsif Hardware::CPU.avx2?
      url "https://github.com/any-source/lokio/releases/download/lokio-v#{version}/lokio-darwin-x64.zip"
      sha256 "2f7d5a9cd90bc4f28449dc7b76a5e9eefade03e119f1cd4e3f941b92b26c6595" # lokio-darwin-x64.zip
    else
      url "https://github.com/any-source/lokio/releases/download/lokio-v#{version}/lokio-darwin-x64-baseline.zip"
      sha256 "0f3b6e87d862d4016f8d95da177bc9136ca2e950f3d6d3d226a35d7061fff0f1" # lokio-darwin-x64-baseline.zip
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/any-source/lokio/releases/download/lokio-v#{version}/lokio-linux-aarch64.zip"
      sha256 "d1dbaa3e9af24549fad92bdbe4fb21fa53302cd048a8f004e85a240984c93d4d" # lokio-linux-aarch64.zip
    elsif Hardware::CPU.avx2?
      url "https://github.com/any-source/lokio/releases/download/lokio-v#{version}/lokio-linux-x64.zip"
      sha256 "3f4efb8afd1f84ac2a98c04661c898561d1d35527d030cb4571e99b7c85f5079" # lokio-linux-x64.zip
    else
      url "https://github.com/any-source/lokio/releases/download/lokio-v#{version}/lokio-linux-x64-baseline.zip"
      sha256 "cad7756a6ee16f3432a328f8023fc5cd431106822eacfa6d6d3afbad6fdc24db" # lokio-linux-x64-baseline.zip
    end
  else
    odie "Unsupported platform. Please submit a bug report here: https://lokio.dev/issues\n#{OS.report}"
  end

  # TODO: to become an official formula we need to build from source
  def install
    bin.install "lokio"
    ENV["LOKIO_INSTALL"] = "#{bin}"
    generate_completions_from_executable(bin/"lokio", "completions")
  end

  def test
    assert_match "#{version}", shell_output("#{bin}/lokio -v")
  end
end
