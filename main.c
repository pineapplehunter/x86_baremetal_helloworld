void print(char *str) {
    while(*str) {
        __asm__ ("int $0x10" : : "a" ((0x0e << 8) | *(str++)));
    }
}

void main(void) {
    char *hello = "Hello World!";
    
    print(hello);
}
