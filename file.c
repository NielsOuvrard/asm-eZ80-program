#include <ti/screen.h>
#include <ti/getcsc.h>
#include <debug.h>

// D1AA15
int main(void)
{

    os_ClrHome();
    asm("ld	a, 0");
    asm("ld	h, 0"); // D1AA26

// D1AA40     DD36F661      ld (ix-$0A),$61
// D1AA44     DD36F700      ld (ix-$09),$00
// D1AA48     DD36F863      ld (ix-$08),$63
// D1AA4C     2170AAD1      ld hl,_.str|$D1AA70
// D1AA50     E5            push hl
// D1AA51     CD2C1D02      call os.PutStrFull|_os_PutStrFull
// D1AA55     E1            pop hl
// D1AA56     ED65F6        pea ix-$0A
// D1AA59     CD2C1D02      call os.PutStrFull|_os_PutStrFull
// D1AA5D     E1            pop hl
// D1AA5E     2177AAD1      ld hl,_.str.1|$D1AA77
// D1AA62     E5            push hl
// D1AA63     CD2C1D02      call os.PutStrFull|_os_PutStrFull
// D1AA67     E1            pop hl
// D1AA68     B7            or a,a
// D1AA69     ED62          sbc hl,hl
// D1AA6B     DDF9          ld sp,ix
// D1AA6D     DDE1          pop ix
// D1AA6F     C9            ret 

    float value = 3.14;
    char str[10];
    int var = 10;
    char buffer[10];
    dbg_printf("-val- %d\n", var);
    buffer[0] = 'a';
    buffer[1] = 0;
    buffer[2] = 'c';
    while (1) {
        dbg_printf("-%d\n", var);
        if (var > 1000000)
            goto end;
        // os_PutStrFull("A");
        var++;
    }
end:
    os_PutStrFull("Hello ");
    os_PutStrFull(buffer);
    os_PutStrFull(".");
    return 0;
}
