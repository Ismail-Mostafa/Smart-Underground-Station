
_rw_register:

;kit2.c,34 :: 		char rw_register(char add)
;kit2.c,36 :: 		char rec=0;
	CLRF       rw_register_rec_L0+0
;kit2.c,38 :: 		for(cou=0;cou<8;cou++)
	CLRF       R3+0
L_rw_register0:
	MOVLW      8
	SUBWF      R3+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_rw_register1
;kit2.c,40 :: 		MOSI=(add&0x80)>>7;
	MOVLW      128
	ANDWF      FARG_rw_register_add+0, 0
	MOVWF      R2+0
	MOVLW      7
	MOVWF      R1+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__rw_register95:
	BTFSC      STATUS+0, 2
	GOTO       L__rw_register96
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__rw_register95
L__rw_register96:
	BTFSC      R0+0, 0
	GOTO       L__rw_register97
	BCF        RC1_bit+0, 1
	GOTO       L__rw_register98
L__rw_register97:
	BSF        RC1_bit+0, 1
L__rw_register98:
;kit2.c,41 :: 		add=add<<1;
	RLF        FARG_rw_register_add+0, 1
	BCF        FARG_rw_register_add+0, 0
;kit2.c,42 :: 		rec=rec<<1;
	RLF        rw_register_rec_L0+0, 1
	BCF        rw_register_rec_L0+0, 0
;kit2.c,43 :: 		CSK=1;
	BSF        RC0_bit+0, 0
;kit2.c,44 :: 		rec|=MISO;
	CLRF       R0+0
	BTFSC      RC4_bit+0, 4
	INCF       R0+0, 1
	MOVF       R0+0, 0
	IORWF      rw_register_rec_L0+0, 1
;kit2.c,45 :: 		CSK=0;
	BCF        RC0_bit+0, 0
;kit2.c,38 :: 		for(cou=0;cou<8;cou++)
	INCF       R3+0, 1
;kit2.c,46 :: 		}
	GOTO       L_rw_register0
L_rw_register1:
;kit2.c,47 :: 		return rec;
	MOVF       rw_register_rec_L0+0, 0
	MOVWF      R0+0
;kit2.c,48 :: 		}
L_end_rw_register:
	RETURN
; end of _rw_register

_read_add:

;kit2.c,50 :: 		char read_add(char add)
;kit2.c,53 :: 		CSN=0;
	BCF        RC2_bit+0, 2
;kit2.c,54 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_read_add3:
	DECFSZ     R13+0, 1
	GOTO       L_read_add3
;kit2.c,55 :: 		rw_register(add);
	MOVF       FARG_read_add_add+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;kit2.c,56 :: 		value=rw_register(0xFF);
	MOVLW      255
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
	MOVF       R0+0, 0
	MOVWF      read_add_value_L0+0
;kit2.c,57 :: 		CSN=1;
	BSF        RC2_bit+0, 2
;kit2.c,58 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_read_add4:
	DECFSZ     R13+0, 1
	GOTO       L_read_add4
;kit2.c,59 :: 		return value;
	MOVF       read_add_value_L0+0, 0
	MOVWF      R0+0
;kit2.c,60 :: 		}
L_end_read_add:
	RETURN
; end of _read_add

_write_add:

;kit2.c,62 :: 		char write_add(char add,char value)
;kit2.c,65 :: 		add=add|0b00100000;
	BSF        FARG_write_add_add+0, 5
;kit2.c,66 :: 		CSN=0;
	BCF        RC2_bit+0, 2
;kit2.c,67 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_add5:
	DECFSZ     R13+0, 1
	GOTO       L_write_add5
;kit2.c,68 :: 		status=rw_register(add);
	MOVF       FARG_write_add_add+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;kit2.c,69 :: 		rw_register(value);
	MOVF       FARG_write_add_value+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;kit2.c,70 :: 		CSN=1;
	BSF        RC2_bit+0, 2
;kit2.c,71 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_add6:
	DECFSZ     R13+0, 1
	GOTO       L_write_add6
;kit2.c,72 :: 		return value;
	MOVF       FARG_write_add_value+0, 0
	MOVWF      R0+0
;kit2.c,73 :: 		}
L_end_write_add:
	RETURN
; end of _write_add

_read_buff:

;kit2.c,76 :: 		void read_buff(char add,char buffer[],char bytes)
;kit2.c,79 :: 		CSN=0;
	BCF        RC2_bit+0, 2
;kit2.c,80 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_read_buff7:
	DECFSZ     R13+0, 1
	GOTO       L_read_buff7
;kit2.c,81 :: 		rw_register(add);
	MOVF       FARG_read_buff_add+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;kit2.c,82 :: 		for(counter=0;counter<bytes;counter++)
	CLRF       read_buff_counter_L0+0
L_read_buff8:
	MOVF       FARG_read_buff_bytes+0, 0
	SUBWF      read_buff_counter_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_read_buff9
;kit2.c,84 :: 		buffer[counter]=rw_register(0xFF);
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
;kit2.c,82 :: 		for(counter=0;counter<bytes;counter++)
	INCF       read_buff_counter_L0+0, 1
;kit2.c,85 :: 		}
	GOTO       L_read_buff8
L_read_buff9:
;kit2.c,86 :: 		CSN=1;
	BSF        RC2_bit+0, 2
;kit2.c,87 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_read_buff11:
	DECFSZ     R13+0, 1
	GOTO       L_read_buff11
;kit2.c,88 :: 		}
L_end_read_buff:
	RETURN
; end of _read_buff

_write_buff:

;kit2.c,90 :: 		void write_buff(char add,char buffer[],char bytes)
;kit2.c,93 :: 		CSN=0;
	BCF        RC2_bit+0, 2
;kit2.c,94 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_buff12:
	DECFSZ     R13+0, 1
	GOTO       L_write_buff12
;kit2.c,95 :: 		add=add|0b00100000;
	MOVLW      32
	IORWF      FARG_write_buff_add+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FARG_write_buff_add+0
;kit2.c,96 :: 		rw_register(add);
	MOVF       R0+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;kit2.c,97 :: 		for(counter=0;counter<bytes;counter++)
	CLRF       write_buff_counter_L0+0
L_write_buff13:
	MOVF       FARG_write_buff_bytes+0, 0
	SUBWF      write_buff_counter_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_write_buff14
;kit2.c,99 :: 		rw_register(buffer[counter]);
	MOVF       write_buff_counter_L0+0, 0
	ADDWF      FARG_write_buff_buffer+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;kit2.c,97 :: 		for(counter=0;counter<bytes;counter++)
	INCF       write_buff_counter_L0+0, 1
;kit2.c,100 :: 		}
	GOTO       L_write_buff13
L_write_buff14:
;kit2.c,101 :: 		CSN=1;
	BSF        RC2_bit+0, 2
;kit2.c,102 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_buff16:
	DECFSZ     R13+0, 1
	GOTO       L_write_buff16
;kit2.c,103 :: 		}
L_end_write_buff:
	RETURN
; end of _write_buff

_write_tx:

;kit2.c,105 :: 		void write_tx(char add,char buffer[],char bytes)
;kit2.c,108 :: 		CSN=0;
	BCF        RC2_bit+0, 2
;kit2.c,109 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_tx17:
	DECFSZ     R13+0, 1
	GOTO       L_write_tx17
;kit2.c,110 :: 		rw_register(add);
	MOVF       FARG_write_tx_add+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;kit2.c,111 :: 		for(counter=0;counter<bytes;counter++)
	CLRF       write_tx_counter_L0+0
L_write_tx18:
	MOVF       FARG_write_tx_bytes+0, 0
	SUBWF      write_tx_counter_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_write_tx19
;kit2.c,113 :: 		rw_register(buffer[counter]);
	MOVF       write_tx_counter_L0+0, 0
	ADDWF      FARG_write_tx_buffer+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;kit2.c,111 :: 		for(counter=0;counter<bytes;counter++)
	INCF       write_tx_counter_L0+0, 1
;kit2.c,114 :: 		}
	GOTO       L_write_tx18
L_write_tx19:
;kit2.c,115 :: 		CSN=1;
	BSF        RC2_bit+0, 2
;kit2.c,116 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_tx21:
	DECFSZ     R13+0, 1
	GOTO       L_write_tx21
;kit2.c,117 :: 		}
L_end_write_tx:
	RETURN
; end of _write_tx

_nrf24_config:

;kit2.c,119 :: 		void nrf24_config()
;kit2.c,121 :: 		char add1[5]={'a','a','a','a','a'};
;kit2.c,122 :: 		CSN=0;
	BCF        RC2_bit+0, 2
;kit2.c,123 :: 		CE=0;
	BCF        RC3_bit+0, 3
;kit2.c,124 :: 		delay_ms(20);
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
;kit2.c,126 :: 		write_add(0x01,0x3f);
	MOVLW      1
	MOVWF      FARG_write_add_add+0
	MOVLW      63
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit2.c,127 :: 		write_add(0x02,0x03);
	MOVLW      2
	MOVWF      FARG_write_add_add+0
	MOVLW      3
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit2.c,128 :: 		write_add(0x03,0x03);
	MOVLW      3
	MOVWF      FARG_write_add_add+0
	MOVLW      3
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit2.c,129 :: 		write_add(0x04,0x4f);
	MOVLW      4
	MOVWF      FARG_write_add_add+0
	MOVLW      79
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit2.c,130 :: 		write_add(0x05,0x4c);
	MOVLW      5
	MOVWF      FARG_write_add_add+0
	MOVLW      76
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit2.c,131 :: 		write_add(0x06,0x07);
	MOVLW      6
	MOVWF      FARG_write_add_add+0
	MOVLW      7
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit2.c,132 :: 		write_add(0x11,0x20);
	MOVLW      17
	MOVWF      FARG_write_add_add+0
	MOVLW      32
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit2.c,133 :: 		write_add(0x1C,0x00);
	MOVLW      28
	MOVWF      FARG_write_add_add+0
	CLRF       FARG_write_add_value+0
	CALL       _write_add+0
;kit2.c,134 :: 		write_add(0x1D,0x00);
	MOVLW      29
	MOVWF      FARG_write_add_add+0
	CLRF       FARG_write_add_value+0
	CALL       _write_add+0
;kit2.c,135 :: 		write_add(0x00,0x0E);
	CLRF       FARG_write_add_add+0
	MOVLW      14
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit2.c,136 :: 		write_add(0x00,0x0E);
	CLRF       FARG_write_add_add+0
	MOVLW      14
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit2.c,137 :: 		delay_ms(5);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_nrf24_config23:
	DECFSZ     R13+0, 1
	GOTO       L_nrf24_config23
	DECFSZ     R12+0, 1
	GOTO       L_nrf24_config23
;kit2.c,139 :: 		CSN=1;
	BSF        RC2_bit+0, 2
;kit2.c,140 :: 		CE=1;
	BSF        RC3_bit+0, 3
;kit2.c,141 :: 		delay_ms(20);
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
;kit2.c,145 :: 		}
L_end_nrf24_config:
	RETURN
; end of _nrf24_config

_reset:

;kit2.c,147 :: 		void reset()
;kit2.c,149 :: 		write_add(0x07,0x7E);
	MOVLW      7
	MOVWF      FARG_write_add_add+0
	MOVLW      126
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit2.c,150 :: 		read_add(0xE1);
	MOVLW      225
	MOVWF      FARG_read_add_add+0
	CALL       _read_add+0
;kit2.c,151 :: 		read_add(0xE2);
	MOVLW      226
	MOVWF      FARG_read_add_add+0
	CALL       _read_add+0
;kit2.c,152 :: 		}
L_end_reset:
	RETURN
; end of _reset

_main:

;kit2.c,165 :: 		void main() {
;kit2.c,170 :: 		CE_DIR=0;
	BCF        TRISC3_bit+0, 3
;kit2.c,171 :: 		CSN_DIR=0;
	BCF        TRISC2_bit+0, 2
;kit2.c,172 :: 		CSK_DIR=0;
	BCF        TRISC0_bit+0, 0
;kit2.c,173 :: 		MOSI_DIR=0;
	BCF        TRISC1_bit+0, 1
;kit2.c,174 :: 		MISO_DIR=1;
	BSF        TRISC4_bit+0, 4
;kit2.c,176 :: 		nrf24_config();
	CALL       _nrf24_config+0
;kit2.c,177 :: 		CSN=1;
	BSF        RC2_bit+0, 2
;kit2.c,178 :: 		CE=1;
	BSF        RC3_bit+0, 3
;kit2.c,183 :: 		lcd_init();
	CALL       _Lcd_Init+0
;kit2.c,185 :: 		lcd_out(2,1,"welcome");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,186 :: 		uart1_init(2400);
	MOVLW      103
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;kit2.c,187 :: 		trisb.f0=0;
	BCF        TRISB+0, 0
;kit2.c,188 :: 		rb0_bit=0;
	BCF        RB0_bit+0, 0
;kit2.c,189 :: 		lcd_out(1,1,"S");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,190 :: 		while(1)
L_main25:
;kit2.c,192 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main27:
	DECFSZ     R13+0, 1
	GOTO       L_main27
	DECFSZ     R12+0, 1
	GOTO       L_main27
	DECFSZ     R11+0, 1
	GOTO       L_main27
	NOP
	NOP
;kit2.c,194 :: 		test[4]='o';
	MOVLW      111
	MOVWF      main_test_L0+4
;kit2.c,195 :: 		test[3]='l';
	MOVLW      108
	MOVWF      main_test_L0+3
;kit2.c,196 :: 		test[2]='l';
	MOVLW      108
	MOVWF      main_test_L0+2
;kit2.c,197 :: 		test[1]='e';
	MOVLW      101
	MOVWF      main_test_L0+1
;kit2.c,198 :: 		test[0]='h';
	MOVLW      104
	MOVWF      main_test_L0+0
;kit2.c,200 :: 		write_tx(0b10100000,test,32);
	MOVLW      160
	MOVWF      FARG_write_tx_add+0
	MOVLW      main_test_L0+0
	MOVWF      FARG_write_tx_buffer+0
	MOVLW      32
	MOVWF      FARG_write_tx_bytes+0
	CALL       _write_tx+0
;kit2.c,202 :: 		CE=1;
	BSF        RC3_bit+0, 3
;kit2.c,203 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main28:
	DECFSZ     R13+0, 1
	GOTO       L_main28
	DECFSZ     R12+0, 1
	GOTO       L_main28
	DECFSZ     R11+0, 1
	GOTO       L_main28
	NOP
	NOP
;kit2.c,204 :: 		CE=0;
	BCF        RC3_bit+0, 3
;kit2.c,205 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main29:
	DECFSZ     R13+0, 1
	GOTO       L_main29
	DECFSZ     R12+0, 1
	GOTO       L_main29
	NOP
	NOP
;kit2.c,206 :: 		temp1=read_add(0x07);
	MOVLW      7
	MOVWF      FARG_read_add_add+0
	CALL       _read_add+0
	MOVF       R0+0, 0
	MOVWF      main_temp1_L0+0
	CLRF       main_temp1_L0+1
;kit2.c,208 :: 		temp1=temp1&0b00100000;
	MOVLW      32
	ANDWF      main_temp1_L0+0, 0
	MOVWF      R3+0
	MOVF       main_temp1_L0+1, 0
	MOVWF      R3+1
	MOVLW      0
	ANDWF      R3+1, 1
	MOVF       R3+0, 0
	MOVWF      main_temp1_L0+0
	MOVF       R3+1, 0
	MOVWF      main_temp1_L0+1
;kit2.c,209 :: 		temp1=temp1>>5;
	MOVLW      5
	MOVWF      R0+0
	MOVF       R3+0, 0
	MOVWF      R1+0
	MOVF       R3+1, 0
	MOVWF      R1+1
	MOVF       R0+0, 0
L__main107:
	BTFSC      STATUS+0, 2
	GOTO       L__main108
	RRF        R1+1, 1
	RRF        R1+0, 1
	BCF        R1+1, 7
	BTFSC      R1+1, 6
	BSF        R1+1, 7
	ADDLW      255
	GOTO       L__main107
L__main108:
	MOVF       R1+0, 0
	MOVWF      main_temp1_L0+0
	MOVF       R1+1, 0
	MOVWF      main_temp1_L0+1
;kit2.c,210 :: 		if(temp1==1)
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main109
	MOVLW      1
	XORWF      R1+0, 0
L__main109:
	BTFSS      STATUS+0, 2
	GOTO       L_main30
;kit2.c,212 :: 		lcd_out(1,1,"data tx   ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,213 :: 		}
	GOTO       L_main31
L_main30:
;kit2.c,215 :: 		lcd_out(1,1,"no data tx");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
L_main31:
;kit2.c,217 :: 		reset();
	CALL       _reset+0
;kit2.c,218 :: 		CE=1;
	BSF        RC3_bit+0, 3
;kit2.c,219 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main32:
	DECFSZ     R13+0, 1
	GOTO       L_main32
	DECFSZ     R12+0, 1
	GOTO       L_main32
	NOP
	NOP
;kit2.c,238 :: 		if(uart1_data_ready())
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main33
;kit2.c,240 :: 		rfid[idx]=uart1_read();
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FLOC__main+0
	CALL       _UART1_Read+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;kit2.c,243 :: 		if(rfid[idx]=='0'&&valid2<10)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L_main36
	MOVLW      128
	XORWF      _valid2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main110
	MOVLW      10
	SUBWF      _valid2+0, 0
L__main110:
	BTFSC      STATUS+0, 0
	GOTO       L_main36
L__main93:
;kit2.c,245 :: 		valid2++;
	INCF       _valid2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid2+1, 1
;kit2.c,246 :: 		}
	GOTO       L_main37
L_main36:
;kit2.c,247 :: 		else if(rfid[idx]=='3'&&valid2<10)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_main40
	MOVLW      128
	XORWF      _valid2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main111
	MOVLW      10
	SUBWF      _valid2+0, 0
L__main111:
	BTFSC      STATUS+0, 0
	GOTO       L_main40
L__main92:
;kit2.c,249 :: 		valid2++;
	INCF       _valid2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid2+1, 1
;kit2.c,250 :: 		}
	GOTO       L_main41
L_main40:
;kit2.c,251 :: 		else if(rfid[idx]=='2'&&valid2<10)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_main44
	MOVLW      128
	XORWF      _valid2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main112
	MOVLW      10
	SUBWF      _valid2+0, 0
L__main112:
	BTFSC      STATUS+0, 0
	GOTO       L_main44
L__main91:
;kit2.c,253 :: 		valid2++;
	INCF       _valid2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid2+1, 1
;kit2.c,254 :: 		}
	GOTO       L_main45
L_main44:
;kit2.c,255 :: 		else if(rfid[idx]=='E'&&valid2==5)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main48
	MOVLW      0
	XORWF      _valid2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main113
	MOVLW      5
	XORWF      _valid2+0, 0
L__main113:
	BTFSS      STATUS+0, 2
	GOTO       L_main48
L__main90:
;kit2.c,257 :: 		valid2++;
	INCF       _valid2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid2+1, 1
;kit2.c,258 :: 		}
	GOTO       L_main49
L_main48:
;kit2.c,259 :: 		else if(rfid[idx]=='8'&&valid2<10)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      56
	BTFSS      STATUS+0, 2
	GOTO       L_main52
	MOVLW      128
	XORWF      _valid2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main114
	MOVLW      10
	SUBWF      _valid2+0, 0
L__main114:
	BTFSC      STATUS+0, 0
	GOTO       L_main52
L__main89:
;kit2.c,261 :: 		valid2++;
	INCF       _valid2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid2+1, 1
;kit2.c,262 :: 		}
	GOTO       L_main53
L_main52:
;kit2.c,265 :: 		valid2=0;
	CLRF       _valid2+0
	CLRF       _valid2+1
;kit2.c,266 :: 		}
L_main53:
L_main49:
L_main45:
L_main41:
L_main37:
;kit2.c,270 :: 		if(rfid[idx]=='0'&&valid1<10) //03002e90b0
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L_main56
	MOVLW      128
	XORWF      _valid1+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main115
	MOVLW      10
	SUBWF      _valid1+0, 0
L__main115:
	BTFSC      STATUS+0, 0
	GOTO       L_main56
L__main88:
;kit2.c,272 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,273 :: 		}
	GOTO       L_main57
L_main56:
;kit2.c,274 :: 		else if(rfid[idx]=='3'&&valid1==1)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_main60
	MOVLW      0
	XORWF      _valid1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main116
	MOVLW      1
	XORWF      _valid1+0, 0
L__main116:
	BTFSS      STATUS+0, 2
	GOTO       L_main60
L__main87:
;kit2.c,276 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,277 :: 		}
	GOTO       L_main61
L_main60:
;kit2.c,278 :: 		else if(rfid[idx]=='2'&&valid1==4)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_main64
	MOVLW      0
	XORWF      _valid1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main117
	MOVLW      4
	XORWF      _valid1+0, 0
L__main117:
	BTFSS      STATUS+0, 2
	GOTO       L_main64
L__main86:
;kit2.c,280 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,281 :: 		}
	GOTO       L_main65
L_main64:
;kit2.c,282 :: 		else if(rfid[idx]=='E'&&valid1==5)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main68
	MOVLW      0
	XORWF      _valid1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main118
	MOVLW      5
	XORWF      _valid1+0, 0
L__main118:
	BTFSS      STATUS+0, 2
	GOTO       L_main68
L__main85:
;kit2.c,284 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,285 :: 		}
	GOTO       L_main69
L_main68:
;kit2.c,286 :: 		else if(rfid[idx]=='9'&&valid1==6)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      57
	BTFSS      STATUS+0, 2
	GOTO       L_main72
	MOVLW      0
	XORWF      _valid1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main119
	MOVLW      6
	XORWF      _valid1+0, 0
L__main119:
	BTFSS      STATUS+0, 2
	GOTO       L_main72
L__main84:
;kit2.c,288 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,289 :: 		}
	GOTO       L_main73
L_main72:
;kit2.c,290 :: 		else if(rfid[idx]=='B'&&valid1==8)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      66
	BTFSS      STATUS+0, 2
	GOTO       L_main76
	MOVLW      0
	XORWF      _valid1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main120
	MOVLW      8
	XORWF      _valid1+0, 0
L__main120:
	BTFSS      STATUS+0, 2
	GOTO       L_main76
L__main83:
;kit2.c,292 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,293 :: 		}
	GOTO       L_main77
L_main76:
;kit2.c,296 :: 		valid1=0;
	CLRF       _valid1+0
	CLRF       _valid1+1
;kit2.c,297 :: 		}
L_main77:
L_main73:
L_main69:
L_main65:
L_main61:
L_main57:
;kit2.c,306 :: 		if(valid2>=10)
	MOVLW      128
	XORWF      _valid2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main121
	MOVLW      10
	SUBWF      _valid2+0, 0
L__main121:
	BTFSS      STATUS+0, 0
	GOTO       L_main78
;kit2.c,308 :: 		lcd_out(2,1,"User2 : 03002E2838");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,309 :: 		lcd_out(2,1,"UnValid");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,310 :: 		valid1=0;
	CLRF       _valid1+0
	CLRF       _valid1+1
;kit2.c,311 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main79:
	DECFSZ     R13+0, 1
	GOTO       L_main79
	DECFSZ     R12+0, 1
	GOTO       L_main79
	DECFSZ     R11+0, 1
	GOTO       L_main79
	NOP
	NOP
;kit2.c,312 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;kit2.c,313 :: 		}
L_main78:
;kit2.c,317 :: 		if(valid1>=10)
	MOVLW      128
	XORWF      _valid1+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main122
	MOVLW      10
	SUBWF      _valid1+0, 0
L__main122:
	BTFSS      STATUS+0, 0
	GOTO       L_main80
;kit2.c,319 :: 		lcd_out(2,1,"User1 : 03002E90B0");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,320 :: 		lcd_out(2,1,"Valid");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,321 :: 		valid1=0;
	CLRF       _valid1+0
	CLRF       _valid1+1
;kit2.c,322 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main81:
	DECFSZ     R13+0, 1
	GOTO       L_main81
	DECFSZ     R12+0, 1
	GOTO       L_main81
	DECFSZ     R11+0, 1
	GOTO       L_main81
	NOP
	NOP
;kit2.c,323 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;kit2.c,324 :: 		}
L_main80:
;kit2.c,327 :: 		lcd_chr_cp(rfid[idx]);
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;kit2.c,328 :: 		idx++;
	INCF       _idx+0, 1
	BTFSC      STATUS+0, 2
	INCF       _idx+1, 1
;kit2.c,329 :: 		if(idx>=10)
	MOVLW      128
	XORWF      _idx+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main123
	MOVLW      10
	SUBWF      _idx+0, 0
L__main123:
	BTFSS      STATUS+0, 0
	GOTO       L_main82
;kit2.c,331 :: 		idx=0;
	CLRF       _idx+0
	CLRF       _idx+1
;kit2.c,332 :: 		lcd_out(1,1,"S");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,333 :: 		}
L_main82:
;kit2.c,335 :: 		}
L_main33:
;kit2.c,339 :: 		}
	GOTO       L_main25
;kit2.c,346 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
