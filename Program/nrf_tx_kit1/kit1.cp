#line 1 "D:/ArtrOnix/Artronix I/underground station/Program/nrf_tx_kit1/kit1.c"
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

int sec=0;
int fire_f=0;
int start_f=0;
 int f_f=0;
 int cu_f=0;
 int cd_f=0;
 int timer_f=0;
 int timer=0;
 int ldr1,ldr2,ldr1_p,ldr2_p, v, t,count ;
 char txt[7], a,b;
 int i,j;
int temp1;
char test[32];

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
write_add(0x00,0x0e);
write_add(0x00,0x0e);
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



void interrupt()
{

sec++;
if(sec>1000)
sec=0;
 INTCON.TMR0IF=0;
}


void count_ud()
{
 ldr1=adc_read(1);
 ldr2=adc_read(2);


 if(ldr1>=600)
 {
 count++;
 delay_ms(1000);
 }
 if(ldr2>=300)
 {
 count--;
 delay_ms(1000);
 if(count<0)
 count=0;
 }

}









 void main()
 {





 INTCON=0b11100000;
 INTCON.TMR0IE=1;
 OPTION_REG=0b11000111;

CE_DIR=0;
CSN_DIR=0;
CSK_DIR=0;
MOSI_DIR=0;
MISO_DIR=1;

nrf24_config();
CSN=1;
CE=1;
 lcd_init();

 trisd=0b00000100;
 portd=0;
 for(j=0;j<30;j++)
 {
 rd0_bit=1;
 delay_us(600);
 rd0_bit=0;
 delay_us(19400);
 }
 for(j=0;j<30;j++)
 {
 rd1_bit=1;
 delay_us(600);
 rd1_bit=0;
 delay_us(19400);
 }



 delay_ms(1000);







 count=2;
 while(1)
{
if(start_f==0)
{
 rd3_bit=1;
 delay_ms(1000);
 rd3_bit=0;

 for(j=0;j<30;j++)
 {
 rd0_bit=1;
 delay_us(1500);
 rd0_bit=0;
 delay_us(18500);
 }
 sec=0;
 while(sec<70)
 {
 count_ud();
 a =count/10;
 b =count%10;
 lcd_out(2,1,"count=");
 lcd_chr(2,8,a+48);
 lcd_chr(2,9,b+48);
 v=adc_read(0);
 t=0.4887*v;
 a =t/10;
 b =t%10;
 a =t/10;
 b =t%10;
 lcd_out(3,1,"temp=");
 lcd_chr(3,7,a+48);
 lcd_chr(3,8,b+48);
 }
 for(j=0;j<30;j++)
 {
 rd0_bit=1;
 delay_us(600);
 rd0_bit=0;
 delay_us(19400);
 }


 for(j=0;j<30;j++)
 {
 rd1_bit=1;
 delay_us(1500);
 rd1_bit=0;
 delay_us(18500);
 }
 sec=0;
 while(sec<100&&count<=5)
 {
 count_ud();
 a =count/10;
 b =count%10;
 lcd_out(2,1,"count=");
 lcd_chr(2,8,a+48);
 lcd_chr(2,9,b+48);
 v=adc_read(0);
 t=0.4887*v;
 a =t/10;
 b =t%10;
 a =t/10;
 b =t%10;
 lcd_out(3,1,"temp=");
 lcd_chr(3,7,a+48);
 lcd_chr(3,8,b+48);
 }
 for(j=0;j<30;j++)
 {
 rd1_bit=1;
 delay_us(600);
 rd1_bit=0;
 delay_us(19400);
 }
 rd3_bit=1;
 start_f=1;

 }

if(sec>=50)
{
 test[4]='C';
test[3]=b+48;
test[2]=a+48;
test[1]='=';
test[0]='T';
if(fire_f==1)
{
test[10]=13;
test[9]='E';
test[8]='R';
test[7]='I';
test[6]='F';
test[5]=' ';
}
else
{
test[10]=13;
test[9]=' ';
test[8]=' ';
test[7]=' ';
test[6]=' ';
test[5]=' ';
}



write_tx(0b10100000,test,32);

CE=1;
delay_ms(1000);
CE=0;
delay_ms(100);
temp1=read_add(0x07);

temp1=temp1&0b00100000;
temp1=temp1>>5;
if(temp1==1)
{
lcd_out(1,1,"data tx   ");
sec=0;
}
else
{
lcd_out(1,1,"no data tx");
i=1;
reset();
CE=1;
delay_ms(100);
sec=0;
}
}



if(rd2_bit==0)
{
fire_f=1;
f_f=1;
lcd_out(4,1,"Fire");
rd3_bit=0;
for(j=0;j<30;j++)
 {
 rd0_bit=1;
 delay_us(1500);
 rd0_bit=0;
 delay_us(18500);
 }
 for(j=0;j<30;j++)
 {
 rd1_bit=1;
 delay_us(1500);
 rd1_bit=0;
 delay_us(18500);
 }
}
if(rd2_bit==1&&f_f==1)
{
fire_f=0;
f_f=0;
lcd_out(4,1,"    ");
rd3_bit=1;
for(j=0;j<30;j++)
 {
 rd0_bit=1;
 delay_us(600);
 rd0_bit=0;
 delay_us(19400);
 }
 for(j=0;j<30;j++)
 {
 rd0_bit=1;
 delay_us(600);
 rd0_bit=0;
 delay_us(19400);
 }

}








 v=adc_read(0);
 t=0.4887*v;
 a =t/10;
 b =t%10;


 if(t>=35)
 {rd4_bit=1;
 rd5_bit=0;}
 else
 {
 rd4_bit=0;
 rd5_bit=0;}

 a =t/10;
 b =t%10;
 lcd_out(3,1,"temp=");
 lcd_chr(3,7,a+48);
 lcd_chr(3,8,b+48);










}

}
