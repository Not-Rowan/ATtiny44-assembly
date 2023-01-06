avra program.asm
avrdude -vvvv -p t44 -c usbasp -U flash:w:program.hex
#avrdude -vvvv -B 22 -p t44 -c usbtiny -U lfuse:w:0x62:m

