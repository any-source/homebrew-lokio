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
      url "https://github.com/any-source/lokio/releases/download/v#{version}/lokio-darwin-aarch64.zip"
      sha256 "fe761362b271111a9bd19ab78f6c110353c6ed93d19693c9c76e347596515466" # lokio-darwin-aarch64.zip
    elsif Hardware::CPU.avx2?
      url "https://github.com/any-source/lokio/releases/download/v#{version}/lokio-darwin-x64.zip"
      sha256 "a53deeadebeeb616c050cf0f4e6214325cb0251c44889b15417c2c1a8cbd8b3f" # lokio-darwin-x64.zip
    else
      url "https://github.com/any-source/lokio/releases/download/v#{version}/lokio-darwin-x64-baseline.zip"
      sha256 "a53deeadebeeb616c050cf0f4e6214325cb0251c44889b15417c2c1a8cbd8b3f" # lokio-darwin-x64-baseline.zip
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/any-source/lokio/releases/download/v#{version}/lokio-linux-aarch64.zip"
      sha256 "b4db258a3c6398b824b9c359ed2b6251cf0e28cc45d5a5afff6c60835e0ec024" # lokio-linux-aarch64.zip
    elsif Hardware::CPU.avx2?
      url "https://github.com/any-source/lokio/releases/download/v#{version}/lokio-linux-x64.zip"
      sha256 "f947fc2bd6d8eabd9f318590796f522399c98ff9350734007fb5f0a465acc5a6" # lokio-linux-x64.zip
    else
      url "https://github.com/any-source/lokio/releases/download/v#{version}/lokio-linux-x64-baseline.zip"
      sha256 "f947fc2bd6d8eabd9f318590796f522399c98ff9350734007fb5f0a465acc5a6" # lokio-linux-x64-baseline.zip
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
