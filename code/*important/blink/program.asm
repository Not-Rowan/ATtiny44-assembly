.include "/full/path/to/code/*important/global.asm"

init:       ;load proper ddra register with proper bit
            ldi r16, DDRA0
            out DDRA, r16

loop:       sbi PORTA, PORTA0 ;set porta bit
            rcall delay
            cbi PORTA, PORTA0 ;clear porta bit
            rcall delay
            rjmp loop


            ; 1 sec delay
            ;
            ; to calulate delay:
            ;
            ; divide clock speed by amount of clock cycles each loop takes (eg: 1mhz = 1,000,000 cycles. each loop is 4 cycles (dec = 1, nop = 1, brne = 2 or 1 if not branching) so 1 mil divided by 4 is 250,000)
            ;
            ; find greatest common divisor (within an 8-bit range. 1-256) and divide it by the result of the last routine. (for 1mhz: 250,000 / 250 = 1,000. take that and find the greatest common divisor of that: 1,000 / 250 = 4. -->
            ; --> so then the register values should be r31 = 250, r30 = 250, r29 = 4)
            ;
            ; now you have the basic structure of the delay loop (example below)

delay:      ldi r29, 0x04
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

