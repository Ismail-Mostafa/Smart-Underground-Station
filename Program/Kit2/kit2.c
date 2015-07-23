// LCD module connections
sbit LCD_RS at RB1_bit;
sbit LCD_EN at RB2_bit;
sbit LCD_D4 at RB3_bit;
sbit LCD_D5 at RB4_bit;
sbit LCD_D6 at RB5_bit;
sbit LCD_D7 at RB6_bit;

sbit LCD_RS_Direction at TRISB1_bit;
sbit LCD_EN_Direction at TRISB2_bit;
sbit LCD_D4_Direction at TRISB3_bit;
sbit LCD_D5_Direction at TRISB4_bit;
sbit LCD_D6_Direction at TRISB5_bit;
sbit LCD_D7_Direction at TRISB6_bit;
// End LCD module connections


//////////////////////////////////nrf24l01/////////////////////
sbit CE at rc3_bit;
sbit CSN at rc2_bit;
sbit CSK at rc0_bit;
sbit MOSI at rc1_bit;
sbit MISO at rc4_bit;


sbit CE_DIR at TRISC3_BIT;
sbit CSN_DIR at TRISC2_BIT;
sbit CSK_DIR at TRISC0_BIT;
sbit MOSI_DIR at TRISC1_BIT;
sbit MISO_DIR at TRISC4_BIT;


////////////Rread Write Register///////////////////////////
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
/////////////////////////////////Read Address//////////////////////
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
///////////////////////////////////////Write Register////////////////////
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

///////////////////////////////Read Buffer//////////////////////////
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
/////////////////////////////////Write Buffer///////////////////////
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
/////////////////////////////////Write tx///////////////////////
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
/////////////////////////NRF24L01 CONFIG///////////////////////
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
write_add(0x00,0x0E);
write_add(0x00,0x0E);
delay_ms(5);

CSN=1;
CE=1;
delay_ms(20);
//write_buff(0x0a,add1,5);
//write_buff(0x10,add1,5);

}
//////////////////////////////////////////RETSET /////////////////////////
void reset()
{
write_add(0x07,0x7E);
read_add(0xE1);
read_add(0xE2);
}
////////////////////////////////////////////////////////////end NRF//////////////////////


char rfid[11];

int idx=0;
int valid1;
int valid2;


////////////////////////////////////////////////////////
///////////////////////////////////////////////////////
void main() {
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
//Lcd_Cmd(_LCD_CURSOR_OFF);
lcd_out(2,1,"welcome");
uart1_init(2400);
trisb.f0=0;
rb0_bit=0;
lcd_out(1,1,"S");
while(1)
{
delay_ms(1000);
//////////////////////////////////
test[4]='o';
test[3]='l';
test[2]='l';
test[1]='e';
test[0]='h';

write_tx(0b10100000,test,32);
//write_add(0x00,0x0E);
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
}
else
lcd_out(1,1,"no data tx");
i=1;
reset();
CE=1;
delay_ms(100);


















 if(uart1_data_ready())
 {
  rfid[idx]=uart1_read();
  
   ///////////////////////////////////////////////////////////03002e2838
  if(rfid[idx]=='0'&&valid2<10)
  {
   valid2++;
  }
   else if(rfid[idx]=='3'&&valid2<10)
  {
   valid2++;
  }
   else if(rfid[idx]=='2'&&valid2<10)
  {
   valid2++;
  }
  else if(rfid[idx]=='E'&&valid2==5)
  {
   valid2++;
  }
  else if(rfid[idx]=='8'&&valid2<10)
  {
   valid2++;
   }
  else
  {
  valid2=0;
  }
 

 
   if(rfid[idx]=='0'&&valid1<10) //03002e90b0
  {
   valid1++;
  }
   else if(rfid[idx]=='3'&&valid1==1)
  {
   valid1++;
  }
   else if(rfid[idx]=='2'&&valid1==4)
  {
   valid1++;
  }
  else if(rfid[idx]=='E'&&valid1==5)
  {
   valid1++;
  }
  else if(rfid[idx]=='9'&&valid1==6)
  {
   valid1++;
  }
    else if(rfid[idx]=='B'&&valid1==8)
  {
   valid1++;
  }
  else
  {
  valid1=0;
  }
 
 
 
 
 
 
 
  
  if(valid2>=10)
  {
  lcd_out(2,1,"User2 : 03002E2838");
   lcd_out(2,1,"UnValid");
   valid1=0;
   delay_ms(1000);
   lcd_cmd(_lcd_clear);
  }

  
  
 if(valid1>=10)
  {
  lcd_out(2,1,"User1 : 03002E90B0");
   lcd_out(2,1,"Valid");
   valid1=0;
   delay_ms(1000);
   lcd_cmd(_lcd_clear);
  }
  
  
  lcd_chr_cp(rfid[idx]);
  idx++;
  if(idx>=10)
  {
  idx=0;
  lcd_out(1,1,"S");
  }
 
 }



}






}