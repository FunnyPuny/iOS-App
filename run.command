# find the directory where the executable script file is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

# go to it
cd "$DIR"

# install SwiftLint, if needed
brew install swiftlint

# install SwiftFormat, if needed
brew install swiftformat

# install Periphery, if needed
brew install periphery

# install SwiftGen, if needed
brew install swiftgen

# create SwiftGen generated files and perform initial initialization
function mkdir_touch {
  mkdir -p "$(dirname "$1")"
  command touch "$1"
}

mkdir_touch FunnyPuny/Generated/Assets.swift
mkdir_touch FunnyPuny/Generated/Texts.swift

swiftgen config run