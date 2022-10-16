install:
	@git submodule update --init --recursive

update:
	@forge update

build:
	@scripts/build.sh

release:
	@scripts/release.sh

clean:
	@forge clean
