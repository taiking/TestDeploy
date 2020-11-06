prepare-certificates-for-travis:
	openssl aes-256-cbc -K $${encrypted_3b9f0b9d36d1_key} -iv $${encrypted_3b9f0b9d36d1_iv} -in secrets.tar.enc -out secrets.tar -d
	tar xvf secrets.tar
	security create-keychain -p travis ios-build.keychain
	security default-keychain -s ios-build.keychain
	security unlock-keychain -p travis ios-build.keychain
	security set-keychain-settings -t 3600 -l ~/Library/Keychains/ios-build.keychain
	security import wwdrg3.der -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
	security import dist.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
	security import dist.p12 -k ~/Library/Keychains/ios-build.keychain -P '' -T /usr/bin/codesign
	security set-key-partition-list -S apple-tool:,apple: -s -k travis ios-build.keychain
	# mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
	# cp certificates/dist.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/
	security list-keychains -s ios-build.keychain
	# security verify-cert -c dist.cer

clean-certificates-for-travis:
	security delete-keychain ios-build.keychain
