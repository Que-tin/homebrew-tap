cask "gloam" do
  version "0.10.0"
  sha256 "051037e5e4532ef18365e35fbf7454063e692ce38460471edfe0758370e04db0"

  url "https://github.com/Que-tin/gloam/releases/download/v#{version}/Gloam.dmg"
  name "Gloam"
  desc "Blue light filter that warms and dims the screen from sunset to bedtime"
  homepage "https://github.com/Que-tin/gloam"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Gloam.app"

  # Gloam's own removal: quits it (its screens restored), unregisters the login item, clears its
  # settings. Best effort: macOS won't run a copy that was never opened (quarantine). Then its files,
  # so uninstalling leaves nothing behind, --zap or not.
  uninstall early_script: {
              executable:   "#{appdir}/Gloam.app/Contents/MacOS/Gloam",
              args:         ["--uninstall"],
              must_succeed: false,
            },
            quit:         "io.github.que-tin.Gloam",
            trash:        [
              "~/Library/Caches/io.github.que-tin.Gloam",
              "~/Library/HTTPStorages/io.github.que-tin.Gloam",
              "~/Library/HTTPStorages/io.github.que-tin.Gloam.binarycookies",
              "~/Library/Preferences/io.github.que-tin.Gloam.plist",
            ]

  caveats <<~EOS
    Gloam isn't part of Apple's paid developer program, so the first time you open it macOS
    asks you to confirm: System Settings › Privacy & Security › Open Anyway. You only do this
    once; Gloam updates itself after that.
  EOS
end
