.PHONY: all 01-partial 02-full 03-full-no-user

.NOTPARALLEL:

all: 01-partial 02-full 03-full-no-user

01-partial: 01-partial/output/bootiso/install.iso
01-partial/output/bootiso/install.iso: 01-partial/config.toml build.sh
	./build.sh 01-partial

02-full: 02-full/output/bootiso/install.iso
02-full/output/bootiso/install.iso: 02-full/config.toml build.sh
	./build.sh 02-full

03-full-no-user: 03-full-no-user/output/bootiso/install.iso
03-full-no-user/output/bootiso/install.iso: 03-full-no-user/config.toml build.sh
	./build.sh 03-full-no-user
