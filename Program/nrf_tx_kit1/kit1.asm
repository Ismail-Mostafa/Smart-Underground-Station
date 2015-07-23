
_rw_register:

;kit1.c,44 :: 		char rw_register(char add)
;kit1.c,46 :: 		char rec=0;
	CLRF       rw_register_rec_L0+0
;kit1.c,48 :: 		for(cou=0;cou<8;cou++)
	CLRF       R3+0
L_rw_register0:
	MOVLW      8
	SUBWF      R3+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_rw_register1
;kit1.c,50 :: 		MOSI=(add&0x80)>>7;
	MOVLW      128
	ANDWF      FARG_rw_register_add+0, 0
	MOVWF      R2+0
	MOVLW      7
	MOVWF      R1+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__rw_register109:
	BTFSC      STATUS+0, 2
	GOTO       L__rw_register110
	RRF        R0+0, 1
	BCF        R0+0, 7
	ADDLW      255
	GOTO       L__rw_register109
L__rw_register110:
	BTFSC      R0+0, 0
	GOTO       L__rw_register111
	BCF        RC3_bit+0, 3
	GOTO       L__rw_register112
L__rw_register111:
	BSF        RC3_bit+0, 3
L__rw_register112:
;kit1.c,51 :: 		add=add<<1;
	RLF        FARG_rw_register_add+0, 1
	BCF        FARG_rw_register_add+0, 0
;kit1.c,52 :: 		rec=rec<<1;
	RLF        rw_register_rec_L0+0, 1
	BCF        rw_register_rec_L0+0, 0
;kit1.c,53 :: 		CSK=1;
	BSF        RC2_bit+0, 2
;kit1.c,54 :: 		rec|=MISO;
	CLRF       R0+0
	BTFSC      RC4_bit+0, 4
	INCF       R0+0, 1
	MOVF       R0+0, 0
	IORWF      rw_register_rec_L0+0, 1
;kit1.c,55 :: 		CSK=0;
	BCF        RC2_bit+0, 2
;kit1.c,48 :: 		for(cou=0;cou<8;cou++)
	INCF       R3+0, 1
;kit1.c,56 :: 		}
	GOTO       L_rw_register0
L_rw_register1:
;kit1.c,57 :: 		return rec;
	MOVF       rw_register_rec_L0+0, 0
	MOVWF      R0+0
;kit1.c,58 :: 		}
L_end_rw_register:
	RETURN
; end of _rw_register

_read_add:

;kit1.c,60 :: 		char read_add(char add)
;kit1.c,63 :: 		CSN=0;
	BCF        RC1_bit+0, 1
;kit1.c,64 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_read_add3:
	DECFSZ     R13+0, 1
	GOTO       L_read_add3
;kit1.c,65 :: 		rw_register(add);
	MOVF       FARG_read_add_add+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;kit1.c,66 :: 		value=rw_register(0xFF);
	MOVLW      255
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
	MOVF       R0+0, 0
	MOVWF      read_add_value_L0+0
;kit1.c,67 :: 		CSN=1;
	BSF        RC1_bit+0, 1
;kit1.c,68 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_read_add4:
	DECFSZ     R13+0, 1
	GOTO       L_read_add4
;kit1.c,69 :: 		return value;
	MOVF       read_add_value_L0+0, 0
	MOVWF      R0+0
;kit1.c,70 :: 		}
L_end_read_add:
	RETURN
; end of _read_add

_write_add:

;kit1.c,72 :: 		char write_add(char add,char value)
;kit1.c,75 :: 		add=add|0b00100000;
	BSF        FARG_write_add_add+0, 5
;kit1.c,76 :: 		CSN=0;
	BCF        RC1_bit+0, 1
;kit1.c,77 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_add5:
	DECFSZ     R13+0, 1
	GOTO       L_write_add5
;kit1.c,78 :: 		status=rw_register(add);
	MOVF       FARG_write_add_add+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;kit1.c,79 :: 		rw_register(value);
	MOVF       FARG_write_add_value+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;kit1.c,80 :: 		CSN=1;
	BSF        RC1_bit+0, 1
;kit1.c,81 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_add6:
	DECFSZ     R13+0, 1
	GOTO       L_write_add6
;kit1.c,82 :: 		return value;
	MOVF       FARG_write_add_value+0, 0
	MOVWF      R0+0
;kit1.c,83 :: 		}
L_end_write_add:
	RETURN
; end of _write_add

_read_buff:

;kit1.c,86 :: 		void read_buff(char add,char buffer[],char bytes)
;kit1.c,89 :: 		CSN=0;
	BCF        RC1_bit+0, 1
;kit1.c,90 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_read_buff7:
	DECFSZ     R13+0, 1
	GOTO       L_read_buff7
;kit1.c,91 :: 		rw_register(add);
	MOVF       FARG_read_buff_add+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;kit1.c,92 :: 		for(counter=0;counter<bytes;counter++)
	CLRF       read_buff_counter_L0+0
L_read_buff8:
	MOVF       FARG_read_buff_bytes+0, 0
	SUBWF      read_buff_counter_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_read_buff9
;kit1.c,94 :: 		buffer[counter]=rw_register(0xFF);
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
;kit1.c,92 :: 		for(counter=0;counter<bytes;counter++)
	INCF       read_buff_counter_L0+0, 1
;kit1.c,95 :: 		}
	GOTO       L_read_buff8
L_read_buff9:
;kit1.c,96 :: 		CSN=1;
	BSF        RC1_bit+0, 1
;kit1.c,97 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_read_buff11:
	DECFSZ     R13+0, 1
	GOTO       L_read_buff11
;kit1.c,98 :: 		}
L_end_read_buff:
	RETURN
; end of _read_buff

_write_buff:

;kit1.c,100 :: 		void write_buff(char add,char buffer[],char bytes)
;kit1.c,103 :: 		CSN=0;
	BCF        RC1_bit+0, 1
;kit1.c,104 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_buff12:
	DECFSZ     R13+0, 1
	GOTO       L_write_buff12
;kit1.c,105 :: 		add=add|0b00100000;
	MOVLW      32
	IORWF      FARG_write_buff_add+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FARG_write_buff_add+0
;kit1.c,106 :: 		rw_register(add);
	MOVF       R0+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;kit1.c,107 :: 		for(counter=0;counter<bytes;counter++)
	CLRF       write_buff_counter_L0+0
L_write_buff13:
	MOVF       FARG_write_buff_bytes+0, 0
	SUBWF      write_buff_counter_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_write_buff14
;kit1.c,109 :: 		rw_register(buffer[counter]);
	MOVF       write_buff_counter_L0+0, 0
	ADDWF      FARG_write_buff_buffer+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;kit1.c,107 :: 		for(counter=0;counter<bytes;counter++)
	INCF       write_buff_counter_L0+0, 1
;kit1.c,110 :: 		}
	GOTO       L_write_buff13
L_write_buff14:
;kit1.c,111 :: 		CSN=1;
	BSF        RC1_bit+0, 1
;kit1.c,112 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_buff16:
	DECFSZ     R13+0, 1
	GOTO       L_write_buff16
;kit1.c,113 :: 		}
L_end_write_buff:
	RETURN
; end of _write_buff

_write_tx:

;kit1.c,115 :: 		void write_tx(char add,char buffer[],char bytes)
;kit1.c,118 :: 		CSN=0;
	BCF        RC1_bit+0, 1
;kit1.c,119 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_tx17:
	DECFSZ     R13+0, 1
	GOTO       L_write_tx17
;kit1.c,120 :: 		rw_register(add);
	MOVF       FARG_write_tx_add+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;kit1.c,121 :: 		for(counter=0;counter<bytes;counter++)
	CLRF       write_tx_counter_L0+0
L_write_tx18:
	MOVF       FARG_write_tx_bytes+0, 0
	SUBWF      write_tx_counter_L0+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_write_tx19
;kit1.c,123 :: 		rw_register(buffer[counter]);
	MOVF       write_tx_counter_L0+0, 0
	ADDWF      FARG_write_tx_buffer+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_rw_register_add+0
	CALL       _rw_register+0
;kit1.c,121 :: 		for(counter=0;counter<bytes;counter++)
	INCF       write_tx_counter_L0+0, 1
;kit1.c,124 :: 		}
	GOTO       L_write_tx18
L_write_tx19:
;kit1.c,125 :: 		CSN=1;
	BSF        RC1_bit+0, 1
;kit1.c,126 :: 		delay_us(10);
	MOVLW      3
	MOVWF      R13+0
L_write_tx21:
	DECFSZ     R13+0, 1
	GOTO       L_write_tx21
;kit1.c,127 :: 		}
L_end_write_tx:
	RETURN
; end of _write_tx

_nrf24_config:

;kit1.c,129 :: 		void nrf24_config()
;kit1.c,131 :: 		char add1[5]={'a','a','a','a','a'};
;kit1.c,132 :: 		CSN=0;
	BCF        RC1_bit+0, 1
;kit1.c,133 :: 		CE=0;
	BCF        RC0_bit+0, 0
;kit1.c,134 :: 		delay_ms(20);
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
;kit1.c,136 :: 		write_add(0x01,0x3f);
	MOVLW      1
	MOVWF      FARG_write_add_add+0
	MOVLW      63
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit1.c,137 :: 		write_add(0x02,0x03);
	MOVLW      2
	MOVWF      FARG_write_add_add+0
	MOVLW      3
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit1.c,138 :: 		write_add(0x03,0x03);
	MOVLW      3
	MOVWF      FARG_write_add_add+0
	MOVLW      3
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit1.c,139 :: 		write_add(0x04,0x4f);
	MOVLW      4
	MOVWF      FARG_write_add_add+0
	MOVLW      79
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit1.c,140 :: 		write_add(0x05,0x4c);
	MOVLW      5
	MOVWF      FARG_write_add_add+0
	MOVLW      76
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit1.c,141 :: 		write_add(0x06,0x07);
	MOVLW      6
	MOVWF      FARG_write_add_add+0
	MOVLW      7
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit1.c,142 :: 		write_add(0x11,0x20);
	MOVLW      17
	MOVWF      FARG_write_add_add+0
	MOVLW      32
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit1.c,143 :: 		write_add(0x1C,0x00);
	MOVLW      28
	MOVWF      FARG_write_add_add+0
	CLRF       FARG_write_add_value+0
	CALL       _write_add+0
;kit1.c,144 :: 		write_add(0x1D,0x00);
	MOVLW      29
	MOVWF      FARG_write_add_add+0
	CLRF       FARG_write_add_value+0
	CALL       _write_add+0
;kit1.c,145 :: 		write_add(0x00,0x0e);
	CLRF       FARG_write_add_add+0
	MOVLW      14
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit1.c,146 :: 		write_add(0x00,0x0e);
	CLRF       FARG_write_add_add+0
	MOVLW      14
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit1.c,147 :: 		delay_ms(5);
	MOVLW      7
	MOVWF      R12+0
	MOVLW      125
	MOVWF      R13+0
L_nrf24_config23:
	DECFSZ     R13+0, 1
	GOTO       L_nrf24_config23
	DECFSZ     R12+0, 1
	GOTO       L_nrf24_config23
;kit1.c,149 :: 		CSN=1;
	BSF        RC1_bit+0, 1
;kit1.c,150 :: 		CE=1;
	BSF        RC0_bit+0, 0
;kit1.c,151 :: 		delay_ms(20);
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
;kit1.c,155 :: 		}
L_end_nrf24_config:
	RETURN
; end of _nrf24_config

_reset:

;kit1.c,157 :: 		void reset()
;kit1.c,159 :: 		write_add(0x07,0x7E);
	MOVLW      7
	MOVWF      FARG_write_add_add+0
	MOVLW      126
	MOVWF      FARG_write_add_value+0
	CALL       _write_add+0
;kit1.c,160 :: 		read_add(0xE1);
	MOVLW      225
	MOVWF      FARG_read_add_add+0
	CALL       _read_add+0
;kit1.c,161 :: 		read_add(0xE2);
	MOVLW      226
	MOVWF      FARG_read_add_add+0
	CALL       _read_add+0
;kit1.c,162 :: 		}
L_end_reset:
	RETURN
; end of _reset

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;kit1.c,166 :: 		void interrupt()
;kit1.c,169 :: 		sec++;
	INCF       _sec+0, 1
	BTFSC      STATUS+0, 2
	INCF       _sec+1, 1
;kit1.c,170 :: 		if(sec>1000)
	MOVLW      128
	XORLW      3
	MOVWF      R0+0
	MOVLW      128
	XORWF      _sec+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt122
	MOVF       _sec+0, 0
	SUBLW      232
L__interrupt122:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt25
;kit1.c,171 :: 		sec=0;
	CLRF       _sec+0
	CLRF       _sec+1
L_interrupt25:
;kit1.c,172 :: 		INTCON.TMR0IF=0;
	BCF        INTCON+0, 2
;kit1.c,173 :: 		}
L_end_interrupt:
L__interrupt121:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_count_ud:

;kit1.c,176 :: 		void count_ud()
;kit1.c,178 :: 		ldr1=adc_read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _ldr1+0
	MOVF       R0+1, 0
	MOVWF      _ldr1+1
;kit1.c,179 :: 		ldr2=adc_read(2);
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _ldr2+0
	MOVF       R0+1, 0
	MOVWF      _ldr2+1
;kit1.c,182 :: 		if(ldr1>=600)
	MOVLW      128
	XORWF      _ldr1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      2
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__count_ud124
	MOVLW      88
	SUBWF      _ldr1+0, 0
L__count_ud124:
	BTFSS      STATUS+0, 0
	GOTO       L_count_ud26
;kit1.c,184 :: 		count++;
	INCF       _count+0, 1
	BTFSC      STATUS+0, 2
	INCF       _count+1, 1
;kit1.c,185 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_count_ud27:
	DECFSZ     R13+0, 1
	GOTO       L_count_ud27
	DECFSZ     R12+0, 1
	GOTO       L_count_ud27
	DECFSZ     R11+0, 1
	GOTO       L_count_ud27
	NOP
	NOP
;kit1.c,186 :: 		}
L_count_ud26:
;kit1.c,187 :: 		if(ldr2>=300)
	MOVLW      128
	XORWF      _ldr2+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      1
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__count_ud125
	MOVLW      44
	SUBWF      _ldr2+0, 0
L__count_ud125:
	BTFSS      STATUS+0, 0
	GOTO       L_count_ud28
;kit1.c,189 :: 		count--;
	MOVLW      1
	SUBWF      _count+0, 1
	BTFSS      STATUS+0, 0
	DECF       _count+1, 1
;kit1.c,190 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_count_ud29:
	DECFSZ     R13+0, 1
	GOTO       L_count_ud29
	DECFSZ     R12+0, 1
	GOTO       L_count_ud29
	DECFSZ     R11+0, 1
	GOTO       L_count_ud29
	NOP
	NOP
;kit1.c,191 :: 		if(count<0)
	MOVLW      128
	XORWF      _count+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__count_ud126
	MOVLW      0
	SUBWF      _count+0, 0
L__count_ud126:
	BTFSC      STATUS+0, 0
	GOTO       L_count_ud30
;kit1.c,192 :: 		count=0;
	CLRF       _count+0
	CLRF       _count+1
L_count_ud30:
;kit1.c,193 :: 		}
L_count_ud28:
;kit1.c,195 :: 		}
L_end_count_ud:
	RETURN
; end of _count_ud

_main:

;kit1.c,205 :: 		void main()
;kit1.c,212 :: 		INTCON=0b11100000;
	MOVLW      224
	MOVWF      INTCON+0
;kit1.c,213 :: 		INTCON.TMR0IE=1;
	BSF        INTCON+0, 5
;kit1.c,214 :: 		OPTION_REG=0b11000111;
	MOVLW      199
	MOVWF      OPTION_REG+0
;kit1.c,216 :: 		CE_DIR=0;
	BCF        TRISC0_bit+0, 0
;kit1.c,217 :: 		CSN_DIR=0;
	BCF        TRISC1_bit+0, 1
;kit1.c,218 :: 		CSK_DIR=0;
	BCF        TRISC2_bit+0, 2
;kit1.c,219 :: 		MOSI_DIR=0;
	BCF        TRISC3_bit+0, 3
;kit1.c,220 :: 		MISO_DIR=1;
	BSF        TRISC4_bit+0, 4
;kit1.c,222 :: 		nrf24_config();
	CALL       _nrf24_config+0
;kit1.c,223 :: 		CSN=1;
	BSF        RC1_bit+0, 1
;kit1.c,224 :: 		CE=1;
	BSF        RC0_bit+0, 0
;kit1.c,225 :: 		lcd_init();
	CALL       _Lcd_Init+0
;kit1.c,227 :: 		trisd=0b00000100;
	MOVLW      4
	MOVWF      TRISD+0
;kit1.c,228 :: 		portd=0;
	CLRF       PORTD+0
;kit1.c,229 :: 		for(j=0;j<30;j++)
	CLRF       _j+0
	CLRF       _j+1
L_main31:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main128
	MOVLW      30
	SUBWF      _j+0, 0
L__main128:
	BTFSC      STATUS+0, 0
	GOTO       L_main32
;kit1.c,231 :: 		rd0_bit=1;
	BSF        RD0_bit+0, 0
;kit1.c,232 :: 		delay_us(600);
	MOVLW      199
	MOVWF      R13+0
L_main34:
	DECFSZ     R13+0, 1
	GOTO       L_main34
	NOP
	NOP
;kit1.c,233 :: 		rd0_bit=0;
	BCF        RD0_bit+0, 0
;kit1.c,234 :: 		delay_us(19400);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	NOP
;kit1.c,229 :: 		for(j=0;j<30;j++)
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;kit1.c,235 :: 		}
	GOTO       L_main31
L_main32:
;kit1.c,236 :: 		for(j=0;j<30;j++)
	CLRF       _j+0
	CLRF       _j+1
L_main36:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main129
	MOVLW      30
	SUBWF      _j+0, 0
L__main129:
	BTFSC      STATUS+0, 0
	GOTO       L_main37
;kit1.c,238 :: 		rd1_bit=1;
	BSF        RD1_bit+0, 1
;kit1.c,239 :: 		delay_us(600);
	MOVLW      199
	MOVWF      R13+0
L_main39:
	DECFSZ     R13+0, 1
	GOTO       L_main39
	NOP
	NOP
;kit1.c,240 :: 		rd1_bit=0;
	BCF        RD1_bit+0, 1
;kit1.c,241 :: 		delay_us(19400);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main40:
	DECFSZ     R13+0, 1
	GOTO       L_main40
	DECFSZ     R12+0, 1
	GOTO       L_main40
	NOP
;kit1.c,236 :: 		for(j=0;j<30;j++)
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;kit1.c,242 :: 		}
	GOTO       L_main36
L_main37:
;kit1.c,246 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main41:
	DECFSZ     R13+0, 1
	GOTO       L_main41
	DECFSZ     R12+0, 1
	GOTO       L_main41
	DECFSZ     R11+0, 1
	GOTO       L_main41
	NOP
	NOP
;kit1.c,254 :: 		count=2;
	MOVLW      2
	MOVWF      _count+0
	MOVLW      0
	MOVWF      _count+1
;kit1.c,255 :: 		while(1)
L_main42:
;kit1.c,257 :: 		if(start_f==0)
	MOVLW      0
	XORWF      _start_f+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main130
	MOVLW      0
	XORWF      _start_f+0, 0
L__main130:
	BTFSS      STATUS+0, 2
	GOTO       L_main44
;kit1.c,259 :: 		rd3_bit=1;
	BSF        RD3_bit+0, 3
;kit1.c,260 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main45:
	DECFSZ     R13+0, 1
	GOTO       L_main45
	DECFSZ     R12+0, 1
	GOTO       L_main45
	DECFSZ     R11+0, 1
	GOTO       L_main45
	NOP
	NOP
;kit1.c,261 :: 		rd3_bit=0;
	BCF        RD3_bit+0, 3
;kit1.c,263 :: 		for(j=0;j<30;j++)
	CLRF       _j+0
	CLRF       _j+1
L_main46:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main131
	MOVLW      30
	SUBWF      _j+0, 0
L__main131:
	BTFSC      STATUS+0, 0
	GOTO       L_main47
;kit1.c,265 :: 		rd0_bit=1;
	BSF        RD0_bit+0, 0
;kit1.c,266 :: 		delay_us(1500);
	MOVLW      2
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main49:
	DECFSZ     R13+0, 1
	GOTO       L_main49
	DECFSZ     R12+0, 1
	GOTO       L_main49
	NOP
	NOP
;kit1.c,267 :: 		rd0_bit=0;
	BCF        RD0_bit+0, 0
;kit1.c,268 :: 		delay_us(18500);
	MOVLW      25
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_main50:
	DECFSZ     R13+0, 1
	GOTO       L_main50
	DECFSZ     R12+0, 1
	GOTO       L_main50
;kit1.c,263 :: 		for(j=0;j<30;j++)
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;kit1.c,269 :: 		}
	GOTO       L_main46
L_main47:
;kit1.c,270 :: 		sec=0;
	CLRF       _sec+0
	CLRF       _sec+1
;kit1.c,271 :: 		while(sec<70)
L_main51:
	MOVLW      128
	XORWF      _sec+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main132
	MOVLW      70
	SUBWF      _sec+0, 0
L__main132:
	BTFSC      STATUS+0, 0
	GOTO       L_main52
;kit1.c,273 :: 		count_ud();
	CALL       _count_ud+0
;kit1.c,274 :: 		a  =count/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _count+0, 0
	MOVWF      R0+0
	MOVF       _count+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _a+0
;kit1.c,275 :: 		b =count%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _count+0, 0
	MOVWF      R0+0
	MOVF       _count+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _b+0
;kit1.c,276 :: 		lcd_out(2,1,"count=");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_kit1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit1.c,277 :: 		lcd_chr(2,8,a+48);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _a+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;kit1.c,278 :: 		lcd_chr(2,9,b+48);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _b+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;kit1.c,279 :: 		v=adc_read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _v+0
	MOVF       R0+1, 0
	MOVWF      _v+1
;kit1.c,280 :: 		t=0.4887*v;
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
	MOVWF      _t+0
	MOVF       R0+1, 0
	MOVWF      _t+1
;kit1.c,281 :: 		a  =t/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _a+0
;kit1.c,282 :: 		b =t%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _t+0, 0
	MOVWF      R0+0
	MOVF       _t+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVF       FLOC__main+0, 0
	MOVWF      _b+0
;kit1.c,283 :: 		a  =t/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _t+0, 0
	MOVWF      R0+0
	MOVF       _t+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _a+0
;kit1.c,284 :: 		b =t%10;
	MOVF       FLOC__main+0, 0
	MOVWF      _b+0
;kit1.c,285 :: 		lcd_out(3,1,"temp=");
	MOVLW      3
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_kit1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit1.c,286 :: 		lcd_chr(3,7,a+48);
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _a+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;kit1.c,287 :: 		lcd_chr(3,8,b+48);
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _b+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;kit1.c,288 :: 		}
	GOTO       L_main51
L_main52:
;kit1.c,289 :: 		for(j=0;j<30;j++)
	CLRF       _j+0
	CLRF       _j+1
L_main53:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main133
	MOVLW      30
	SUBWF      _j+0, 0
L__main133:
	BTFSC      STATUS+0, 0
	GOTO       L_main54
;kit1.c,291 :: 		rd0_bit=1;
	BSF        RD0_bit+0, 0
;kit1.c,292 :: 		delay_us(600);
	MOVLW      199
	MOVWF      R13+0
L_main56:
	DECFSZ     R13+0, 1
	GOTO       L_main56
	NOP
	NOP
;kit1.c,293 :: 		rd0_bit=0;
	BCF        RD0_bit+0, 0
;kit1.c,294 :: 		delay_us(19400);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main57:
	DECFSZ     R13+0, 1
	GOTO       L_main57
	DECFSZ     R12+0, 1
	GOTO       L_main57
	NOP
;kit1.c,289 :: 		for(j=0;j<30;j++)
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;kit1.c,295 :: 		}
	GOTO       L_main53
L_main54:
;kit1.c,298 :: 		for(j=0;j<30;j++)
	CLRF       _j+0
	CLRF       _j+1
L_main58:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main134
	MOVLW      30
	SUBWF      _j+0, 0
L__main134:
	BTFSC      STATUS+0, 0
	GOTO       L_main59
;kit1.c,300 :: 		rd1_bit=1;
	BSF        RD1_bit+0, 1
;kit1.c,301 :: 		delay_us(1500);
	MOVLW      2
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main61:
	DECFSZ     R13+0, 1
	GOTO       L_main61
	DECFSZ     R12+0, 1
	GOTO       L_main61
	NOP
	NOP
;kit1.c,302 :: 		rd1_bit=0;
	BCF        RD1_bit+0, 1
;kit1.c,303 :: 		delay_us(18500);
	MOVLW      25
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_main62:
	DECFSZ     R13+0, 1
	GOTO       L_main62
	DECFSZ     R12+0, 1
	GOTO       L_main62
;kit1.c,298 :: 		for(j=0;j<30;j++)
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;kit1.c,304 :: 		}
	GOTO       L_main58
L_main59:
;kit1.c,305 :: 		sec=0;
	CLRF       _sec+0
	CLRF       _sec+1
;kit1.c,306 :: 		while(sec<100&&count<=5)
L_main63:
	MOVLW      128
	XORWF      _sec+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main135
	MOVLW      100
	SUBWF      _sec+0, 0
L__main135:
	BTFSC      STATUS+0, 0
	GOTO       L_main64
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _count+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main136
	MOVF       _count+0, 0
	SUBLW      5
L__main136:
	BTFSS      STATUS+0, 0
	GOTO       L_main64
L__main107:
;kit1.c,308 :: 		count_ud();
	CALL       _count_ud+0
;kit1.c,309 :: 		a  =count/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _count+0, 0
	MOVWF      R0+0
	MOVF       _count+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _a+0
;kit1.c,310 :: 		b =count%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _count+0, 0
	MOVWF      R0+0
	MOVF       _count+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _b+0
;kit1.c,311 :: 		lcd_out(2,1,"count=");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_kit1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit1.c,312 :: 		lcd_chr(2,8,a+48);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _a+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;kit1.c,313 :: 		lcd_chr(2,9,b+48);
	MOVLW      2
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _b+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;kit1.c,314 :: 		v=adc_read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _v+0
	MOVF       R0+1, 0
	MOVWF      _v+1
;kit1.c,315 :: 		t=0.4887*v;
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
	MOVWF      _t+0
	MOVF       R0+1, 0
	MOVWF      _t+1
;kit1.c,316 :: 		a  =t/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _a+0
;kit1.c,317 :: 		b =t%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _t+0, 0
	MOVWF      R0+0
	MOVF       _t+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       R0+1, 0
	MOVWF      FLOC__main+1
	MOVF       FLOC__main+0, 0
	MOVWF      _b+0
;kit1.c,318 :: 		a  =t/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _t+0, 0
	MOVWF      R0+0
	MOVF       _t+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _a+0
;kit1.c,319 :: 		b =t%10;
	MOVF       FLOC__main+0, 0
	MOVWF      _b+0
;kit1.c,320 :: 		lcd_out(3,1,"temp=");
	MOVLW      3
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_kit1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit1.c,321 :: 		lcd_chr(3,7,a+48);
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _a+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;kit1.c,322 :: 		lcd_chr(3,8,b+48);
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _b+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;kit1.c,323 :: 		}
	GOTO       L_main63
L_main64:
;kit1.c,324 :: 		for(j=0;j<30;j++)
	CLRF       _j+0
	CLRF       _j+1
L_main67:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main137
	MOVLW      30
	SUBWF      _j+0, 0
L__main137:
	BTFSC      STATUS+0, 0
	GOTO       L_main68
;kit1.c,326 :: 		rd1_bit=1;
	BSF        RD1_bit+0, 1
;kit1.c,327 :: 		delay_us(600);
	MOVLW      199
	MOVWF      R13+0
L_main70:
	DECFSZ     R13+0, 1
	GOTO       L_main70
	NOP
	NOP
;kit1.c,328 :: 		rd1_bit=0;
	BCF        RD1_bit+0, 1
;kit1.c,329 :: 		delay_us(19400);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main71:
	DECFSZ     R13+0, 1
	GOTO       L_main71
	DECFSZ     R12+0, 1
	GOTO       L_main71
	NOP
;kit1.c,324 :: 		for(j=0;j<30;j++)
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;kit1.c,330 :: 		}
	GOTO       L_main67
L_main68:
;kit1.c,331 :: 		rd3_bit=1;
	BSF        RD3_bit+0, 3
;kit1.c,332 :: 		start_f=1;
	MOVLW      1
	MOVWF      _start_f+0
	MOVLW      0
	MOVWF      _start_f+1
;kit1.c,334 :: 		}
L_main44:
;kit1.c,336 :: 		if(sec>=50)
	MOVLW      128
	XORWF      _sec+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main138
	MOVLW      50
	SUBWF      _sec+0, 0
L__main138:
	BTFSS      STATUS+0, 0
	GOTO       L_main72
;kit1.c,338 :: 		test[4]='C';
	MOVLW      67
	MOVWF      _test+4
;kit1.c,339 :: 		test[3]=b+48;
	MOVLW      48
	ADDWF      _b+0, 0
	MOVWF      _test+3
;kit1.c,340 :: 		test[2]=a+48;
	MOVLW      48
	ADDWF      _a+0, 0
	MOVWF      _test+2
;kit1.c,341 :: 		test[1]='=';
	MOVLW      61
	MOVWF      _test+1
;kit1.c,342 :: 		test[0]='T';
	MOVLW      84
	MOVWF      _test+0
;kit1.c,343 :: 		if(fire_f==1)
	MOVLW      0
	XORWF      _fire_f+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main139
	MOVLW      1
	XORWF      _fire_f+0, 0
L__main139:
	BTFSS      STATUS+0, 2
	GOTO       L_main73
;kit1.c,345 :: 		test[10]=13;
	MOVLW      13
	MOVWF      _test+10
;kit1.c,346 :: 		test[9]='E';
	MOVLW      69
	MOVWF      _test+9
;kit1.c,347 :: 		test[8]='R';
	MOVLW      82
	MOVWF      _test+8
;kit1.c,348 :: 		test[7]='I';
	MOVLW      73
	MOVWF      _test+7
;kit1.c,349 :: 		test[6]='F';
	MOVLW      70
	MOVWF      _test+6
;kit1.c,350 :: 		test[5]=' ';
	MOVLW      32
	MOVWF      _test+5
;kit1.c,351 :: 		}
	GOTO       L_main74
L_main73:
;kit1.c,354 :: 		test[10]=13;
	MOVLW      13
	MOVWF      _test+10
;kit1.c,355 :: 		test[9]=' ';
	MOVLW      32
	MOVWF      _test+9
;kit1.c,356 :: 		test[8]=' ';
	MOVLW      32
	MOVWF      _test+8
;kit1.c,357 :: 		test[7]=' ';
	MOVLW      32
	MOVWF      _test+7
;kit1.c,358 :: 		test[6]=' ';
	MOVLW      32
	MOVWF      _test+6
;kit1.c,359 :: 		test[5]=' ';
	MOVLW      32
	MOVWF      _test+5
;kit1.c,360 :: 		}
L_main74:
;kit1.c,364 :: 		write_tx(0b10100000,test,32);
	MOVLW      160
	MOVWF      FARG_write_tx_add+0
	MOVLW      _test+0
	MOVWF      FARG_write_tx_buffer+0
	MOVLW      32
	MOVWF      FARG_write_tx_bytes+0
	CALL       _write_tx+0
;kit1.c,366 :: 		CE=1;
	BSF        RC0_bit+0, 0
;kit1.c,367 :: 		delay_ms(1000);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main75:
	DECFSZ     R13+0, 1
	GOTO       L_main75
	DECFSZ     R12+0, 1
	GOTO       L_main75
	DECFSZ     R11+0, 1
	GOTO       L_main75
	NOP
	NOP
;kit1.c,368 :: 		CE=0;
	BCF        RC0_bit+0, 0
;kit1.c,369 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main76:
	DECFSZ     R13+0, 1
	GOTO       L_main76
	DECFSZ     R12+0, 1
	GOTO       L_main76
	NOP
	NOP
;kit1.c,370 :: 		temp1=read_add(0x07);
	MOVLW      7
	MOVWF      FARG_read_add_add+0
	CALL       _read_add+0
	MOVF       R0+0, 0
	MOVWF      _temp1+0
	CLRF       _temp1+1
;kit1.c,372 :: 		temp1=temp1&0b00100000;
	MOVLW      32
	ANDWF      _temp1+0, 0
	MOVWF      R3+0
	MOVF       _temp1+1, 0
	MOVWF      R3+1
	MOVLW      0
	ANDWF      R3+1, 1
	MOVF       R3+0, 0
	MOVWF      _temp1+0
	MOVF       R3+1, 0
	MOVWF      _temp1+1
;kit1.c,373 :: 		temp1=temp1>>5;
	MOVLW      5
	MOVWF      R0+0
	MOVF       R3+0, 0
	MOVWF      R1+0
	MOVF       R3+1, 0
	MOVWF      R1+1
	MOVF       R0+0, 0
L__main140:
	BTFSC      STATUS+0, 2
	GOTO       L__main141
	RRF        R1+1, 1
	RRF        R1+0, 1
	BCF        R1+1, 7
	BTFSC      R1+1, 6
	BSF        R1+1, 7
	ADDLW      255
	GOTO       L__main140
L__main141:
	MOVF       R1+0, 0
	MOVWF      _temp1+0
	MOVF       R1+1, 0
	MOVWF      _temp1+1
;kit1.c,374 :: 		if(temp1==1)
	MOVLW      0
	XORWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main142
	MOVLW      1
	XORWF      R1+0, 0
L__main142:
	BTFSS      STATUS+0, 2
	GOTO       L_main77
;kit1.c,376 :: 		lcd_out(1,1,"data tx   ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_kit1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit1.c,377 :: 		sec=0;
	CLRF       _sec+0
	CLRF       _sec+1
;kit1.c,378 :: 		}
	GOTO       L_main78
L_main77:
;kit1.c,381 :: 		lcd_out(1,1,"no data tx");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_kit1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit1.c,382 :: 		i=1;
	MOVLW      1
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
;kit1.c,383 :: 		reset();
	CALL       _reset+0
;kit1.c,384 :: 		CE=1;
	BSF        RC0_bit+0, 0
;kit1.c,385 :: 		delay_ms(100);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main79:
	DECFSZ     R13+0, 1
	GOTO       L_main79
	DECFSZ     R12+0, 1
	GOTO       L_main79
	NOP
	NOP
;kit1.c,386 :: 		sec=0;
	CLRF       _sec+0
	CLRF       _sec+1
;kit1.c,387 :: 		}
L_main78:
;kit1.c,388 :: 		}
L_main72:
;kit1.c,392 :: 		if(rd2_bit==0)
	BTFSC      RD2_bit+0, 2
	GOTO       L_main80
;kit1.c,394 :: 		fire_f=1;
	MOVLW      1
	MOVWF      _fire_f+0
	MOVLW      0
	MOVWF      _fire_f+1
;kit1.c,395 :: 		f_f=1;
	MOVLW      1
	MOVWF      _f_f+0
	MOVLW      0
	MOVWF      _f_f+1
;kit1.c,396 :: 		lcd_out(4,1,"Fire");
	MOVLW      4
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_kit1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit1.c,397 :: 		rd3_bit=0;
	BCF        RD3_bit+0, 3
;kit1.c,398 :: 		for(j=0;j<30;j++)
	CLRF       _j+0
	CLRF       _j+1
L_main81:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main143
	MOVLW      30
	SUBWF      _j+0, 0
L__main143:
	BTFSC      STATUS+0, 0
	GOTO       L_main82
;kit1.c,400 :: 		rd0_bit=1;
	BSF        RD0_bit+0, 0
;kit1.c,401 :: 		delay_us(1500);
	MOVLW      2
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main84:
	DECFSZ     R13+0, 1
	GOTO       L_main84
	DECFSZ     R12+0, 1
	GOTO       L_main84
	NOP
	NOP
;kit1.c,402 :: 		rd0_bit=0;
	BCF        RD0_bit+0, 0
;kit1.c,403 :: 		delay_us(18500);
	MOVLW      25
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_main85:
	DECFSZ     R13+0, 1
	GOTO       L_main85
	DECFSZ     R12+0, 1
	GOTO       L_main85
;kit1.c,398 :: 		for(j=0;j<30;j++)
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;kit1.c,404 :: 		}
	GOTO       L_main81
L_main82:
;kit1.c,405 :: 		for(j=0;j<30;j++)
	CLRF       _j+0
	CLRF       _j+1
L_main86:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main144
	MOVLW      30
	SUBWF      _j+0, 0
L__main144:
	BTFSC      STATUS+0, 0
	GOTO       L_main87
;kit1.c,407 :: 		rd1_bit=1;
	BSF        RD1_bit+0, 1
;kit1.c,408 :: 		delay_us(1500);
	MOVLW      2
	MOVWF      R12+0
	MOVLW      241
	MOVWF      R13+0
L_main89:
	DECFSZ     R13+0, 1
	GOTO       L_main89
	DECFSZ     R12+0, 1
	GOTO       L_main89
	NOP
	NOP
;kit1.c,409 :: 		rd1_bit=0;
	BCF        RD1_bit+0, 1
;kit1.c,410 :: 		delay_us(18500);
	MOVLW      25
	MOVWF      R12+0
	MOVLW      5
	MOVWF      R13+0
L_main90:
	DECFSZ     R13+0, 1
	GOTO       L_main90
	DECFSZ     R12+0, 1
	GOTO       L_main90
;kit1.c,405 :: 		for(j=0;j<30;j++)
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;kit1.c,411 :: 		}
	GOTO       L_main86
L_main87:
;kit1.c,412 :: 		}
L_main80:
;kit1.c,413 :: 		if(rd2_bit==1&&f_f==1)
	BTFSS      RD2_bit+0, 2
	GOTO       L_main93
	MOVLW      0
	XORWF      _f_f+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main145
	MOVLW      1
	XORWF      _f_f+0, 0
L__main145:
	BTFSS      STATUS+0, 2
	GOTO       L_main93
L__main106:
;kit1.c,415 :: 		fire_f=0;
	CLRF       _fire_f+0
	CLRF       _fire_f+1
;kit1.c,416 :: 		f_f=0;
	CLRF       _f_f+0
	CLRF       _f_f+1
;kit1.c,417 :: 		lcd_out(4,1,"    ");
	MOVLW      4
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_kit1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit1.c,418 :: 		rd3_bit=1;
	BSF        RD3_bit+0, 3
;kit1.c,419 :: 		for(j=0;j<30;j++)
	CLRF       _j+0
	CLRF       _j+1
L_main94:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main146
	MOVLW      30
	SUBWF      _j+0, 0
L__main146:
	BTFSC      STATUS+0, 0
	GOTO       L_main95
;kit1.c,421 :: 		rd0_bit=1;
	BSF        RD0_bit+0, 0
;kit1.c,422 :: 		delay_us(600);
	MOVLW      199
	MOVWF      R13+0
L_main97:
	DECFSZ     R13+0, 1
	GOTO       L_main97
	NOP
	NOP
;kit1.c,423 :: 		rd0_bit=0;
	BCF        RD0_bit+0, 0
;kit1.c,424 :: 		delay_us(19400);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main98:
	DECFSZ     R13+0, 1
	GOTO       L_main98
	DECFSZ     R12+0, 1
	GOTO       L_main98
	NOP
;kit1.c,419 :: 		for(j=0;j<30;j++)
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;kit1.c,425 :: 		}
	GOTO       L_main94
L_main95:
;kit1.c,426 :: 		for(j=0;j<30;j++)
	CLRF       _j+0
	CLRF       _j+1
L_main99:
	MOVLW      128
	XORWF      _j+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main147
	MOVLW      30
	SUBWF      _j+0, 0
L__main147:
	BTFSC      STATUS+0, 0
	GOTO       L_main100
;kit1.c,428 :: 		rd0_bit=1;
	BSF        RD0_bit+0, 0
;kit1.c,429 :: 		delay_us(600);
	MOVLW      199
	MOVWF      R13+0
L_main102:
	DECFSZ     R13+0, 1
	GOTO       L_main102
	NOP
	NOP
;kit1.c,430 :: 		rd0_bit=0;
	BCF        RD0_bit+0, 0
;kit1.c,431 :: 		delay_us(19400);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      48
	MOVWF      R13+0
L_main103:
	DECFSZ     R13+0, 1
	GOTO       L_main103
	DECFSZ     R12+0, 1
	GOTO       L_main103
	NOP
;kit1.c,426 :: 		for(j=0;j<30;j++)
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;kit1.c,432 :: 		}
	GOTO       L_main99
L_main100:
;kit1.c,434 :: 		}
L_main93:
;kit1.c,443 :: 		v=adc_read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _v+0
	MOVF       R0+1, 0
	MOVWF      _v+1
;kit1.c,444 :: 		t=0.4887*v;
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
	MOVWF      _t+0
	MOVF       R0+1, 0
	MOVWF      _t+1
;kit1.c,445 :: 		a  =t/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _a+0
;kit1.c,446 :: 		b =t%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _t+0, 0
	MOVWF      R0+0
	MOVF       _t+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _b+0
;kit1.c,449 :: 		if(t>=35)
	MOVLW      128
	XORWF      _t+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main148
	MOVLW      35
	SUBWF      _t+0, 0
L__main148:
	BTFSS      STATUS+0, 0
	GOTO       L_main104
;kit1.c,450 :: 		{rd4_bit=1;
	BSF        RD4_bit+0, 4
;kit1.c,451 :: 		rd5_bit=0;}
	BCF        RD5_bit+0, 5
	GOTO       L_main105
L_main104:
;kit1.c,454 :: 		rd4_bit=0;
	BCF        RD4_bit+0, 4
;kit1.c,455 :: 		rd5_bit=0;}
	BCF        RD5_bit+0, 5
L_main105:
;kit1.c,457 :: 		a  =t/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _t+0, 0
	MOVWF      R0+0
	MOVF       _t+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _a+0
;kit1.c,458 :: 		b =t%10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _t+0, 0
	MOVWF      R0+0
	MOVF       _t+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _b+0
;kit1.c,459 :: 		lcd_out(3,1,"temp=");
	MOVLW      3
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_kit1+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;kit1.c,460 :: 		lcd_chr(3,7,a+48);
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      7
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _a+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;kit1.c,461 :: 		lcd_chr(3,8,b+48);
	MOVLW      3
	MOVWF      FARG_Lcd_Chr_row+0
	MOVLW      8
	MOVWF      FARG_Lcd_Chr_column+0
	MOVLW      48
	ADDWF      _b+0, 0
	MOVWF      FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;kit1.c,472 :: 		}
	GOTO       L_main42
;kit1.c,474 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
