# Mardown to Source

Simple rust library and CLI to extract code blocks marked with triple backticks from markdown files into source files.

[![Build Status](https://github.com/alexanderwillner/md2src/workflows/Build-Test/badge.svg)](https://github.com/AlexanderWillner/md2src/actions) [![Coverage Status](https://coveralls.io/repos/github/AlexanderWillner/md2src/badge.svg?branch=master)](https://coveralls.io/github/AlexanderWillner/md2src?branch=master) [![Crates.io](https://img.shields.io/crates/d/md2src?label=crate%20downloads)](https://crates.io/crates/md2src) [![download](https://img.shields.io/github/downloads/AlexanderWillner/md2src/total?label=binary%20downloads)](https://github.com/AlexanderWillner/md2src/releases)

## Installation

To download the latest release, please run either ```cargo install md2src``` or ```brew install AlexanderWillner/tap/md2src```.

## Example

Run run ```md2src README.md``` to create the source file named ```code_snippet_000.rs``` from the following code:

```rust
fn main() {
    todo!();
}
```

## Help

```bash
$ md2src --help
md2src 1.1.0
Alexander Willner <alex@willner.ws>
Markdown to source. Extracts code blocks marked with triple backticks into files.

USAGE:
    md2src [OPTIONS] <filename> [--] [folder]

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -e, --extension <extension>    File extension for code files [default: rs]
    -l, --language <language>      Code snippet language to extract [default: rust]
    -p, --prefix <prefix>          Prefix code files with this string [default: code_snippet_]
    -i, --ignore <string>...       Ignore code with this string [default: // (note: this does not compile)]

ARGS:
    <filename>    Markdown file that contains the code snippets
    <folder>      Folder for the code snippets [default: .]
```
