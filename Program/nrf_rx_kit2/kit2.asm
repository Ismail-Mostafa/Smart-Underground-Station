
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
L__rw_register113:
	BTFSC      STATUS+0, 2
	GOTO       L__rw_register114
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__rw_register113
L__rw_register114:
	BTFSC      R0+0, 0
	GOTO       L__rw_register115
	BCF        RC1_bit+0, 1
	GOTO       L__rw_register116
L__rw_register115:
	BSF        RC1_bit+0, 1
L__rw_register116:
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
;kit2.c,135 :: 		write_add(0x00,0x0f);
	CLRF       FARG_write_add_add+0
	MOVLW      15
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit2.c,136 :: 		write_add(0x00,0x0f);
	CLRF       FARG_write_add_add+0
	MOVLW      15
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
;kit2.c,169 :: 		uart1_init(2400);
	MOVLW      103
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
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
;kit2.c,175 :: 		delay_ms(500);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main25:
	DECFSZ     R13+0, 1
	GOTO       L_main25
	DECFSZ     R12+0, 1
	GOTO       L_main25
	DECFSZ     R11+0, 1
	GOTO       L_main25
	NOP
	NOP
;kit2.c,176 :: 		nrf24_config();
	CALL       _nrf24_config+0
;kit2.c,177 :: 		CSN=1;
	BSF        RC2_bit+0, 2
;kit2.c,178 :: 		CE=1;
	BSF        RC3_bit+0, 3
;kit2.c,183 :: 		lcd_init();
	CALL       _Lcd_Init+0
;kit2.c,184 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;kit2.c,187 :: 		trisb.f0=0;
	BCF        TRISB+0, 0
;kit2.c,188 :: 		rb0_bit=0;
	BCF        RB0_bit+0, 0
;kit2.c,189 :: 		trisd.f0=0;
	BCF        TRISD+0, 0
;kit2.c,190 :: 		for(i=0;i<30;i++)
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main26:
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main125
	MOVLW      30
	SUBWF      main_i_L0+0, 0
L__main125:
	BTFSC      STATUS+0, 0
	GOTO       L_main27
;kit2.c,192 :: 		rd0_bit=1;
	BSF        RD0_bit+0, 0
;kit2.c,193 :: 		delay_us(400);
	MOVLW      133
	MOVWF      R13+0
L_main29:
	DECFSZ     R13+0, 1
	GOTO       L_main29
;kit2.c,194 :: 		rd0_bit=0;
	BCF        RD0_bit+0, 0
;kit2.c,195 :: 		delay_us(19600);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      115
	MOVWF      R13+0
L_main30:
	DECFSZ     R13+0, 1
	GOTO       L_main30
	DECFSZ     R12+0, 1
	GOTO       L_main30
;kit2.c,190 :: 		for(i=0;i<30;i++)
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;kit2.c,197 :: 		}
	GOTO       L_main26
L_main27:
;kit2.c,198 :: 		uart1_write_text("TEST");
	MOVLW      ?lstr1_kit2+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;kit2.c,199 :: 		uart1_write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;kit2.c,202 :: 		while(1)
L_main31:
;kit2.c,204 :: 		temp1=read_add(0x07);
	MOVLW      7
	MOVWF      FARG_read_add_add+0
	CALL       _read_add+0
	MOVF       R0+0, 0
	MOVWF      main_temp1_L0+0
	CLRF       main_temp1_L0+1
;kit2.c,205 :: 		if(((temp1&0b01000000)>>6)==1)
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
L__main126:
	BTFSC      STATUS+0, 2
	GOTO       L__main127
	RRF        R1+1, 1
	RRF        R1+0, 1
	BCF        R1+1, 7
	BTFSC      R1+1, 6
	BSF        R1+1, 7
	ADDLW      255
	GOTO       L__main126
L__main127:
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main128
	MOVLW      1
	XORWF      R1+0, 0
L__main128:
	BTFSS      STATUS+0, 2
	GOTO       L_main33
;kit2.c,207 :: 		CE=0;
	BCF        RC3_bit+0, 3
;kit2.c,208 :: 		delay_ms(50);
	MOVLW      65
	MOVWF      R12+0
	MOVLW      238
	MOVWF      R13+0
L_main34:
	DECFSZ     R13+0, 1
	GOTO       L_main34
	DECFSZ     R12+0, 1
	GOTO       L_main34
	NOP
;kit2.c,210 :: 		read_buff(0x61,test,32);
	MOVLW      97
	MOVWF      FARG_read_buff_add+0
	MOVLW      main_test_L0+0
	MOVWF      FARG_read_buff_buffer+0
	MOVLW      32
	MOVWF      FARG_read_buff_bytes+0
	CALL       _read_buff+0
;kit2.c,211 :: 		uart1_write_text(test);
	MOVLW      main_test_L0+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;kit2.c,212 :: 		lcd_out(1,1,test);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_test_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,213 :: 		reset();
	CALL       _reset+0
;kit2.c,214 :: 		CE=1;
	BSF        RC3_bit+0, 3
;kit2.c,216 :: 		}
L_main33:
;kit2.c,235 :: 		if(uart1_data_ready())
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main35
;kit2.c,237 :: 		rfid[idx]=uart1_read();
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FLOC__main+0
	CALL       _UART1_Read+0
	MOVF       FLOC__main+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;kit2.c,240 :: 		if(rfid[idx]=='0'&&valid2<10)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L_main38
	MOVLW      128
	XORWF      _valid2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main129
	MOVLW      10
	SUBWF      _valid2+0, 0
L__main129:
	BTFSC      STATUS+0, 0
	GOTO       L_main38
L__main111:
;kit2.c,242 :: 		valid2++;
	INCF       _valid2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid2+1, 1
;kit2.c,243 :: 		}
	GOTO       L_main39
L_main38:
;kit2.c,244 :: 		else if(rfid[idx]=='3'&&valid2<10)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_main42
	MOVLW      128
	XORWF      _valid2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main130
	MOVLW      10
	SUBWF      _valid2+0, 0
L__main130:
	BTFSC      STATUS+0, 0
	GOTO       L_main42
L__main110:
;kit2.c,246 :: 		valid2++;
	INCF       _valid2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid2+1, 1
;kit2.c,247 :: 		}
	GOTO       L_main43
L_main42:
;kit2.c,248 :: 		else if(rfid[idx]=='2'&&valid2<10)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_main46
	MOVLW      128
	XORWF      _valid2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main131
	MOVLW      10
	SUBWF      _valid2+0, 0
L__main131:
	BTFSC      STATUS+0, 0
	GOTO       L_main46
L__main109:
;kit2.c,250 :: 		valid2++;
	INCF       _valid2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid2+1, 1
;kit2.c,251 :: 		}
	GOTO       L_main47
L_main46:
;kit2.c,252 :: 		else if(rfid[idx]=='E'&&valid2==5)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main50
	MOVLW      0
	XORWF      _valid2+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main132
	MOVLW      5
	XORWF      _valid2+0, 0
L__main132:
	BTFSS      STATUS+0, 2
	GOTO       L_main50
L__main108:
;kit2.c,254 :: 		valid2++;
	INCF       _valid2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid2+1, 1
;kit2.c,255 :: 		}
	GOTO       L_main51
L_main50:
;kit2.c,256 :: 		else if(rfid[idx]=='8'&&valid2<10)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      56
	BTFSS      STATUS+0, 2
	GOTO       L_main54
	MOVLW      128
	XORWF      _valid2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main133
	MOVLW      10
	SUBWF      _valid2+0, 0
L__main133:
	BTFSC      STATUS+0, 0
	GOTO       L_main54
L__main107:
;kit2.c,258 :: 		valid2++;
	INCF       _valid2+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid2+1, 1
;kit2.c,259 :: 		}
	GOTO       L_main55
L_main54:
;kit2.c,262 :: 		valid2=0;
	CLRF       _valid2+0
	CLRF       _valid2+1
;kit2.c,263 :: 		}
L_main55:
L_main51:
L_main47:
L_main43:
L_main39:
;kit2.c,267 :: 		if(rfid[idx]=='0'&&valid1<10) //03002e90b0
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L_main58
	MOVLW      128
	XORWF      _valid1+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main134
	MOVLW      10
	SUBWF      _valid1+0, 0
L__main134:
	BTFSC      STATUS+0, 0
	GOTO       L_main58
L__main106:
;kit2.c,269 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,270 :: 		}
	GOTO       L_main59
L_main58:
;kit2.c,271 :: 		else if(rfid[idx]=='3'&&valid1==1)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L_main62
	MOVLW      0
	XORWF      _valid1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main135
	MOVLW      1
	XORWF      _valid1+0, 0
L__main135:
	BTFSS      STATUS+0, 2
	GOTO       L_main62
L__main105:
;kit2.c,273 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,274 :: 		}
	GOTO       L_main63
L_main62:
;kit2.c,275 :: 		else if(rfid[idx]=='2'&&valid1==4)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L_main66
	MOVLW      0
	XORWF      _valid1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main136
	MOVLW      4
	XORWF      _valid1+0, 0
L__main136:
	BTFSS      STATUS+0, 2
	GOTO       L_main66
L__main104:
;kit2.c,277 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,278 :: 		}
	GOTO       L_main67
L_main66:
;kit2.c,279 :: 		else if(rfid[idx]=='E'&&valid1==5)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main70
	MOVLW      0
	XORWF      _valid1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main137
	MOVLW      5
	XORWF      _valid1+0, 0
L__main137:
	BTFSS      STATUS+0, 2
	GOTO       L_main70
L__main103:
;kit2.c,281 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,282 :: 		}
	GOTO       L_main71
L_main70:
;kit2.c,283 :: 		else if(rfid[idx]=='9'&&valid1==6)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      57
	BTFSS      STATUS+0, 2
	GOTO       L_main74
	MOVLW      0
	XORWF      _valid1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main138
	MOVLW      6
	XORWF      _valid1+0, 0
L__main138:
	BTFSS      STATUS+0, 2
	GOTO       L_main74
L__main102:
;kit2.c,285 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,286 :: 		}
	GOTO       L_main75
L_main74:
;kit2.c,287 :: 		else if(rfid[idx]=='B'&&valid1==8)
	MOVF       _idx+0, 0
	ADDLW      _rfid+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	XORLW      66
	BTFSS      STATUS+0, 2
	GOTO       L_main78
	MOVLW      0
	XORWF      _valid1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main139
	MOVLW      8
	XORWF      _valid1+0, 0
L__main139:
	BTFSS      STATUS+0, 2
	GOTO       L_main78
L__main101:
;kit2.c,289 :: 		valid1++;
	INCF       _valid1+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valid1+1, 1
;kit2.c,290 :: 		}
	GOTO       L_main79
L_main78:
;kit2.c,293 :: 		valid1=0;
	CLRF       _valid1+0
	CLRF       _valid1+1
;kit2.c,294 :: 		}
L_main79:
L_main75:
L_main71:
L_main67:
L_main63:
L_main59:
;kit2.c,303 :: 		if(valid2>=10)
	MOVLW      128
	XORWF      _valid2+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main140
	MOVLW      10
	SUBWF      _valid2+0, 0
L__main140:
	BTFSS      STATUS+0, 0
	GOTO       L_main80
;kit2.c,305 :: 		lcd_out(2,1,"User2 : 03002E2838");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,306 :: 		delay_ms(1000);
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
;kit2.c,307 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;kit2.c,308 :: 		lcd_out(2,1,"UnValid");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,309 :: 		valid2=0;
	CLRF       _valid2+0
	CLRF       _valid2+1
;kit2.c,310 :: 		for(i=0;i<30;i++)
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main82:
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main141
	MOVLW      30
	SUBWF      main_i_L0+0, 0
L__main141:
	BTFSC      STATUS+0, 0
	GOTO       L_main83
;kit2.c,312 :: 		rd0_bit=1;
	BSF        RD0_bit+0, 0
;kit2.c,313 :: 		delay_us(400);
	MOVLW      133
	MOVWF      R13+0
L_main85:
	DECFSZ     R13+0, 1
	GOTO       L_main85
;kit2.c,314 :: 		rd0_bit=0;
	BCF        RD0_bit+0, 0
;kit2.c,315 :: 		delay_us(19600);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      115
	MOVWF      R13+0
L_main86:
	DECFSZ     R13+0, 1
	GOTO       L_main86
	DECFSZ     R12+0, 1
	GOTO       L_main86
;kit2.c,310 :: 		for(i=0;i<30;i++)
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;kit2.c,317 :: 		}
	GOTO       L_main82
L_main83:
;kit2.c,318 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main87:
	DECFSZ     R13+0, 1
	GOTO       L_main87
	DECFSZ     R12+0, 1
	GOTO       L_main87
	DECFSZ     R11+0, 1
	GOTO       L_main87
	NOP
	NOP
;kit2.c,319 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;kit2.c,320 :: 		}
L_main80:
;kit2.c,324 :: 		if(valid1>=10)
	MOVLW      128
	XORWF      _valid1+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main142
	MOVLW      10
	SUBWF      _valid1+0, 0
L__main142:
	BTFSS      STATUS+0, 0
	GOTO       L_main88
;kit2.c,326 :: 		lcd_out(2,1,"User1 : 03002E90B0");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,327 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main89:
	DECFSZ     R13+0, 1
	GOTO       L_main89
	DECFSZ     R12+0, 1
	GOTO       L_main89
	DECFSZ     R11+0, 1
	GOTO       L_main89
	NOP
	NOP
;kit2.c,328 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;kit2.c,329 :: 		lcd_out(2,1,"Valid");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_kit2+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit2.c,330 :: 		valid1=0;
	CLRF       _valid1+0
	CLRF       _valid1+1
;kit2.c,331 :: 		for(i=0;i<30;i++)
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main90:
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main143
	MOVLW      30
	SUBWF      main_i_L0+0, 0
L__main143:
	BTFSC      STATUS+0, 0
	GOTO       L_main91
;kit2.c,333 :: 		rd0_bit=1;
	BSF        RD0_bit+0, 0
;kit2.c,334 :: 		delay_us(1500);
	MOVLW      2
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main93:
	DECFSZ     R13+0, 1
	GOTO       L_main93
	DECFSZ     R12+0, 1
	GOTO       L_main93
	NOP
	NOP
;kit2.c,335 :: 		rd0_bit=0;
	BCF        RD0_bit+0, 0
;kit2.c,336 :: 		delay_us(18500);
	MOVLW      25
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_main94:
	DECFSZ     R13+0, 1
	GOTO       L_main94
	DECFSZ     R12+0, 1
	GOTO       L_main94
;kit2.c,331 :: 		for(i=0;i<30;i++)
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;kit2.c,338 :: 		}
	GOTO       L_main90
L_main91:
;kit2.c,339 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main95:
	DECFSZ     R13+0, 1
	GOTO       L_main95
	DECFSZ     R12+0, 1
	GOTO       L_main95
	DECFSZ     R11+0, 1
	GOTO       L_main95
	NOP
	NOP
;kit2.c,340 :: 		for(i=0;i<30;i++)
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main96:
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main144
	MOVLW      30
	SUBWF      main_i_L0+0, 0
L__main144:
	BTFSC      STATUS+0, 0
	GOTO       L_main97
;kit2.c,342 :: 		rd0_bit=1;
	BSF        RD0_bit+0, 0
;kit2.c,343 :: 		delay_us(400);
	MOVLW      133
	MOVWF      R13+0
L_main99:
	DECFSZ     R13+0, 1
	GOTO       L_main99
;kit2.c,344 :: 		rd0_bit=0;
	BCF        RD0_bit+0, 0
;kit2.c,345 :: 		delay_us(19600);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      115
	MOVWF      R13+0
L_main100:
	DECFSZ     R13+0, 1
	GOTO       L_main100
	DECFSZ     R12+0, 1
	GOTO       L_main100
;kit2.c,340 :: 		for(i=0;i<30;i++)
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;kit2.c,347 :: 		}
	GOTO       L_main96
L_main97:
;kit2.c,351 :: 		lcd_cmd(_lcd_clear);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;kit2.c,352 :: 		}
L_main88:
;kit2.c,354 :: 		}
L_main35:
;kit2.c,358 :: 		}
	GOTO       L_main31
;kit2.c,365 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
