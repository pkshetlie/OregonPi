
all: bin/receive bin/transmit

bin/transmit: build/RCSwitch.o build/RcOok.o build/Sensor.o build/transmit.o
	g++ -o bin/emmet build/RCSwitch.o build/RcOok.o build/Sensor.o build/emmet.o  -I/usr/local/include -L/usr/local/lib -lwiringPi


bin/receive: build/RCSwitch.o build/RcOok.o build/Sensor.o build/receive.o
	g++ -o bin/receive build/RCSwitch.o build/RcOok.o build/Sensor.o build/receive.o  -I/usr/local/include -L/usr/local/lib -lwiringPi

clean:
	rm build/*.o bin/receive bin/transmit

build/transmit.o: src/transmit.cpp
	g++ -o build/emmet.o -c src/transmit.cpp

build/receive.o: src/receive.cpp
	g++ -o build/receive.o -c src/receive.cpp

build/Sensor.o: src/libs/Sensor.cpp src/libs/Sensor.h
	g++ -o build/Sensor.o -c src/libs/Sensor.cpp -I/usr/local/include -L/usr/local/lib -lwiringPi

build/RcOok.o: src/libs/RcOok.cpp src/libs/RcOok.h
	g++ -o build/RcOok.o -c src/libs/RcOok.cpp -I/usr/local/include -L/usr/local/lib -lwiringPi

build/RCSwitch.o: src/libs/RCSwitch.cpp src/libs/RCSwitch.h
	g++ -o build/RCSwitch.o -c src/libs/RCSwitch.cpp -I/usr/local/include -L/usr/local/lib -lwiringPi
