#!/bin/bash
cd 
/Applications/Xcode.app/Contents/Developer/usr/bin/appleProductTypesTool -placeholderAppIconEnumName car -appIconAssetName __PlaceholderAppIcon -generatePlaceholderAppIconAsset -accentColorPresetName teal -accentColorAssetName __PresetAccentColor -generateAccentColorAsset -output "$DERIVED_FILE_DIR/GeneratedAssetCatalog.xcassets"

