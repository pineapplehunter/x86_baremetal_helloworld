all: img

img: main.img

main.img: main.elf
	objcopy -O binary main.elf $@

entry.o: entry.S
	as -ggdb3 --32 -o entry.o entry.S

main.o: main.c
	gcc -c -ggdb3 -m16 -ffreestanding -fno-PIE -nostartfiles -nostdlib -o main.o -std=c99 main.c

main.elf: main.o entry.o
	ld -m elf_i386 -o main.elf -T linker.ld entry.o main.o

run:
	qemu-system-x86_64 -drive file=main.img,format=raw

clean:
	rm -rf *.o *.elf *.img
