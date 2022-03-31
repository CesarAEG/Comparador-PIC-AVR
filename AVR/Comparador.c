/*
 * Comparador.c
 *
 * Created: 19/09/2018 05:46:03 p. m.
 *  Author: César
 */ 


#include <avr/io.h>
int	a=0;
int	b=0;
int	c=0;

int main(void)
{
	DDRB=0b00000000;
    DDRC=0b00000111;
	
	while(1)
    {
		a=PINB;
		b=a & 0b00001111;
		a=a>>4;
		c=a & 0b00001111;
		
		if(b-c<0)
			PORTC=0b00000001;
		if(b-c>0)
			PORTC=0b00000100;
		if(b-c==0)
			PORTC=0b00000010;
    }
}