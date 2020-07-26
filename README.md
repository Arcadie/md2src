# Mardown to Source

Simple rust binary to extract code blocks marked with triple backticks from markdown files into source files.

[![Build Status](https://github.com/alexanderwillner/md2src/workflows/Build-Test/badge.svg)](https://github.com/AlexanderWillner/md2src/actions) [![Coverage Status](https://coveralls.io/repos/github/AlexanderWillner/md2src/badge.svg?branch=master)](https://coveralls.io/github/AlexanderWillner/md2src?branch=master) ![Crates.io](https://img.shields.io/crates/d/md2src)

## Installation

To download the latest release, please run ```cargo install md2src```.

## Example

Run run ```md2src``` (or ```cargo run```) to create the source files named ```codeXXX.ext```.

## Todo

Please note, that the current version is just a a proof of concept / minimal valuable product state. Things planned:

- Implement CLI: input name, output name, languages, ignore string, ...
- Vector of tuple with language / extension combinations
