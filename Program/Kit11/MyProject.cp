#line 1 "D:/ArtrOnix/Artronix I/underground station/Program/Kit11/MyProject.c"
 sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D4 at RB0_bit;


sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D7_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB0_bit;


sbit CE at rc0_bit;
sbit CSN at rc1_bit;
sbit CSK at rc2_bit;
sbit MOSI at rc3_bit;
sbit MISO at rc4_bit;


sbit CE_DIR at TRISC0_BIT;
sbit CSN_DIR at TRISC1_BIT;
sbit CSK_DIR at TRISC2_BIT;
sbit MOSI_DIR at TRISC3_BIT;
sbit MISO_DIR at TRISC4_BIT;



char rw_register(char add)
{
char rec=0;
char cou;
for(cou=0;cou<8;cou++)
 {
 MOSI=(add&0x80)>>7;
 add=add<<1;
 rec=rec<<1;
 CSK=1;
 rec|=MISO;
 CSK=0;
 }
return rec;
}

char read_add(char add)
{
char value;
CSN=0;
delay_us(10);
rw_register(add);
value=rw_register(0xFF);
CSN=1;
delay_us(10);
return value;
}

char write_add(char add,char value)
{
char status;
add=add|0b00100000;
CSN=0;
delay_us(10);
status=rw_register(add);
rw_register(value);
CSN=1;
delay_us(10);
return value;
}


void read_buff(char add,char buffer[],char bytes)
{
char counter;
CSN=0;
delay_us(10);
rw_register(add);
for(counter=0;counter<bytes;counter++)
{
buffer[counter]=rw_register(0xFF);
}
CSN=1;
delay_us(10);
}

void write_buff(char add,char buffer[],char bytes)
{
char counter;
CSN=0;
delay_us(10);
add=add|0b00100000;
rw_register(add);
for(counter=0;counter<bytes;counter++)
{
rw_register(buffer[counter]);
}
CSN=1;
delay_us(10);
}

void write_tx(char add,char buffer[],char bytes)
{
char counter;
CSN=0;
delay_us(10);
rw_register(add);
for(counter=0;counter<bytes;counter++)
{
rw_register(buffer[counter]);
}
CSN=1;
delay_us(10);
}

void nrf24_config()
{
char add1[5]={'a','a','a','a','a'};
CSN=0;
CE=0;
delay_ms(20);

write_add(0x01,0x3f);
write_add(0x02,0x03);
write_add(0x03,0x03);
write_add(0x04,0x4f);
write_add(0x05,0x4c);
write_add(0x06,0x07);
write_add(0x11,0x20);
write_add(0x1C,0x00);
write_add(0x1D,0x00);
write_add(0x00,0x0f);
write_add(0x00,0x0f);
delay_ms(5);

CSN=1;
CE=1;
delay_ms(20);



}

void reset()
{
write_add(0x07,0x7E);
read_add(0xE1);
read_add(0xE2);
}
#line 163 "D:/ArtrOnix/Artronix I/underground station/Program/Kit11/MyProject.c"
 void main()
 {
 int ldr1,ldr2,ldr1_p,ldr2_p, v, t,count ;
 char tx[7], a,b;
 int i;
int temp1;
char test[32];

CE_DIR=0;
CSN_DIR=0;
CSK_DIR=0;
MOSI_DIR=0;
MISO_DIR=1;

nrf24_config();
CSN=1;
CE=1;


 lcd_init();

 trisd=0;
 portd=0;
 count=0;
 while(1)
 {

 temp1=read_add(0x07);
if(((temp1&0b01000000)>>6)==1)
{
CE=0;
delay_ms(50);

read_buff(0x61,test,32);
lcd_out(1,1,test);
delay_ms(2000);
reset();
CE=1;

}
else
lcd_out(1,1,"no  ");
#line 253 "D:/ArtrOnix/Artronix I/underground station/Program/Kit11/MyProject.c"
}

}
