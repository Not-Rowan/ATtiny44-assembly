.include "/full/path/to/code/*important/global.asm"

_start:     ;set PORTA0 to output
            ldi r16, DDRA1
            out DDRA, r16


            ;enable interrupts on INT0
            in r16, GIMSK ;load contents of gimsk to r16
            sbr r16, 0b01000000 ;set 6th bit
            out GIMSK, r16

            ;set interrupt sense control bits (only for int0)
            in r16, MCUCR
            cbr r16, 0b00000011 ;clear 0th and 1st bit
            out MCUCR, r16

            ;enable interrupts now that our setup is complete
            sei

loop:       rcall startSleep
            ;interrupts are now enabled on INT0 so just loop until an interrupt is triggered
            rjmp loop

startSleep: ;set sleep mode bits for idle mode
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
            ret

            ;handle interrupt on PORTA
INT0:       sbi PORTA, PORTA1
            rcall delay
            cbi PORTA, PORTA1

            ;return from interrupt
            RETI



delay:      ldi r29, 0x01
            ldi r30, 0xFA
            ldi r31, 0xFA

delayLoop:  dec r31
            nop
            brne delayLoop
            dec r30
            nop
            brne delayLoop
            dec r29
            nop
            brne delayLoop
            ret

