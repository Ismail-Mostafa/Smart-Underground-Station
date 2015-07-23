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

char rfid[11];

int idx=0;
int valid1;
int valid2;
void main() {



lcd_init();
//Lcd_Cmd(_LCD_CURSOR_OFF);
lcd_out(2,1,"welcome");
uart1_init(2400);
trisb.f0=0;
rb0_bit=0;
lcd_out(1,1,"S");
while(1)
{
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