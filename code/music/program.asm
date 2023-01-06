.include "/full/path/to/code/*important/global.asm"

init:       ldi r16, DDRA0
            out DDRA, r16

main:       sbi PORTA, PORTA0

            rcall playD6
            rcall wait
            rcall wait

            rcall playD6
            rcall wait

            rcall playF6
            rcall wait

            rcall playG6
            rcall wait

            rcall playGSharp6
            rcall wait

            rcall playG6
            rcall wait

            rcall playF6
            rcall wait

            rcall playD6
            rcall wait
            rcall wait
            rcall wait

            rcall playC6

            rcall playE6

            rcall playD6
            rcall wait
            rcall wait
            rcall wait

            rcall playA5

            rcall playD6
            rcall wait
            rcall wait

            rcall playD6
            rcall wait

            rcall playF6
            rcall wait

            rcall playG6
            rcall wait

            rcall playGSharp6
            rcall wait

            rcall playG6
            rcall wait

            rcall playF6
            rcall wait

            rcall playGSharp6
            rcall wait
            rcall wait
            rcall wait
            rcall wait

            rcall playGSharp6
            rcall wait

            rcall playG6
            rcall wait

            rcall playF6
            rcall wait

            rcall playGSharp6
            rcall wait

            rcall playG6
            rcall wait

            rcall playF6
            rcall wait

            rcall playD6
            rcall wait
            rcall wait
            rcall wait
            rcall wait
            rcall wait
            rjmp main


playA5:     ldi r20, 0xDC

wait1:      sbi PORTA, PORTA0

            ;wait 568 microseconds
            ldi r31, 0x8E

waitLoop1:  dec r31
            nop
            brne waitLoop1

            cbi PORTA, PORTA0

            ;wait another 568 microseconds
            ldi r31, 0x8E

waitLoop2:   dec r31

            nop
            brne waitLoop2



            dec r20
            nop
            brne wait1

            ret


playB5:     ldi r20, 0xF7

wait2:      sbi PORTA, PORTA0

            ;wait 506 microseconds
            ldi r31, 0x2E

waitLoop3:  dec r31
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            brne waitLoop3

            cbi PORTA, PORTA0

            ;wait another 506 microseconds
            ldi r31, 0x2E

waitLoop4:  dec r31
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            brne waitLoop4


            dec r20
            nop
            brne wait2

            ret



playC6:     ldi r20, 0x83

wait3:      sbi PORTA, PORTA0

            ;wait 477 microseconds
            ldi r31, 0x9F

waitLoop5:  dec r31
            brne waitLoop5

            cbi PORTA, PORTA0

            ;wait another 477 microseconds
            ldi r31, 0x9F

waitLoop6:  dec r31
            brne waitLoop6


            dec r20
            nop
            nop
            nop
            nop
            nop
            brne wait3

            ret



playD6:     ldi r20, 0xC4

wait4:      sbi PORTA, PORTA0

            ;wait 425 microseconds
            ldi r31, 0x55

waitLoop7:  dec r31
            nop
            nop
            brne waitLoop7

            cbi PORTA, PORTA0

            ;wait another 425 microseconds
            ldi r31, 0x55

waitLoop8:  dec r31
            nop
            nop
            brne waitLoop8


            dec r20
            nop
            nop
            nop
            brne wait4

            ret



playE6:     ldi r20, 0xDB

wait5:      sbi PORTA, PORTA0

            ;wait 380 microseconds
            ldi r31, 0x5F

waitLoop9:  dec r31
            nop
            brne waitLoop9

            cbi PORTA, PORTA0

            ;wait another 380 microseconds
            ldi r31, 0x5F

waitLoop10: dec r31
            nop
            brne waitLoop10


            dec r20
            nop
            nop
            nop
            brne wait5

            ret



playF6:     ldi r20, 0xC8

wait6:      sbi PORTA, PORTA0

            ;wait 357 microseconds
            ldi r31, 0x77

            waitLoop11:
            dec r31
            brne waitLoop11

            cbi PORTA, PORTA0

            ;wait another 357 microseconds
            ldi r31, 0x77

waitLoop12: dec r31
            brne waitLoop12


            dec r20
            nop
            nop
            nop
            nop
            brne wait6

            ret



playG6:     ldi r20, 0x8E

wait7:      sbi PORTA, PORTA0

            ;wait 320 microseconds
            ldi r31, 0x50

waitLoop13: dec r31
            nop
            brne waitLoop13

            cbi PORTA, PORTA0

            ;wait another 320 microseconds
            ldi r31, 0x50

waitLoop14: dec r31
            nop
            brne waitLoop14


            dec r20
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            brne wait7

            ret


playGSharp6:ldi r20, 0x97

wait8:      sbi PORTA, PORTA0

            ;wait 301 microseconds
            ldi r31, 0x2B

waitLoop15: dec r31
            nop
            nop
            nop
            nop
            brne waitLoop15

            cbi PORTA, PORTA0

            ;wait another 301 microseconds
            ldi r31, 0x2B

waitLoop16: dec r31
            nop
            nop
            nop
            nop
            brne waitLoop16


            dec r20
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            nop
            brne wait8

            ret




wait:       ldi r17, 0xC8
            ldi r18, 0xFA

wait0:      dec r18
            nop
            brne wait0
            dec r17
            nop
            brne wait0

            ret
