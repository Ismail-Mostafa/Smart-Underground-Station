 sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D7 at RB3_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D4 at RB0_bit;

// Pin direction
sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D7_Direction at TRISB3_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D4_Direction at TRISB0_bit;

   void main()
    {
       int   ldr1,ldr2,ldr1_p,ldr2_p, v, t,count ;
        char tx[7], a,b;
       lcd_init();
       trisc=0;
        trisd=0;
        portd=0;
        count=0;
                   while(1)
          {
          ldr1=adc_read(1);
          ldr2=adc_read(2);
           v=adc_read(0);
              t=0.4887*v;
              if(t>=28)
                {portd=0b00110000;}
              else
                {portd=0;}

               a  =t/10;
               b =t%10;
               lcd_out(1,1,"temp=");
               lcd_chr(1,7,a+48);
               lcd_chr(1,8,b+48);
               if(ldr1>=900&&ldr1_p<800)
               {
             count++;
               }
               ldr1_p=ldr1;
                if(ldr2>=400&&ldr2_p<350)
               {
                count--;
                if(count<0)
                count=0;
               }
               ldr2_p=ldr2;
               a  =count/10;
               b =count%10;
               lcd_out(2,1,"count=");
               lcd_chr(2,8,a+48);
               lcd_chr(2,9,b+48);
}

}