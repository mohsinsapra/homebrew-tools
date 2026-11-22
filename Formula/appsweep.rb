class Appsweep < Formula
  desc "Remove many iPhone apps at once from your Mac over USB"
  homepage "https://mohsin.se/tools/appsweep"
  url "https://mohsin.se/get/appsweep-1.0.0.tar.gz"
  sha256 "fe30bf4dd956dc43f66ada26f1b79351c50a47d7e516d587fa045e39536293a8"
  license "MIT"

  depends_on :macos
  depends_on "libimobiledevice"
  depends_on "ideviceinstaller"

  def install
    # Homebrew strips the single top-level folder (AppSweep.app) while unpacking,
    # so the app bundle contents are in the build dir.
    (prefix/"AppSweep.app").install "Contents"
    (bin/"appsweep").write <<~SH
      #!/bin/bash
      open "#{opt_prefix}/AppSweep.app"
    SH
    chmod 0755, bin/"appsweep"
  end

  def caveats
    <<~EOS
      Start AppSweep with:
        appsweep

      To link it into Applications:
        ln -sf "$(brew --prefix appsweep)/AppSweep.app" /Applications/AppSweep.app
    EOS
  end

  test do
    assert_predicate prefix/"AppSweep.app/Contents/MacOS/AppSweep", :executable?
  end
end
