prepare-certificates-for-travis:
	security create-keychain -p travis ios-build.keychain
	security default-keychain -s ios-build.keychain
	security unlock-keychain -p travis ios-build.keychain
	security set-keychain-settings -t 3600 -l ~/Library/Keychains/ios-build.keychain
	fastlane match adhoc --readonly

clean-certificates-for-travis:
	security delete-keychain ios-build.keychain
