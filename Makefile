prepare-certificates-for-travis:
	security create-keychain -p travis ios-build.keychain
	security default-keychain -s ios-build.keychain
	security unlock-keychain -p travis ios-build.keychain
	security set-keychain-settings -t 3600 -l ~/Library/Keychains/ios-build.keychain
	curl -O https://www.apple.com/certificateauthority/AppleWWDRCAG3.cer
	security import AppleWWDRCAG3.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
	security list-keychains -s ios-build.keychain
	fastlane match adhoc --readonly --git_branch main --keychain_name ios-build.keychain --keychain_password travis

clean-certificates-for-travis:
	security delete-keychain ios-build.keychain
