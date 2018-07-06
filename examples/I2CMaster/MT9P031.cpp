#include "MT9P031.h"

#include <stdio.h>

MT9P031::MT9P031(I2CMaster* i2c)
{
	m_i2c = i2c;
}

unsigned int MT9P031::readRegister(int v)
{
	short c;
	m_i2c->readWord(I2C_ADDRESS, v, &c);
	return ((unsigned int)c) & 0xFFFF;
}

void MT9P031::writeRegister(int r, unsigned int v)
{
	m_i2c->writeWord(I2C_ADDRESS, r, v);
}


void MT9P031::setRowAddressMode(int bin, int skip)
{
    writeRegister(MT9P031_REG_ROW_ADDRESS_MODE, (bin << 4) | skip);
}
    
void MT9P031::setColumnAddressMode(int bin, int skip)
{
    writeRegister(MT9P031_REG_COLUMN_ADDRESS_MODE, (bin << 4) | skip);
}

void MT9P031::setGlobalGain(int digitalGain, int analogMultiplier, int analogGain)
{
    writeRegister(MT9P031_REG_GLOBAL_GAIN, digitalGain << 8 | analogMultiplier << 6 | analogGain);
}

void MT9P031::setShutterDelay(int delay)
{
    writeRegister(MT9P031_REG_SHUTTER_DELAY, delay);
}

void MT9P031::setColumnStart(int v)
{
    writeRegister(MT9P031_REG_COLUMN_START, v);
}

void MT9P031::setRowStart(int v)
{
    writeRegister(MT9P031_REG_ROW_START, v);
}

void MT9P031::setPixelClockControl(int invertPixelClock, int shiftPixelClock, int dividePixelClock)
{
    writeRegister(MT9P031_REG_PIXEL_CLOCK_CONTROL, (invertPixelClock << 15) | (shiftPixelClock << 8) | dividePixelClock );
}

void MT9P031::setVGA()
{
    setColumnStart(0x10); // MT9P031_FULL_RESOLUTION_X - 640*4);
    setRowStart(0x36);  // MT9P031_FULL_RESOLUTION_Y - 480*4);
    setRowSize(0x3bf);      // 480*4-1);
    setColumnSize(0x4ff);   // 640*4-1);
    setShutterWidth(0x7d0); // 20); //480-1);
    
    setColumnAddressMode(0, 0); //3, 3);
    setRowAddressMode(0, 0); // 3, 3);
    
}
        
void MT9P031::setRowSize(int size)
{
    writeRegister(MT9P031_REG_ROW_SIZE, size);
}

void MT9P031::setColumnSize(int size)
{
    writeRegister(MT9P031_REG_COLUMN_SIZE, size);
}
        
void MT9P031::setShutterWidth(int w)
{
    writeRegister(MT9P031_REG_SHUTTER_WIDTH_UPPER, (w >> 16) & 0xFFFF);
    writeRegister(MT9P031_REG_SHUTTER_WIDTH_LOWER, w & 0xFFFF);
}

void MT9P031::setReadMode(int xorLineValid, int continuousLineValid, 
        int invertTrigger, int snapshot, int globalReset, int bulbExposure,
        int invertStrobe, int strobeEnable, int strobeStart, int strobeEnd,
        int mirrorRow, int mirrorColumn, int showDarkColumns, int showDarkRows,
        int rowBlackLevelCompensation, int columnSum)
{
    unsigned int v = 0x4000;
    v |= ((xorLineValid)? 0x0800 : 0);
    v |= ((continuousLineValid)? 0x0400 : 0); 
    v |= ((invertTrigger)? 0x0200 : 0);
    v |= ((snapshot)? 0x0100 : 0);
    v |= ((globalReset)? 0x0080 : 0);
    v |= ((bulbExposure)? 0x0040 : 0);
    v |= ((invertStrobe)? 0x0020 : 0);
    v |= ((strobeEnable)? 0x0010 : 0);
    v |= (strobeStart & 0x3) << 2;
    v |= (strobeEnd & 0x3);
    
    writeRegister(MT9P031_REG_READ_MODE1, v);
    
    v = (mirrorRow)?        0x8000 : 0;
    v |= (mirrorColumn)?    0x4000 : 0;
    v |= (showDarkColumns)? 0x1000 : 0;
    v |= (showDarkRows)?    0x0800 : 0;
    v |= (rowBlackLevelCompensation)? 0x0020 : 0;
    v |= (columnSum)?       0x0010 : 0;
    
    writeRegister(MT9P031_REG_READ_MODE2, v);
}

void MT9P031::dumpRegisters()
{
	printf("-----------------------------\n");
	printf(" MT9P031 Registers \n");
	printf("-----------------------------\n");
	printf("[%2d] Chip Version: 		0x%04X\n", 0, readRegister(0));
	printf("[%2d] Row Start:    		0x%04X\n", MT9P031_REG_ROW_START, readRegister(MT9P031_REG_ROW_START));
	printf("[%2d] Column Start: 		0x%04X\n", MT9P031_REG_COLUMN_START, readRegister(MT9P031_REG_COLUMN_START));
	printf("[%2d] Row Size:     		0x%04X\n", MT9P031_REG_ROW_SIZE, readRegister(MT9P031_REG_ROW_SIZE));
	printf("[%2d] Column Size:  		0x%04X\n", MT9P031_REG_COLUMN_SIZE, readRegister(MT9P031_REG_COLUMN_SIZE));
	printf("[%2d] Horizontal Blank:          0x%04X\n", 5, readRegister(5));
	printf("[%2d] Vertical Blank:		0x%04X\n", 6, readRegister(6));
	printf("[%2d] Output Control:		0x%04X\n", MT9P031_REG_OUTPUT_CONTROL, readRegister(MT9P031_REG_OUTPUT_CONTROL));
	printf("[%2d] Shutter Width Upper:	0x%04X\n", 8,readRegister(8));
	printf("[%2d] Shutter Width Lower:	0x%04X\n", 9, readRegister(9));
        printf("[%2d] Pixel Clock Control:	0x%04X\n", MT9P031_REG_PIXEL_CLOCK_CONTROL, readRegister(MT9P031_REG_PIXEL_CLOCK_CONTROL));
	printf("[%2d] Shutter Delay:             0x%04X\n", MT9P031_REG_SHUTTER_DELAY, readRegister(MT9P031_REG_SHUTTER_DELAY));
        printf("[%2d] PLL Control:               0x%04X\n", 0x10, readRegister(0x10));
        printf("[%2d] PLL Config 1:      	0x%04X\n", 0x11, readRegister(0x11));
        printf("[%2d] PLL Config 2:              0x%04X\n", 0x12, readRegister(0x12));
	printf("[%2d] Read Mode 1:		0x%04X\n", 0x1e, readRegister(0x1e));
	printf("[%2d] Read Mode 2:		0x%04X\n", 0x20, readRegister(0x20));
	printf("[%2d] Row Address Mode:		0x%04X\n", MT9P031_REG_ROW_ADDRESS_MODE, readRegister(MT9P031_REG_ROW_ADDRESS_MODE));
	printf("[%2d] Column Address Mode:	0x%04X\n", MT9P031_REG_COLUMN_ADDRESS_MODE, readRegister(MT9P031_REG_COLUMN_ADDRESS_MODE));
	printf("[%2d] Red Gain:  		0x%04X\n", 0x2d, readRegister(0x2d));
	printf("[%2d] Green 1 Gain:		0x%04X\n", 0x2b, readRegister(0x2b));
	printf("[%2d] Green 2 Gain:		0x%04X\n", 0x2e, readRegister(0x2e));
	printf("[%2d] Blue Gain:    		0x%04X\n", 0x2c, readRegister(0x2C));
	printf("[%2d] Global Gain:		0x%04X\n", MT9P031_REG_GLOBAL_GAIN, readRegister(MT9P031_REG_GLOBAL_GAIN));
	
}