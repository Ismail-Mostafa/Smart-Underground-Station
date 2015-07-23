
_main:

;MyProject.c,16 :: 		void main()
;MyProject.c,20 :: 		lcd_init();
	CALL       _Lcd_Init+0
;MyProject.c,21 :: 		trisc=0;
	CLRF       TRISC+0
;MyProject.c,22 :: 		trisd=0;
	CLRF       TRISD+0
;MyProject.c,23 :: 		portd=0;
	CLRF       PORTD+0
;MyProject.c,24 :: 		count=0;
	CLRF       main_count_L0+0
	CLRF       main_count_L0+1
;MyProject.c,25 :: 		while(1)
L_main0:
;MyProject.c,27 :: 		ldr1=adc_read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      main_ldr1_L0+0
	MOVF       R0+1, 0
	MOVWF      main_ldr1_L0+1
;MyProject.c,28 :: 		ldr2=adc_read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      main_ldr2_L0+0
	MOVF       R0+1, 0
	MOVWF      main_ldr2_L0+1
;MyProject.c,29 :: 		v=adc_read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
;MyProject.c,30 :: 		t=0.4887*v;
	CALL       _Int2Double+0
	MOVLW      227
	MOVWF      R4+0
	MOVLW      54
	MOVWF      R4+1
	MOVLW      122
	MOVWF      R4+2
	MOVLW      125
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      main_t_L0+0
	MOVF       R0+1, 0
	MOVWF      main_t_L0+1
;MyProject.c,31 :: 		if(t>=28)
	MOVLW      128
	XORWF      R0+1, 0
	MOVWF      R2+0
	MOVLW      128
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main14
	MOVLW      28
	SUBWF      R0+0, 0
L__main14:
	BTFSS      STATUS+0, 0
	GOTO       L_main2
;MyProject.c,32 :: 		{portd=0b00110000;}
	MOVLW      48
	MOVWF      PORTD+0
	GOTO       L_main3
L_main2:
;MyProject.c,34 :: 		{portd=0;}
	CLRF       PORTD+0
L_main3:
;MyProject.c,36 :: 		a  =t/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       main_t_L0+0, 0
	MOVWF      R0+0
	MOVF       main_t_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      main_a_L0+0
;MyProject.c,37 :: 		b =t%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       main_t_L0+0, 0
	MOVWF      R0+0
	MOVF       main_t_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      main_b_L0+0
;MyProject.c,38 :: 		lcd_out(1,1,"temp=");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,39 :: 		lcd_chr(1,7,a+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      main_a_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,40 :: 		lcd_chr(1,8,b+48);
	MOVLW      1
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      main_b_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,41 :: 		if(ldr1>=900&&ldr1_p<800)
	MOVLW      128
	XORWF      main_ldr1_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      3
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main15
	MOVLW      132
	SUBWF      main_ldr1_L0+0, 0
L__main15:
	BTFSS      STATUS+0, 0
	GOTO       L_main6
	MOVLW      128
	XORWF      main_ldr1_p_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      3
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main16
	MOVLW      32
	SUBWF      main_ldr1_p_L0+0, 0
L__main16:
	BTFSC      STATUS+0, 0
	GOTO       L_main6
L__main12:
;MyProject.c,43 :: 		count++;
	INCF       main_count_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_count_L0+1, 1
;MyProject.c,44 :: 		}
L_main6:
;MyProject.c,45 :: 		ldr1_p=ldr1;
	MOVF       main_ldr1_L0+0, 0
	MOVWF      main_ldr1_p_L0+0
	MOVF       main_ldr1_L0+1, 0
	MOVWF      main_ldr1_p_L0+1
;MyProject.c,46 :: 		if(ldr2>=400&&ldr2_p<350)
	MOVLW      128
	XORWF      main_ldr2_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      1
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main17
	MOVLW      144
	SUBWF      main_ldr2_L0+0, 0
L__main17:
	BTFSS      STATUS+0, 0
	GOTO       L_main9
	MOVLW      128
	XORWF      main_ldr2_p_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      1
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main18
	MOVLW      94
	SUBWF      main_ldr2_p_L0+0, 0
L__main18:
	BTFSC      STATUS+0, 0
	GOTO       L_main9
L__main11:
;MyProject.c,48 :: 		count--;
	MOVLW      1
	SUBWF      main_count_L0+0, 1
	BTFSS      STATUS+0, 0
	DECF       main_count_L0+1, 1
;MyProject.c,49 :: 		if(count<0)
	MOVLW      128
	XORWF      main_count_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main19
	MOVLW      0
	SUBWF      main_count_L0+0, 0
L__main19:
	BTFSC      STATUS+0, 0
	GOTO       L_main10
;MyProject.c,50 :: 		count=0;
	CLRF       main_count_L0+0
	CLRF       main_count_L0+1
L_main10:
;MyProject.c,51 :: 		}
L_main9:
;MyProject.c,52 :: 		ldr2_p=ldr2;
	MOVF       main_ldr2_L0+0, 0
	MOVWF      main_ldr2_p_L0+0
	MOVF       main_ldr2_L0+1, 0
	MOVWF      main_ldr2_p_L0+1
;MyProject.c,53 :: 		a  =count/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       main_count_L0+0, 0
	MOVWF      R0+0
	MOVF       main_count_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      main_a_L0+0
;MyProject.c,54 :: 		b =count%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       main_count_L0+0, 0
	MOVWF      R0+0
	MOVF       main_count_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      main_b_L0+0
;MyProject.c,55 :: 		lcd_out(2,1,"count=");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,56 :: 		lcd_chr(2,8,a+48);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      main_a_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,57 :: 		lcd_chr(2,9,b+48);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      main_b_L0+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;MyProject.c,58 :: 		}
	GOTO       L_main0
;MyProject.c,60 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
