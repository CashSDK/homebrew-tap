# AGENTS.md: CashSDK Homebrew tap

Instructions for coding agents working in github.com/CashSDK/homebrew-tap.
This repository is edited directly. Unlike CashSDK/cashsdk-cli, it is not exported from the CashSDK source tree.

## What it is

- The tap behind `brew install cashsdk/tap/cashsdk`.
- One formula, `Formula/cashsdk.rb` (class `Cashsdk`). It downloads the platform's archive from a GitHub release of CashSDK/cashsdk-cli, installs the prebuilt binary with `bin.install "cashsdk"`, and its `test` block checks that `cashsdk version` prints `cashsdk <version>`.
- Four archives: macOS and Linux, each on arm64 and x86_64 (amd64). The release's Windows zip is not used here.
- `README.md` lists the formulae. Keep its table in step if one is added.
- This repo and CashSDK/cashsdk-cli stay public: `brew install` downloads the release assets straight from cashsdk-cli.

## How a release updates the formula

- The formula must match the CLI release exactly: every `url` points at tag `v<version>`, and each `sha256` equals that archive's line in the release's `checksums.txt`.
- A new version changes the four `url` lines (`https://github.com/CashSDK/cashsdk-cli/releases/download/v<version>/cashsdk_<version>_<os>_<arch>.tar.gz` for `darwin_arm64`, `darwin_amd64`, `linux_arm64`, `linux_amd64`) and the four `sha256` values.
- Never type these by hand. In the CLI source, `scripts/make-formula.sh <version> <checksums.txt>` renders the whole file and fails on a missing or malformed checksum. Replace `Formula/cashsdk.rb` with its output, then commit and push.
- The release's own checksums: `gh release download v<version> --repo CashSDK/cashsdk-cli --pattern checksums.txt`.
- Push the formula only after release `v<version>` exists with all four archives.
- The formula has no `version` line: Homebrew reads the version from the URLs, and `brew audit --strict` rejects a redundant one. The live formula matches the script's output exactly.

## Verify

brew reads the formula from its own checkout of this tap (`brew --repository cashsdk/tap`), not from this clone. Push, run `brew update`, then:

Before pushing, the edited file can be checked in a throwaway tap: `brew tap-new cashsdkaudit/local --no-git`, copy the formula into `$(brew --repository cashsdkaudit/local)/Formula/`, run `brew audit --strict cashsdkaudit/local/cashsdk` and `brew style cashsdkaudit/local/cashsdk`, then `brew untap cashsdkaudit/local`.

```bash
brew audit --strict cashsdk/tap/cashsdk
brew install --build-from-source cashsdk/tap/cashsdk   # same version already installed: brew reinstall cashsdk
brew test cashsdk/tap/cashsdk
cashsdk version                                        # must print the new version
```
