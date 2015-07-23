
_main:

;kit2.c,22 :: 		void main() {
;kit2.c,26 :: 		lcd_init();
	CALL       _Lcd_Init+0
;kit2.c,28 :: 		lcd_out(2,1,"welcome");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,29 :: 		uart1_init(2400);
	MOVLW      103
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;kit2.c,30 :: 		trisb.f0=0;
	BCF        TRISB+0, 0
;kit2.c,31 :: 		rb0_bit=0;
	BCF        RB0_bit+0, 0
;kit2.c,32 :: 		lcd_out(1,1,"S");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,33 :: 		while(1)
L_main0:
;kit2.c,35 :: 		if(uart1_data_ready())
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main2
;kit2.c,37 :: 		rfid[idx]=uart1_read();
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FLOC__main+0
	CALL       _UART1_Read+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;kit2.c,40 :: 		if(rfid[idx]=='0'&&valid2<10)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L_main5
	MOVLW      128
	XORWF      _valid2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main63
	MOVLW      10
	SUBWF      _valid2+0, 0
L__main63:
	BTFSC      STATUS+0, 0
	GOTO       L_main5
L__main62:
;kit2.c,42 :: 		valid2++;
	INCF       _valid2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid2+1, 1
;kit2.c,43 :: 		}
	GOTO       L_main6
L_main5:
;kit2.c,44 :: 		else if(rfid[idx]=='3'&&valid2<10)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_main9
	MOVLW      128
	XORWF      _valid2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main64
	MOVLW      10
	SUBWF      _valid2+0, 0
L__main64:
	BTFSC      STATUS+0, 0
	GOTO       L_main9
L__main61:
;kit2.c,46 :: 		valid2++;
	INCF       _valid2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid2+1, 1
;kit2.c,47 :: 		}
	GOTO       L_main10
L_main9:
;kit2.c,48 :: 		else if(rfid[idx]=='2'&&valid2<10)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_main13
	MOVLW      128
	XORWF      _valid2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main65
	MOVLW      10
	SUBWF      _valid2+0, 0
L__main65:
	BTFSC      STATUS+0, 0
	GOTO       L_main13
L__main60:
;kit2.c,50 :: 		valid2++;
	INCF       _valid2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid2+1, 1
;kit2.c,51 :: 		}
	GOTO       L_main14
L_main13:
;kit2.c,52 :: 		else if(rfid[idx]=='E'&&valid2==5)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main17
	MOVLW      0
	XORWF      _valid2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main66
	MOVLW      5
	XORWF      _valid2+0, 0
L__main66:
	BTFSS      STATUS+0, 2
	GOTO       L_main17
L__main59:
;kit2.c,54 :: 		valid2++;
	INCF       _valid2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid2+1, 1
;kit2.c,55 :: 		}
	GOTO       L_main18
L_main17:
;kit2.c,56 :: 		else if(rfid[idx]=='8'&&valid2<10)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      56
	BTFSS      STATUS+0, 2
	GOTO       L_main21
	MOVLW      128
	XORWF      _valid2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main67
	MOVLW      10
	SUBWF      _valid2+0, 0
L__main67:
	BTFSC      STATUS+0, 0
	GOTO       L_main21
L__main58:
;kit2.c,58 :: 		valid2++;
	INCF       _valid2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid2+1, 1
;kit2.c,59 :: 		}
	GOTO       L_main22
L_main21:
;kit2.c,62 :: 		valid2=0;
	CLRF       _valid2+0
	CLRF       _valid2+1
;kit2.c,63 :: 		}
L_main22:
L_main18:
L_main14:
L_main10:
L_main6:
;kit2.c,67 :: 		if(rfid[idx]=='0'&&valid1<10) //03002e90b0
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L_main25
	MOVLW      128
	XORWF      _valid1+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main68
	MOVLW      10
	SUBWF      _valid1+0, 0
L__main68:
	BTFSC      STATUS+0, 0
	GOTO       L_main25
L__main57:
;kit2.c,69 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,70 :: 		}
	GOTO       L_main26
L_main25:
;kit2.c,71 :: 		else if(rfid[idx]=='3'&&valid1==1)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_main29
	MOVLW      0
	XORWF      _valid1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main69
	MOVLW      1
	XORWF      _valid1+0, 0
L__main69:
	BTFSS      STATUS+0, 2
	GOTO       L_main29
L__main56:
;kit2.c,73 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,74 :: 		}
	GOTO       L_main30
L_main29:
;kit2.c,75 :: 		else if(rfid[idx]=='2'&&valid1==4)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_main33
	MOVLW      0
	XORWF      _valid1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main70
	MOVLW      4
	XORWF      _valid1+0, 0
L__main70:
	BTFSS      STATUS+0, 2
	GOTO       L_main33
L__main55:
;kit2.c,77 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,78 :: 		}
	GOTO       L_main34
L_main33:
;kit2.c,79 :: 		else if(rfid[idx]=='E'&&valid1==5)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main37
	MOVLW      0
	XORWF      _valid1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main71
	MOVLW      5
	XORWF      _valid1+0, 0
L__main71:
	BTFSS      STATUS+0, 2
	GOTO       L_main37
L__main54:
;kit2.c,81 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,82 :: 		}
	GOTO       L_main38
L_main37:
;kit2.c,83 :: 		else if(rfid[idx]=='9'&&valid1==6)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      57
	BTFSS      STATUS+0, 2
	GOTO       L_main41
	MOVLW      0
	XORWF      _valid1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main72
	MOVLW      6
	XORWF      _valid1+0, 0
L__main72:
	BTFSS      STATUS+0, 2
	GOTO       L_main41
L__main53:
;kit2.c,85 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,86 :: 		}
	GOTO       L_main42
L_main41:
;kit2.c,87 :: 		else if(rfid[idx]=='B'&&valid1==8)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      66
	BTFSS      STATUS+0, 2
	GOTO       L_main45
	MOVLW      0
	XORWF      _valid1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main73
	MOVLW      8
	XORWF      _valid1+0, 0
L__main73:
	BTFSS      STATUS+0, 2
	GOTO       L_main45
L__main52:
;kit2.c,89 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,90 :: 		}
	GOTO       L_main46
L_main45:
;kit2.c,93 :: 		valid1=0;
	CLRF       _valid1+0
	CLRF       _valid1+1
;kit2.c,94 :: 		}
L_main46:
L_main42:
L_main38:
L_main34:
L_main30:
L_main26:
;kit2.c,103 :: 		if(valid2>=10)
	MOVLW      128
	XORWF      _valid2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main74
	MOVLW      10
	SUBWF      _valid2+0, 0
L__main74:
	BTFSS      STATUS+0, 0
	GOTO       L_main47
;kit2.c,105 :: 		lcd_out(2,1,"User2 : 03002E2838");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,106 :: 		lcd_out(2,1,"UnValid");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,107 :: 		valid1=0;
	CLRF       _valid1+0
	CLRF       _valid1+1
;kit2.c,108 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main48:
	DECFSZ     R13+0, 1
	GOTO       L_main48
	DECFSZ     R12+0, 1
	GOTO       L_main48
	DECFSZ     R11+0, 1
	GOTO       L_main48
	NOP
	NOP
;kit2.c,109 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;kit2.c,110 :: 		}
L_main47:
;kit2.c,114 :: 		if(valid1>=10)
	MOVLW      128
	XORWF      _valid1+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main75
	MOVLW      10
	SUBWF      _valid1+0, 0
L__main75:
	BTFSS      STATUS+0, 0
	GOTO       L_main49
;kit2.c,116 :: 		lcd_out(2,1,"User1 : 03002E90B0");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,117 :: 		lcd_out(2,1,"Valid");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,118 :: 		valid1=0;
	CLRF       _valid1+0
	CLRF       _valid1+1
;kit2.c,119 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main50:
	DECFSZ     R13+0, 1
	GOTO       L_main50
	DECFSZ     R12+0, 1
	GOTO       L_main50
	DECFSZ     R11+0, 1
	GOTO       L_main50
	NOP
	NOP
;kit2.c,120 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;kit2.c,121 :: 		}
L_main49:
;kit2.c,124 :: 		lcd_chr_cp(rfid[idx]);
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;kit2.c,125 :: 		idx++;
	INCF       _idx+0, 1
	BTFSC      STATUS+0, 2
	INCF       _idx+1, 1
;kit2.c,126 :: 		if(idx>=10)
	MOVLW      128
	XORWF      _idx+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main76
	MOVLW      10
	SUBWF      _idx+0, 0
L__main76:
	BTFSS      STATUS+0, 0
	GOTO       L_main51
;kit2.c,128 :: 		idx=0;
	CLRF       _idx+0
	CLRF       _idx+1
;kit2.c,129 :: 		lcd_out(1,1,"S");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,130 :: 		}
L_main51:
;kit2.c,132 :: 		}
L_main2:
;kit2.c,136 :: 		}
	GOTO       L_main0
;kit2.c,143 :: 		}
	GOTO       $+0
; end of _main
