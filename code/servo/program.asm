.include "/full/path/to/code/*important/global.asm"

_start:

init:       ;init pin1 of A for output (pwm output)
            ldi r16, DDRA1
            out DDRA, r16

            ;when setting the DDRx register, 1 is defined as output and 0 is defined as an input. since im setting DDRA to 0b00000010 above that means the other pins are input (at the moment)
            ;be wary of this later because if you set another pin to output, it overwrites the last pin (all of DDRx). we do not need to worry about floating pins because they all have pull up resistors


            ;r27 is used as a toggle variable inside setReg
            ;ldi r27, 0x00 ;why the hell does this ruin it


main:       ;enable INT0 interrupt
            in r16, GIMSK
            sbr r16, 0b01000000
            out GIMSK, r16

            ;set interrupt sense control bits
            in r16, MCUCR
            cbr r16, 0b00000011
            out MCUCR, r16

            ;enable interrupts after setup
            sei



sleepy:     ;set sleep mode bits for power down mode
            in r16, MCUCR
            sbr r16, 0b00010000
            out MCUCR, r16
    
            ;enable sleep
            in r16, MCUCR
            sbr r16, 0b00100000
            out MCUCR, r16
            sleep

            ;disable sleep
            in r16, MCUCR
            cbr r16, 0b00100000
            out MCUCR, r16

            rjmp sleepy


INT0:       rcall setReg
            reti


setReg:     ;figure out how to make a toggle. rn im trying to flip the bits and then compare it against 0b00000000. each time this is called, the bits will either be set to 0b00000000 or 0b11111111
            cpi r27, 0x00
            breq set1
            brne set0


            set1:
            ldi r27, 0x01
            rcall pwm1
            rcall wait
            ret

            set0:
            ldi r27, 0x00
            rcall pwm2
            rcall wait
            ret


            ;pwm has a period of 20ms (20,000 usec)
            ;each period has 50 cycles so loop 50 times
            ;to set pwm to 600 usec, we first turn on a pin for 600 usec, then have it off for the on time minus the maximum period time (600(on time)-20000(period time) = off time) which is what we need to do to set it to the first position.



pwm1:       ;basically a for loop that runs 50 times
            ldi r20, 0x32
            firstLoop:

            ;set on time for 600 us (us600 label)
            sbi PORTA, PORTA1
            rcall us1000

            ;set off time for 19400 us (us19400 label)
            cbi PORTA, PORTA1
            rcall us19000

            dec r20
            brne firstLoop

            ret

pwm2:       ldi r20, 0x32
            secondLoop:

            sbi PORTA, PORTA1
            rcall us1500
            cbi PORTA, PORTA1
            rcall us18500

            dec r20
            brne secondLoop

            ret



us1000:     ;1000/4 = 250 (0xFA)
            ldi r31, 0xFA

            loop1:
            dec r31
            nop
            brne loop1

            ret

us19000:    ldi r31, 0xFA
            ldi r30, 0x13

            loop2:
            dec r31
            nop
            brne loop2
            dec r30
            nop
            brne loop2

            ret

us1500:     ldi r31, 0x7D
            ldi r30, 0x03

            loop3:
            dec r31
            nop
            brne loop3
            dec r30
            nop
            brne loop3

            ret

us18500:    ldi r31, 0xB9
            ldi r30, 0x19

            loop4:
            dec r31
            nop
            brne loop4
            dec r30
            nop
            brne loop4

            ret


wait:       ldi r31, 0xFA
            ldi r30, 0xFA
            ldi r29, 0x04

waitLoop:   dec r31
            nop
            brne waitLoop
            dec r30
            nop
            brne waitLoop
            dec r29
            nop
            brne waitLoop

            ret


