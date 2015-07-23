
_main:

;MyProject.c,18 :: 		void main() {
;MyProject.c,20 :: 		trisd=0b00000011;
	MOVLW      3
	MOVWF      TRISD+0
;MyProject.c,21 :: 		lcd_init();
	CALL       _Lcd_Init+0
;MyProject.c,22 :: 		uart1_init(9600);
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;MyProject.c,25 :: 		while(1)
L_main0:
;MyProject.c,28 :: 		if(uart1_data_ready()==1)
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main2
;MyProject.c,30 :: 		x=uart1_read();
	CALL       _UART1_Read+0
;MyProject.c,31 :: 		lcd_chr_cp(x);
	MOVF       R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;MyProject.c,32 :: 		}
L_main2:
;MyProject.c,34 :: 		if(rd0_bit==0)
	BTFSC      RD0_bit+0, 0
	GOTO       L_main3
;MyProject.c,36 :: 		uart1_write_text("Device1");
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyProject.c,37 :: 		while(rd0_bit==0){}
L_main4:
	BTFSC      RD0_bit+0, 0
	GOTO       L_main5
	GOTO       L_main4
L_main5:
;MyProject.c,38 :: 		}
L_main3:
;MyProject.c,40 :: 		}
	GOTO       L_main0
;MyProject.c,44 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
