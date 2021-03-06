###############################################################################
# Make file to setup and test a rust project.
#
# Author: Alexander Willner
# License : MIT or Apache 2.0
###############################################################################

# Config
TARGET=target/debug/
TARGET_HTML=html
NAME=$(shell grep -E "^name" Cargo.toml|head -n1|awk -F'"' '$$0=$$2')
VERSION=$(shell grep -E "^version" Cargo.toml|head -n1|awk -F'"' '$$0=$$2')

.PHONY: help license copyright test

help: ## Print help for each target
	$(info $(NAME) Makefile (v$(VERSION)))
	$(info )
	$(info Available commands:)
	$(info )
	@grep '^[[:alnum:]_-]*:.* ##' $(MAKEFILE_LIST) \
        | sort | awk 'BEGIN {FS=":.* ## "}; {printf "%-25s %s\n", $$1, $$2};'
	
compile: check-setup ## Run compiler
	@cargo build

run: ## Run example code
	@RUST_BACKTRACE=full RUST_LOG=info cargo run

clean: ## Run cleanup
	@rm -rf "$(TARGET_HTML)"
	@cargo clean

check-setup:
	@type rustup >/dev/null 2>&1 || (echo "Run 'curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh' first." >&2 ; exit 1)
	@type rustc >/dev/null 2>&1 || (echo "Run 'curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh' first." >&2 ; exit 1)

coverage: ## Run code coverage generation
	@type grcov >/dev/null 2>&1 || (echo "Run 'cargo install grcov' first." >&2 ; exit 1)
	@cargo clean
	@CARGO_INCREMENTAL=0 RUSTFLAGS="-Zprofile -Ccodegen-units=1 -Copt-level=0 -Clink-dead-code -Coverflow-checks=off -Zpanic_abort_tests -Cpanic=abort" cargo build
	@CARGO_INCREMENTAL=0 RUSTFLAGS="-Zprofile -Ccodegen-units=1 -Copt-level=0 -Clink-dead-code -Coverflow-checks=off -Zpanic_abort_tests -Cpanic=abort" cargo test
	@grcov $(TARGET) -t html --ignore "/*" -s . --llvm --branch --ignore-not-existing -o $(TARGET_HTML)
	@echo "Result saved to the '$(TARGET_HTML)' folder"

test: ## Run dynamic tests
	@cargo test

license: ## Run analyzis of used licenses
	@type cargo-license >/dev/null 2>&1 || (echo "Run 'cargo install cargo-license' first." >&2 ; exit 1)
	@cargo-license

lint: ## Run static tests
	@cargo fix
	@cargo clippy --fix -Z unstable-options
	@cargo clippy --all-targets --all-features -- -D warnings

test-fuzzy: ## Run fuzzy tests
	$(info Todo: setup cargo-fuzz)
	@true

style: ## Run style code
	@cargo fmt

doc: ## Generate documentation
	@cargo doc --no-deps --open

copyright: ## Add copyright information to each file
	@find . -iname "*.rs" -exec bash -c "if ! grep -q Copyright "{}"; then cat COPYRIGHT {} > {}.new && mv {}.new {} ; fi" \;

feedback: ## Provide feedback
	@open https://github.com/alexanderwillner/$(NAME)/issues

install: ## Install the binary
	@cargo install --path .

release: test
	@git status
	@echo "Press enter to release $(NAME) v$(VERSION)..."	
	@read
	@cargo build --release
	@cargo publish
	@cd target/release && tar -czf $(NAME)-$(VERSION)-mac.tar.gz $(NAME)
	@shasum -a 256 target/release/$(NAME)-$(VERSION)-mac.tar.gz
	@open .
	@open ../homebrew-tap
	@hub release create -a target/release/$(NAME)-$(VERSION)-mac.tar.gz -m '$(VERSION)' v$(VERSION)
	@open https://github.com/AlexanderWillner/$(NAME)/releases/
