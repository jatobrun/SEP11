FILENAME   = main
FILENAME2  = config
FILENAME3  = funciones
FILENAME4  = uart
PORT       = /dev/cu.usbserial-00000000
DEVICE     = atmega328p
PROGRAMMER = arduino
BAUD       = 115200
COMPILE    = avr-gcc -Wall -Os -mmcu=$(DEVICE)


default: compile upload clean

compile:
	$(COMPILE) -c $(FILENAME).c -o $(FILENAME).o
	$(COMPILE) -c $(FILENAME2).c -o $(FILENAME2).o
	$(COMPILE) -c $(FILENAME3).c -o $(FILENAME3).o
	$(COMPILE) -c $(FILENAME4).c -o $(FILENAME4).o
	$(COMPILE) -o $(FILENAME).elf $(FILENAME).o $(FILENAME2).o $(FILENAME3).o $(FILENAME4).o
	avr-objcopy -j .text -j .data -O ihex $(FILENAME).elf $(FILENAME).hex 
	avr-size --format=avr --mcu=$(DEVICE) $(FILENAME).elf

upload:
	avrdude -v -p $(DEVICE) -c $(PROGRAMMER) -P $(PORT) -b $(BAUD) -U flash:w:$(FILENAME).hex:i

clean:
	rm $(FILENAME).o
	rm $(FILENAME2).o
	rm $(FILENAME).elf
	rm $(FILENAME).hex