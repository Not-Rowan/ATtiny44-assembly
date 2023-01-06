.include "/full/path/to/code/*important/global.asm"

            ;turn led on or off depending on button press status

            ;when setting ddrx, 0 indicates input and 1 indicates output. because of that, i can just set the led pin and everything else is set as an input. (DDRA0 = 0b00000001)

init:       ldi r16, DDRA1
            out DDRA, r16

main:       ;read PINA into r20
            in r20, PINA

            ;and the PINA input with PINA0 to check if on
            ldi r21, 0b00000001
            and r21, r20

            ;compare parsed register value and check if 1 or 0
            ldi r22, 0b00000001
            cp r21, r22

            breq on
            brne off

exit1:      rjmp main

on:         sbi PORTA, PORTA1
            ret

off:        cbi PORTA, PORTA1
            ret
