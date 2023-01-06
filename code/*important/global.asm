;define device
.device ATtiny44


;define constants
.equ PORTA = 0x1B
.equ PORTB = 0x18
.equ DDRA = 0x1A
.equ DDRB = 0x17
.equ PINA = 0x19
.equ PINB = 0x16

;all porta/portb registers
;these are just numbers and not binary values because in the code, we shift 1 bit left (or set the bit) by the PORTxn values. setting PORTA0 would be 1 << PORTA0
.equ PORTA0 = 0
.equ PORTA1 = 1
.equ PORTA2 = 2
.equ PORTA3 = 3
.equ PORTA4 = 4
.equ PORTA5 = 5
.equ PORTA6 = 6
.equ PORTA7 = 7
.equ PORTB0 = 0
.equ PORTB1 = 1
.equ PORTB2 = 2
.equ PORTB3 = 3

;all ddra/ddrb registers
.equ DDRA0 = 0b00000001
.equ DDRA1 = 0b00000010
.equ DDRA2 = 0b00000100
.equ DDRA3 = 0b00001000
.equ DDRA4 = 0b00010000
.equ DDRA5 = 0b00100000
.equ DDRA6 = 0b01000000
.equ DDRA7 = 0b10000000
.equ DDRB0 = 0b00000001
.equ DDRB1 = 0b00000010
.equ DDRB2 = 0b00000100
.equ DDRB3 = 0b00001000

;all pina/pinb registers
;same as porta/portb
.equ PINA0 = 0b00000001
.equ PINA1 = 0b00000010
.equ PINA2 = 0b00000100
.equ PINA3 = 0b00001000
.equ PINA4 = 0b00010000
.equ PINA5 = 0b00100000
.equ PINA6 = 0b01000000
.equ PINA7 = 0b10000000
.equ PINB0 = 0b00000001
.equ PINB1 = 0b00000010
.equ PINB2 = 0b00000100
.equ PINB3 = 0b00001000

.equ SREG = 0x3F ;mcu status register
.equ MCUCR = 0x35 ;mcu control register
.equ GIMSK = 0x3B ;general interrupt mask register
.equ GIFR = 0x3A ;general interrupt flags register
.equ PCMSK1 = 0x20 ;pin change mask register 1 (PORTB)
.equ PCMSK0 = 0x12 ;pin change mask register 0 (PORTA)

;sleep mode bits
;0b00000000 = idle mode
;0b00001000 = ADC noise reduction
;0b00010000 = power down (WARNING: only use when external oscillator is present)
;0b00011000 = standby (WARNING: only use when external oscillator is present)

;stack
.equ SPL = 0x3D ;stack pointer low
.equ RAMEND = 0xFF ;256 end of sram


;interrupt vectors                             ;vector addresses
rjmp RESET ; Reset Handler                     (0x0000)
rjmp INT0 ; IRQ0 Handler                       (0x0001)
rjmp PCINT0 ; PCINT0 Handler                   (0x0002)
rjmp PCINT1 ; PCINT1 Handler                   (0x0003)
rjmp WDT ; Watchdog Interrupt Handler          (0x0004)
rjmp TIM1_CAPT ; Timer1 Capture Handler        (0x0005)
rjmp TIM1_COMPA ; Timer1 Compare A Handler     (0x0006)
rjmp TIM1_COMPB ; Timer1 Compare B Handler     (0x0007)
rjmp TIM1_OVF ; Timer1 Overflow Handler        (0x0008)
rjmp TIM0_COMPA ; Timer0 Compare A Handler     (0x0009)
rjmp TIM0_COMPB ; Timer0 Compare B Handler     (0x000A)
rjmp TIM0_OVF ; Timer0 Overflow Handler        (0x000B)
rjmp ANA_COMP ; Analog Comparator Handler      (0x000C)
rjmp ADC ; ADC Conversion Handler              (0x000D)
rjmp EE_RDY ; EEPROM Ready Handler             (0x000E)
rjmp USI_STR ; USI STart Handler               (0x000F)
rjmp USI_OVF ; USI Overflow Handler            (0x0010)


;
;   NOTE: comment out all the interrupt labels currently being used in your program (the stuff below)
;


RESET:      cli ;disable interrupts for now
            ;initialize stack pointer
            ;only init spl because on smaller MCUs, there is only one ram byte
            ldi r16, RAMEND
            out SPL, r16
            ;jump to _start (enable interrupts later with sei if needed)
            rjmp _start

INT0:         reti
PCINT0:       reti
PCINT1:       reti
WDT:          reti
TIM1_CAPT:    reti
TIM1_COMPA:   reti
TIM1_COMPB:   reti
TIM1_OVF:     reti
TIM0_COMPA:   reti
TIM0_COMPB:   reti
TIM0_OVF:     reti
ANA_COMP:     reti
ADC:          reti
EE_RDY:       reti
USI_STR:      reti
USI_OVF:      reti



.equ PRR = 0x00 ;power reduction register
.equ ADCSRA = 0x06 ;ADC control and status register A
.equ ADCSRB = 0x03 ;ADC control and status register B
.equ ADMUX = 0x07 ;ADC multiplexer selection register
.equ ADCH = 0x05 ;ADC data register high
.equ ADCL = 0x04 ;ADC data register low



    

;to reset gpio if it isnt working
;sudo bash -c "for ((i=0; i<32; i++)); do echo \$i; echo in >/sys/class/gpio/gpio\$i/direction; echo \$i >/sys/class/gpio/unexport; done"
