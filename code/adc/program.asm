.include "/full/path/to/code/*important/global.asm"

_start:     ;enable pin1 for output
            ldi r16, DDRA1
            out DDRA, r16

             ;disable the PRADC bit (making sure adc is enabled)
            in r16, PRR
            cbr r16, 0b00000001
            out PRR, r16

            ;set adc enable bit
            in r16, ADCSRA
            sbr r16, 0b10000000
            out ADCSRA, r16

            ;select reference voltage (vcc) and select PA0 as adc input
            in r16, ADMUX
            cbr r16, 0b11111111
            out ADMUX, r16

            ;left adjust the adc registers because 8-bit precision is fine and also set to free running mode
            in r16, ADCSRB
            sbr r16, 0b00010000
            out ADCSRB, r16

            ;set adc conversation bit and enable auto trigger mode
            in r16, ADCSRA
            sbr r16, 0b01100000
            out ADCSRA, r16
    
            
jump:       
            ;read the adc value from ADC high register and branch based on result
            in r16, ADCH
            cpi r16, 0b10010000
            brlo lower
            brsh higher
            
            rjmp jump


lower:      cbi PORTA, PORTA1
            ret

higher:     sbi PORTA, PORTA1
            ret

