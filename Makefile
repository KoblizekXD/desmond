.PHONY: build

build:
	echo "Building project..."
	if [ -d "./build" ]; then \
		rm -rf ./build; \
	fi
	mkdir build
	nasm -f bin -o build/boot.bin src/boot.asm
	dd if=/dev/zero of=build/disk.img bs=512 count=2880
	dd conv=notrunc if=build/boot.bin of=build/disk.img bs=512
qemu: build
	qemu-system-i386 -drive format=raw,file=build/disk.img -machine q35