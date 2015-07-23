
_rw_register:

;MyProject.c,32 :: 		char rw_register(char add)
;MyProject.c,34 :: 		char rec=0;
	CLRF       rw_register_rec_L0+0
;MyProject.c,36 :: 		for(cou=0;cou<8;cou++)
	CLRF       R3+0
L_rw_register0:
	MOVLW      8
	SUBWF      R3+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_rw_register1
;MyProject.c,38 :: 		MOSI=(add&0x80)>>7;
	MOVLW      128
	ANDWF      FARG_rw_register_add+0, 0
	MOVWF      R2+0
	MOVLW      7
	MOVWF      R1+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__rw_register32:
	BTFSC      STATUS+0, 2
	GOTO       L__rw_register33
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__rw_register32
L__rw_register33:
	BTFSC      R0+0, 0
	GOTO       L__rw_register34
	BCF        RC3_bit+0, 3
	GOTO       L__rw_register35
L__rw_register34:
	BSF        RC3_bit+0, 3
L__rw_register35:
;MyProject.c,39 :: 		add=add<<1;
	RLF        FARG_rw_register_add+0, 1
	BCF        FARG_rw_register_add+0, 0
;MyProject.c,40 :: 		rec=rec<<1;
	RLF        rw_register_rec_L0+0, 1
	BCF        rw_register_rec_L0+0, 0
;MyProject.c,41 :: 		CSK=1;
	BSF        RC2_bit+0, 2
;MyProject.c,42 :: 		rec|=MISO;
	CLRF       R0+0
	BTFSC      RC4_bit+0, 4
	INCF       R0+0, 1
	MOVF       R0+0, 0
	IORWF      rw_register_rec_L0+0, 1
;MyProject.c,43 :: 		CSK=0;
	BCF        RC2_bit+0, 2
;MyProject.c,36 :: 		for(cou=0;cou<8;cou++)
	INCF       R3+0, 1
;MyProject.c,44 :: 		}
	GOTO       L_rw_register0
L_rw_register1:
;MyProject.c,45 :: 		return rec;
	MOVF       rw_register_rec_L0+0, 0
	MOVWF      R0+0
;MyProject.c,46 :: 		}
L_end_rw_register:
	RETURN
; end of _rw_register

_read_add:

;MyProject.c,48 :: 		char read_add(char add)
;MyProject.c,51 :: 		CSN=0;
	BCF        RC1_bit+0, 1
;MyProject.c,52 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_read_add3:
	DECFSZ     R13+0, 1
	GOTO       L_read_add3
;MyProject.c,53 :: 		rw_register(add);
	MOVF       FARG_read_add_add+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;MyProject.c,54 :: 		value=rw_register(0xFF);
	MOVLW      255
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
	MOVF       R0+0, 0
	MOVWF      read_add_value_L0+0
;MyProject.c,55 :: 		CSN=1;
	BSF        RC1_bit+0, 1
;MyProject.c,56 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_read_add4:
	DECFSZ     R13+0, 1
	GOTO       L_read_add4
;MyProject.c,57 :: 		return value;
	MOVF       read_add_value_L0+0, 0
	MOVWF      R0+0
;MyProject.c,58 :: 		}
L_end_read_add:
	RETURN
; end of _read_add

_write_add:

;MyProject.c,60 :: 		char write_add(char add,char value)
;MyProject.c,63 :: 		add=add|0b00100000;
	BSF        FARG_write_add_add+0, 5
;MyProject.c,64 :: 		CSN=0;
	BCF        RC1_bit+0, 1
;MyProject.c,65 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_add5:
	DECFSZ     R13+0, 1
	GOTO       L_write_add5
;MyProject.c,66 :: 		status=rw_register(add);
	MOVF       FARG_write_add_add+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;MyProject.c,67 :: 		rw_register(value);
	MOVF       FARG_write_add_value+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;MyProject.c,68 :: 		CSN=1;
	BSF        RC1_bit+0, 1
;MyProject.c,69 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_add6:
	DECFSZ     R13+0, 1
	GOTO       L_write_add6
;MyProject.c,70 :: 		return value;
	MOVF       FARG_write_add_value+0, 0
	MOVWF      R0+0
;MyProject.c,71 :: 		}
L_end_write_add:
	RETURN
; end of _write_add

_read_buff:

;MyProject.c,74 :: 		void read_buff(char add,char buffer[],char bytes)
;MyProject.c,77 :: 		CSN=0;
	BCF        RC1_bit+0, 1
;MyProject.c,78 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_read_buff7:
	DECFSZ     R13+0, 1
	GOTO       L_read_buff7
;MyProject.c,79 :: 		rw_register(add);
	MOVF       FARG_read_buff_add+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;MyProject.c,80 :: 		for(counter=0;counter<bytes;counter++)
	CLRF       read_buff_counter_L0+0
L_read_buff8:
	MOVF       FARG_read_buff_bytes+0, 0
	SUBWF      read_buff_counter_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_read_buff9
;MyProject.c,82 :: 		buffer[counter]=rw_register(0xFF);
	MOVF       read_buff_counter_L0+0, 0
	ADDWF      FARG_read_buff_buffer+0, 0
	MOVWF      FLOC__read_buff+0
	MOVLW      255
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
	MOVF       FLOC__read_buff+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;MyProject.c,80 :: 		for(counter=0;counter<bytes;counter++)
	INCF       read_buff_counter_L0+0, 1
;MyProject.c,83 :: 		}
	GOTO       L_read_buff8
L_read_buff9:
;MyProject.c,84 :: 		CSN=1;
	BSF        RC1_bit+0, 1
;MyProject.c,85 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_read_buff11:
	DECFSZ     R13+0, 1
	GOTO       L_read_buff11
;MyProject.c,86 :: 		}
L_end_read_buff:
	RETURN
; end of _read_buff

_write_buff:

;MyProject.c,88 :: 		void write_buff(char add,char buffer[],char bytes)
;MyProject.c,91 :: 		CSN=0;
	BCF        RC1_bit+0, 1
;MyProject.c,92 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_buff12:
	DECFSZ     R13+0, 1
	GOTO       L_write_buff12
;MyProject.c,93 :: 		add=add|0b00100000;
	MOVLW      32
	IORWF      FARG_write_buff_add+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FARG_write_buff_add+0
;MyProject.c,94 :: 		rw_register(add);
	MOVF       R0+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;MyProject.c,95 :: 		for(counter=0;counter<bytes;counter++)
	CLRF       write_buff_counter_L0+0
L_write_buff13:
	MOVF       FARG_write_buff_bytes+0, 0
	SUBWF      write_buff_counter_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_write_buff14
;MyProject.c,97 :: 		rw_register(buffer[counter]);
	MOVF       write_buff_counter_L0+0, 0
	ADDWF      FARG_write_buff_buffer+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;MyProject.c,95 :: 		for(counter=0;counter<bytes;counter++)
	INCF       write_buff_counter_L0+0, 1
;MyProject.c,98 :: 		}
	GOTO       L_write_buff13
L_write_buff14:
;MyProject.c,99 :: 		CSN=1;
	BSF        RC1_bit+0, 1
;MyProject.c,100 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_buff16:
	DECFSZ     R13+0, 1
	GOTO       L_write_buff16
;MyProject.c,101 :: 		}
L_end_write_buff:
	RETURN
; end of _write_buff

_write_tx:

;MyProject.c,103 :: 		void write_tx(char add,char buffer[],char bytes)
;MyProject.c,106 :: 		CSN=0;
	BCF        RC1_bit+0, 1
;MyProject.c,107 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_tx17:
	DECFSZ     R13+0, 1
	GOTO       L_write_tx17
;MyProject.c,108 :: 		rw_register(add);
	MOVF       FARG_write_tx_add+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;MyProject.c,109 :: 		for(counter=0;counter<bytes;counter++)
	CLRF       write_tx_counter_L0+0
L_write_tx18:
	MOVF       FARG_write_tx_bytes+0, 0
	SUBWF      write_tx_counter_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_write_tx19
;MyProject.c,111 :: 		rw_register(buffer[counter]);
	MOVF       write_tx_counter_L0+0, 0
	ADDWF      FARG_write_tx_buffer+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;MyProject.c,109 :: 		for(counter=0;counter<bytes;counter++)
	INCF       write_tx_counter_L0+0, 1
;MyProject.c,112 :: 		}
	GOTO       L_write_tx18
L_write_tx19:
;MyProject.c,113 :: 		CSN=1;
	BSF        RC1_bit+0, 1
;MyProject.c,114 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_tx21:
	DECFSZ     R13+0, 1
	GOTO       L_write_tx21
;MyProject.c,115 :: 		}
L_end_write_tx:
	RETURN
; end of _write_tx

_nrf24_config:

;MyProject.c,117 :: 		void nrf24_config()
;MyProject.c,119 :: 		char add1[5]={'a','a','a','a','a'};
;MyProject.c,120 :: 		CSN=0;
	BCF        RC1_bit+0, 1
;MyProject.c,121 :: 		CE=0;
	BCF        RC0_bit+0, 0
;MyProject.c,122 :: 		delay_ms(20);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_nrf24_config22:
	DECFSZ     R13+0, 1
	GOTO       L_nrf24_config22
	DECFSZ     R12+0, 1
	GOTO       L_nrf24_config22
	NOP
;MyProject.c,124 :: 		write_add(0x01,0x3f);
	MOVLW      1
	MOVWF      FARG_write_add_add+0
	MOVLW      63
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;MyProject.c,125 :: 		write_add(0x02,0x03);
	MOVLW      2
	MOVWF      FARG_write_add_add+0
	MOVLW      3
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;MyProject.c,126 :: 		write_add(0x03,0x03);
	MOVLW      3
	MOVWF      FARG_write_add_add+0
	MOVLW      3
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;MyProject.c,127 :: 		write_add(0x04,0x4f);
	MOVLW      4
	MOVWF      FARG_write_add_add+0
	MOVLW      79
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;MyProject.c,128 :: 		write_add(0x05,0x4c);
	MOVLW      5
	MOVWF      FARG_write_add_add+0
	MOVLW      76
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;MyProject.c,129 :: 		write_add(0x06,0x07);
	MOVLW      6
	MOVWF      FARG_write_add_add+0
	MOVLW      7
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;MyProject.c,130 :: 		write_add(0x11,0x20);
	MOVLW      17
	MOVWF      FARG_write_add_add+0
	MOVLW      32
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;MyProject.c,131 :: 		write_add(0x1C,0x00);
	MOVLW      28
	MOVWF      FARG_write_add_add+0
	CLRF       FARG_write_add_value+0
	CALL       _write_add+0
;MyProject.c,132 :: 		write_add(0x1D,0x00);
	MOVLW      29
	MOVWF      FARG_write_add_add+0
	CLRF       FARG_write_add_value+0
	CALL       _write_add+0
;MyProject.c,133 :: 		write_add(0x00,0x0f);
	CLRF       FARG_write_add_add+0
	MOVLW      15
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;MyProject.c,134 :: 		write_add(0x00,0x0f);
	CLRF       FARG_write_add_add+0
	MOVLW      15
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;MyProject.c,135 :: 		delay_ms(5);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_nrf24_config23:
	DECFSZ     R13+0, 1
	GOTO       L_nrf24_config23
	DECFSZ     R12+0, 1
	GOTO       L_nrf24_config23
;MyProject.c,137 :: 		CSN=1;
	BSF        RC1_bit+0, 1
;MyProject.c,138 :: 		CE=1;
	BSF        RC0_bit+0, 0
;MyProject.c,139 :: 		delay_ms(20);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_nrf24_config24:
	DECFSZ     R13+0, 1
	GOTO       L_nrf24_config24
	DECFSZ     R12+0, 1
	GOTO       L_nrf24_config24
	NOP
;MyProject.c,143 :: 		}
L_end_nrf24_config:
	RETURN
; end of _nrf24_config

_reset:

;MyProject.c,145 :: 		void reset()
;MyProject.c,147 :: 		write_add(0x07,0x7E);
	MOVLW      7
	MOVWF      FARG_write_add_add+0
	MOVLW      126
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;MyProject.c,148 :: 		read_add(0xE1);
	MOVLW      225
	MOVWF      FARG_read_add_add+0
	CALL       _read_add+0
;MyProject.c,149 :: 		read_add(0xE2);
	MOVLW      226
	MOVWF      FARG_read_add_add+0
	CALL       _read_add+0
;MyProject.c,150 :: 		}
L_end_reset:
	RETURN
; end of _reset

_main:

;MyProject.c,163 :: 		void main()
;MyProject.c,171 :: 		CE_DIR=0;
	BCF        TRISC0_bit+0, 0
;MyProject.c,172 :: 		CSN_DIR=0;
	BCF        TRISC1_bit+0, 1
;MyProject.c,173 :: 		CSK_DIR=0;
	BCF        TRISC2_bit+0, 2
;MyProject.c,174 :: 		MOSI_DIR=0;
	BCF        TRISC3_bit+0, 3
;MyProject.c,175 :: 		MISO_DIR=1;
	BSF        TRISC4_bit+0, 4
;MyProject.c,177 :: 		nrf24_config();
	CALL       _nrf24_config+0
;MyProject.c,178 :: 		CSN=1;
	BSF        RC1_bit+0, 1
;MyProject.c,179 :: 		CE=1;
	BSF        RC0_bit+0, 0
;MyProject.c,182 :: 		lcd_init();
	CALL       _Lcd_Init+0
;MyProject.c,184 :: 		trisd=0;
	CLRF       TRISD+0
;MyProject.c,185 :: 		portd=0;
	CLRF       PORTD+0
;MyProject.c,187 :: 		while(1)
L_main25:
;MyProject.c,190 :: 		temp1=read_add(0x07);
	MOVLW      7
	MOVWF      FARG_read_add_add+0
	CALL       _read_add+0
	MOVF       R0+0, 0
	MOVWF      main_temp1_L0+0
	CLRF       main_temp1_L0+1
;MyProject.c,191 :: 		if(((temp1&0b01000000)>>6)==1)
	MOVLW      64
	ANDWF      main_temp1_L0+0, 0
	MOVWF      R3+0
	MOVF       main_temp1_L0+1, 0
	MOVWF      R3+1
	MOVLW      0
	ANDWF      R3+1, 1
	MOVLW      6
	MOVWF      R0+0
	MOVF       R3+0, 0
	MOVWF      R1+0
	MOVF       R3+1, 0
	MOVWF      R1+1
	MOVF       R0+0, 0
L__main44:
	BTFSC      STATUS+0, 2
	GOTO       L__main45
	RRF        R1+1, 1
	RRF        R1+0, 1
	BCF        R1+1, 7
	BTFSC      R1+1, 6
	BSF        R1+1, 7
	ADDLW      255
	GOTO       L__main44
L__main45:
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main46
	MOVLW      1
	XORWF      R1+0, 0
L__main46:
	BTFSS      STATUS+0, 2
	GOTO       L_main27
;MyProject.c,193 :: 		CE=0;
	BCF        RC0_bit+0, 0
;MyProject.c,194 :: 		delay_ms(50);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main28:
	DECFSZ     R13+0, 1
	GOTO       L_main28
	DECFSZ     R12+0, 1
	GOTO       L_main28
	NOP
;MyProject.c,196 :: 		read_buff(0x61,test,32);
	MOVLW      97
	MOVWF      FARG_read_buff_add+0
	MOVLW      main_test_L0+0
	MOVWF      FARG_read_buff_buffer+0
	MOVLW      32
	MOVWF      FARG_read_buff_bytes+0
	CALL       _read_buff+0
;MyProject.c,197 :: 		lcd_out(1,1,test);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_test_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MyProject.c,198 :: 		delay_ms(2000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main29:
	DECFSZ     R13+0, 1
	GOTO       L_main29
	DECFSZ     R12+0, 1
	GOTO       L_main29
	DECFSZ     R11+0, 1
	GOTO       L_main29
	NOP
	NOP
;MyProject.c,199 :: 		reset();
	CALL       _reset+0
;MyProject.c,200 :: 		CE=1;
	BSF        RC0_bit+0, 0
;MyProject.c,202 :: 		}
	GOTO       L_main30
L_main27:
;MyProject.c,204 :: 		lcd_out(1,1,"no  ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_MyProject+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main30:
;MyProject.c,253 :: 		}
	GOTO       L_main25
;MyProject.c,255 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
