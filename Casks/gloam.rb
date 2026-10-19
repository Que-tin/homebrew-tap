cask "gloam" do
  version "0.9.0"
  sha256 "9ba115bf88f17f1bed6c100a671b2b0a0d287a8e8a31a8dc7fb879b62d6848cb"

  url "https://github.com/Que-tin/gloam/releases/download/v#{version}/Gloam.dmg"
  name "Gloam"
  desc "Blue light filter that warms and dims the screen from sunset to bedtime"
  homepage "https://github.com/Que-tin/gloam"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :sonoma

  app "Gloam.app"

  # Gloam's own removal: quits it (its screens restored), unregisters the login item, clears its
  # settings. Plus its files, so uninstalling leaves nothing behind, --zap or not.
  uninstall early_script: {
              executable: "#{appdir}/Gloam.app/Contents/MacOS/Gloam",
              args:       ["--uninstall"],
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
