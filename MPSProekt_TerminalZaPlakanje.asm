
_main:

;MPSProekt_TerminalZaPlakanje.c,40 :: 		void main() {
;MPSProekt_TerminalZaPlakanje.c,41 :: 		ANSEL = 0;
	CLRF       ANSEL+0
;MPSProekt_TerminalZaPlakanje.c,42 :: 		ANSELH.b1 = 1;
	BSF        ANSELH+0, 1
;MPSProekt_TerminalZaPlakanje.c,43 :: 		C1ON_bit = 0;
	BCF        C1ON_bit+0, BitPos(C1ON_bit+0)
;MPSProekt_TerminalZaPlakanje.c,44 :: 		C2ON_bit = 0;
	BCF        C2ON_bit+0, BitPos(C2ON_bit+0)
;MPSProekt_TerminalZaPlakanje.c,45 :: 		Keypad_Init();
	CALL       _Keypad_Init+0
;MPSProekt_TerminalZaPlakanje.c,46 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;MPSProekt_TerminalZaPlakanje.c,48 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MPSProekt_TerminalZaPlakanje.c,49 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MPSProekt_TerminalZaPlakanje.c,50 :: 		Lcd_Out(1,1,"Nema za Naplata");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_MPSProekt_TerminalZaPlakanje+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MPSProekt_TerminalZaPlakanje.c,54 :: 		for (i=0; i<strlen(imeRestoran); i++) {
	CLRF       _i+0
	CLRF       _i+1
L_main0:
	MOVF       _imeRestoran+0, 0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main100
	MOVF       R0+0, 0
	SUBWF      _i+0, 0
L__main100:
	BTFSC      STATUS+0, 0
	GOTO       L_main1
;MPSProekt_TerminalZaPlakanje.c,55 :: 		EEPROM_Write(j + i, imeRestoran[i]);
	MOVF       _i+0, 0
	ADDWF      _j+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _i+0, 0
	ADDWF      _imeRestoran+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;MPSProekt_TerminalZaPlakanje.c,54 :: 		for (i=0; i<strlen(imeRestoran); i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MPSProekt_TerminalZaPlakanje.c,56 :: 		}
	GOTO       L_main0
L_main1:
;MPSProekt_TerminalZaPlakanje.c,57 :: 		j += 16; // za nov red vo EEPROM
	MOVLW      16
	ADDWF      _j+0, 1
	BTFSC      STATUS+0, 0
	INCF       _j+1, 1
;MPSProekt_TerminalZaPlakanje.c,58 :: 		for (i=0; i<strlen(kelner1); i++) {
	CLRF       _i+0
	CLRF       _i+1
L_main3:
	MOVF       _kelner1+0, 0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main101
	MOVF       R0+0, 0
	SUBWF      _i+0, 0
L__main101:
	BTFSC      STATUS+0, 0
	GOTO       L_main4
;MPSProekt_TerminalZaPlakanje.c,59 :: 		EEPROM_Write(j + i, kelner1[i]);
	MOVF       _i+0, 0
	ADDWF      _j+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _i+0, 0
	ADDWF      _kelner1+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;MPSProekt_TerminalZaPlakanje.c,58 :: 		for (i=0; i<strlen(kelner1); i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MPSProekt_TerminalZaPlakanje.c,60 :: 		}
	GOTO       L_main3
L_main4:
;MPSProekt_TerminalZaPlakanje.c,61 :: 		j += 16; // za nov red vo EEPROM
	MOVLW      16
	ADDWF      _j+0, 1
	BTFSC      STATUS+0, 0
	INCF       _j+1, 1
;MPSProekt_TerminalZaPlakanje.c,62 :: 		for (i=0; i<strlen(kelner2); i++) {
	CLRF       _i+0
	CLRF       _i+1
L_main6:
	MOVF       _kelner2+0, 0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main102
	MOVF       R0+0, 0
	SUBWF      _i+0, 0
L__main102:
	BTFSC      STATUS+0, 0
	GOTO       L_main7
;MPSProekt_TerminalZaPlakanje.c,63 :: 		EEPROM_Write(j + i, kelner2[i]);
	MOVF       _i+0, 0
	ADDWF      _j+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _i+0, 0
	ADDWF      _kelner2+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;MPSProekt_TerminalZaPlakanje.c,62 :: 		for (i=0; i<strlen(kelner2); i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MPSProekt_TerminalZaPlakanje.c,64 :: 		}
	GOTO       L_main6
L_main7:
;MPSProekt_TerminalZaPlakanje.c,65 :: 		j += 16; // za nov red vo EEPROM
	MOVLW      16
	ADDWF      _j+0, 1
	BTFSC      STATUS+0, 0
	INCF       _j+1, 1
;MPSProekt_TerminalZaPlakanje.c,66 :: 		for (i=0; i<strlen(kelner3); i++) {
	CLRF       _i+0
	CLRF       _i+1
L_main9:
	MOVF       _kelner3+0, 0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main103
	MOVF       R0+0, 0
	SUBWF      _i+0, 0
L__main103:
	BTFSC      STATUS+0, 0
	GOTO       L_main10
;MPSProekt_TerminalZaPlakanje.c,67 :: 		EEPROM_Write(j + i, kelner3[i]);
	MOVF       _i+0, 0
	ADDWF      _j+0, 0
	MOVWF      FARG_EEPROM_Write_Address+0
	MOVF       _i+0, 0
	ADDWF      _kelner3+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;MPSProekt_TerminalZaPlakanje.c,66 :: 		for (i=0; i<strlen(kelner3); i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MPSProekt_TerminalZaPlakanje.c,68 :: 		}
	GOTO       L_main9
L_main10:
;MPSProekt_TerminalZaPlakanje.c,79 :: 		while(1)
L_main12:
;MPSProekt_TerminalZaPlakanje.c,81 :: 		kp = 0;
	CLRF       _kp+0
	CLRF       _kp+1
;MPSProekt_TerminalZaPlakanje.c,82 :: 		do  {
L_main14:
;MPSProekt_TerminalZaPlakanje.c,83 :: 		kp = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
	CLRF       _kp+1
;MPSProekt_TerminalZaPlakanje.c,85 :: 		while (!kp);
	MOVF       _kp+0, 0
	IORWF      _kp+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main14
;MPSProekt_TerminalZaPlakanje.c,87 :: 		switch (kp)
	GOTO       L_main17
;MPSProekt_TerminalZaPlakanje.c,89 :: 		case 1: kp = 1; break;
L_main19:
	MOVLW      1
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main18
;MPSProekt_TerminalZaPlakanje.c,90 :: 		case 2: kp = 4; break;
L_main20:
	MOVLW      4
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main18
;MPSProekt_TerminalZaPlakanje.c,91 :: 		case 3: kp = 7; break;
L_main21:
	MOVLW      7
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main18
;MPSProekt_TerminalZaPlakanje.c,92 :: 		case 4: kp = 'b'; break;  //back
L_main22:
	MOVLW      98
	MOVWF      _kp+0
	CLRF       _kp+1
	GOTO       L_main18
;MPSProekt_TerminalZaPlakanje.c,93 :: 		case 5: kp = 2; break;
L_main23:
	MOVLW      2
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main18
;MPSProekt_TerminalZaPlakanje.c,94 :: 		case 6: kp = 5; break;
L_main24:
	MOVLW      5
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main18
;MPSProekt_TerminalZaPlakanje.c,95 :: 		case 7: kp = 8; break;
L_main25:
	MOVLW      8
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main18
;MPSProekt_TerminalZaPlakanje.c,96 :: 		case 8: kp = 0; break;
L_main26:
	CLRF       _kp+0
	CLRF       _kp+1
	GOTO       L_main18
;MPSProekt_TerminalZaPlakanje.c,97 :: 		case 9: kp = 3; break;
L_main27:
	MOVLW      3
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main18
;MPSProekt_TerminalZaPlakanje.c,98 :: 		case 10: kp = 6; break;
L_main28:
	MOVLW      6
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main18
;MPSProekt_TerminalZaPlakanje.c,99 :: 		case 11: kp = 9; break;
L_main29:
	MOVLW      9
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main18
;MPSProekt_TerminalZaPlakanje.c,100 :: 		case 12: kp = 'k'; break; // OK
L_main30:
	MOVLW      107
	MOVWF      _kp+0
	CLRF       _kp+1
	GOTO       L_main18
;MPSProekt_TerminalZaPlakanje.c,101 :: 		}
L_main17:
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main104
	MOVLW      1
	XORWF      _kp+0, 0
L__main104:
	BTFSC      STATUS+0, 2
	GOTO       L_main19
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main105
	MOVLW      2
	XORWF      _kp+0, 0
L__main105:
	BTFSC      STATUS+0, 2
	GOTO       L_main20
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main106
	MOVLW      3
	XORWF      _kp+0, 0
L__main106:
	BTFSC      STATUS+0, 2
	GOTO       L_main21
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main107
	MOVLW      4
	XORWF      _kp+0, 0
L__main107:
	BTFSC      STATUS+0, 2
	GOTO       L_main22
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main108
	MOVLW      5
	XORWF      _kp+0, 0
L__main108:
	BTFSC      STATUS+0, 2
	GOTO       L_main23
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main109
	MOVLW      6
	XORWF      _kp+0, 0
L__main109:
	BTFSC      STATUS+0, 2
	GOTO       L_main24
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main110
	MOVLW      7
	XORWF      _kp+0, 0
L__main110:
	BTFSC      STATUS+0, 2
	GOTO       L_main25
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main111
	MOVLW      8
	XORWF      _kp+0, 0
L__main111:
	BTFSC      STATUS+0, 2
	GOTO       L_main26
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main112
	MOVLW      9
	XORWF      _kp+0, 0
L__main112:
	BTFSC      STATUS+0, 2
	GOTO       L_main27
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main113
	MOVLW      10
	XORWF      _kp+0, 0
L__main113:
	BTFSC      STATUS+0, 2
	GOTO       L_main28
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main114
	MOVLW      11
	XORWF      _kp+0, 0
L__main114:
	BTFSC      STATUS+0, 2
	GOTO       L_main29
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main115
	MOVLW      12
	XORWF      _kp+0, 0
L__main115:
	BTFSC      STATUS+0, 2
	GOTO       L_main30
L_main18:
;MPSProekt_TerminalZaPlakanje.c,103 :: 		if((kp!= 'b') && (kp!= 'k'))
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main116
	MOVLW      98
	XORWF      _kp+0, 0
L__main116:
	BTFSC      STATUS+0, 2
	GOTO       L_main33
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main117
	MOVLW      107
	XORWF      _kp+0, 0
L__main117:
	BTFSC      STATUS+0, 2
	GOTO       L_main33
L__main98:
;MPSProekt_TerminalZaPlakanje.c,105 :: 		sum = sum * 10 + kp;
	MOVF       _sum+0, 0
	MOVWF      R0+0
	MOVF       _sum+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       _kp+0, 0
	ADDWF      R0+0, 0
	MOVWF      _sum+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _kp+1, 0
	MOVWF      _sum+1
;MPSProekt_TerminalZaPlakanje.c,106 :: 		}
	GOTO       L_main34
L_main33:
;MPSProekt_TerminalZaPlakanje.c,108 :: 		else if (kp=='b')
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main118
	MOVLW      98
	XORWF      _kp+0, 0
L__main118:
	BTFSS      STATUS+0, 2
	GOTO       L_main35
;MPSProekt_TerminalZaPlakanje.c,110 :: 		sum = sum/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _sum+0, 0
	MOVWF      R0+0
	MOVF       _sum+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _sum+0
	MOVF       R0+1, 0
	MOVWF      _sum+1
;MPSProekt_TerminalZaPlakanje.c,111 :: 		}
	GOTO       L_main36
L_main35:
;MPSProekt_TerminalZaPlakanje.c,112 :: 		else if (kp=='k')
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main119
	MOVLW      107
	XORWF      _kp+0, 0
L__main119:
	BTFSS      STATUS+0, 2
	GOTO       L_main37
;MPSProekt_TerminalZaPlakanje.c,114 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;MPSProekt_TerminalZaPlakanje.c,115 :: 		Lcd_Out(1,1,"Naplata:");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_MPSProekt_TerminalZaPlakanje+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MPSProekt_TerminalZaPlakanje.c,116 :: 		WordToStr(sum, tempString);
	MOVF       _sum+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVF       _sum+1, 0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _tempString+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;MPSProekt_TerminalZaPlakanje.c,117 :: 		Ltrim(tempString);
	MOVLW      _tempString+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;MPSProekt_TerminalZaPlakanje.c,118 :: 		Lcd_Out(1,9,tempString);
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _tempString+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MPSProekt_TerminalZaPlakanje.c,119 :: 		Lcd_Out(2,1,"Baksis:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_MPSProekt_TerminalZaPlakanje+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MPSProekt_TerminalZaPlakanje.c,120 :: 		break;
	GOTO       L_main13
;MPSProekt_TerminalZaPlakanje.c,121 :: 		}
L_main37:
L_main36:
L_main34:
;MPSProekt_TerminalZaPlakanje.c,122 :: 		}
	GOTO       L_main12
L_main13:
;MPSProekt_TerminalZaPlakanje.c,125 :: 		while(1)
L_main38:
;MPSProekt_TerminalZaPlakanje.c,127 :: 		kp = 0;
	CLRF       _kp+0
	CLRF       _kp+1
;MPSProekt_TerminalZaPlakanje.c,128 :: 		do  {
L_main40:
;MPSProekt_TerminalZaPlakanje.c,129 :: 		kp = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
	CLRF       _kp+1
;MPSProekt_TerminalZaPlakanje.c,131 :: 		while (!kp);
	MOVF       _kp+0, 0
	IORWF      _kp+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main40
;MPSProekt_TerminalZaPlakanje.c,133 :: 		switch (kp)
	GOTO       L_main43
;MPSProekt_TerminalZaPlakanje.c,135 :: 		case 1: kp = 1; break;
L_main45:
	MOVLW      1
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main44
;MPSProekt_TerminalZaPlakanje.c,136 :: 		case 2: kp = 4; break;
L_main46:
	MOVLW      4
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main44
;MPSProekt_TerminalZaPlakanje.c,137 :: 		case 3: kp = 7; break;
L_main47:
	MOVLW      7
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main44
;MPSProekt_TerminalZaPlakanje.c,138 :: 		case 4: kp = 'b'; break;  //back
L_main48:
	MOVLW      98
	MOVWF      _kp+0
	CLRF       _kp+1
	GOTO       L_main44
;MPSProekt_TerminalZaPlakanje.c,139 :: 		case 5: kp = 2; break;
L_main49:
	MOVLW      2
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main44
;MPSProekt_TerminalZaPlakanje.c,140 :: 		case 6: kp = 5; break;
L_main50:
	MOVLW      5
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main44
;MPSProekt_TerminalZaPlakanje.c,141 :: 		case 7: kp = 8; break;
L_main51:
	MOVLW      8
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main44
;MPSProekt_TerminalZaPlakanje.c,142 :: 		case 8: kp = 0; break;
L_main52:
	CLRF       _kp+0
	CLRF       _kp+1
	GOTO       L_main44
;MPSProekt_TerminalZaPlakanje.c,143 :: 		case 9: kp = 3; break;
L_main53:
	MOVLW      3
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main44
;MPSProekt_TerminalZaPlakanje.c,144 :: 		case 10: kp = 6; break;
L_main54:
	MOVLW      6
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main44
;MPSProekt_TerminalZaPlakanje.c,145 :: 		case 11: kp = 9; break;
L_main55:
	MOVLW      9
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main44
;MPSProekt_TerminalZaPlakanje.c,146 :: 		case 12: kp = 'k'; break; // OK
L_main56:
	MOVLW      107
	MOVWF      _kp+0
	CLRF       _kp+1
	GOTO       L_main44
;MPSProekt_TerminalZaPlakanje.c,147 :: 		}
L_main43:
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main120
	MOVLW      1
	XORWF      _kp+0, 0
L__main120:
	BTFSC      STATUS+0, 2
	GOTO       L_main45
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main121
	MOVLW      2
	XORWF      _kp+0, 0
L__main121:
	BTFSC      STATUS+0, 2
	GOTO       L_main46
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main122
	MOVLW      3
	XORWF      _kp+0, 0
L__main122:
	BTFSC      STATUS+0, 2
	GOTO       L_main47
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main123
	MOVLW      4
	XORWF      _kp+0, 0
L__main123:
	BTFSC      STATUS+0, 2
	GOTO       L_main48
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main124
	MOVLW      5
	XORWF      _kp+0, 0
L__main124:
	BTFSC      STATUS+0, 2
	GOTO       L_main49
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main125
	MOVLW      6
	XORWF      _kp+0, 0
L__main125:
	BTFSC      STATUS+0, 2
	GOTO       L_main50
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main126
	MOVLW      7
	XORWF      _kp+0, 0
L__main126:
	BTFSC      STATUS+0, 2
	GOTO       L_main51
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main127
	MOVLW      8
	XORWF      _kp+0, 0
L__main127:
	BTFSC      STATUS+0, 2
	GOTO       L_main52
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main128
	MOVLW      9
	XORWF      _kp+0, 0
L__main128:
	BTFSC      STATUS+0, 2
	GOTO       L_main53
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main129
	MOVLW      10
	XORWF      _kp+0, 0
L__main129:
	BTFSC      STATUS+0, 2
	GOTO       L_main54
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main130
	MOVLW      11
	XORWF      _kp+0, 0
L__main130:
	BTFSC      STATUS+0, 2
	GOTO       L_main55
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main131
	MOVLW      12
	XORWF      _kp+0, 0
L__main131:
	BTFSC      STATUS+0, 2
	GOTO       L_main56
L_main44:
;MPSProekt_TerminalZaPlakanje.c,149 :: 		if((kp!= 'b') && (kp!= 'k'))
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main132
	MOVLW      98
	XORWF      _kp+0, 0
L__main132:
	BTFSC      STATUS+0, 2
	GOTO       L_main59
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main133
	MOVLW      107
	XORWF      _kp+0, 0
L__main133:
	BTFSC      STATUS+0, 2
	GOTO       L_main59
L__main97:
;MPSProekt_TerminalZaPlakanje.c,151 :: 		baksis = baksis * 10 + kp;
	MOVF       _baksis+0, 0
	MOVWF      R0+0
	MOVF       _baksis+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Mul_16X16_U+0
	MOVF       _kp+0, 0
	ADDWF      R0+0, 0
	MOVWF      _baksis+0
	MOVF       R0+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _kp+1, 0
	MOVWF      _baksis+1
;MPSProekt_TerminalZaPlakanje.c,152 :: 		}
	GOTO       L_main60
L_main59:
;MPSProekt_TerminalZaPlakanje.c,154 :: 		else if (kp=='b')
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main134
	MOVLW      98
	XORWF      _kp+0, 0
L__main134:
	BTFSS      STATUS+0, 2
	GOTO       L_main61
;MPSProekt_TerminalZaPlakanje.c,156 :: 		baksis = baksis/10;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _baksis+0, 0
	MOVWF      R0+0
	MOVF       _baksis+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      _baksis+0
	MOVF       R0+1, 0
	MOVWF      _baksis+1
;MPSProekt_TerminalZaPlakanje.c,157 :: 		}
	GOTO       L_main62
L_main61:
;MPSProekt_TerminalZaPlakanje.c,158 :: 		else if (kp=='k')
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main135
	MOVLW      107
	XORWF      _kp+0, 0
L__main135:
	BTFSS      STATUS+0, 2
	GOTO       L_main63
;MPSProekt_TerminalZaPlakanje.c,160 :: 		WordToStr(baksis, tempString);
	MOVF       _baksis+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVF       _baksis+1, 0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _tempString+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;MPSProekt_TerminalZaPlakanje.c,161 :: 		Ltrim(tempString);
	MOVLW      _tempString+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;MPSProekt_TerminalZaPlakanje.c,162 :: 		Lcd_Out(2,9,tempString);
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      _tempString+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;MPSProekt_TerminalZaPlakanje.c,163 :: 		break;
	GOTO       L_main39
;MPSProekt_TerminalZaPlakanje.c,164 :: 		}
L_main63:
L_main62:
L_main60:
;MPSProekt_TerminalZaPlakanje.c,166 :: 		}
	GOTO       L_main38
L_main39:
;MPSProekt_TerminalZaPlakanje.c,170 :: 		while(1)
L_main64:
;MPSProekt_TerminalZaPlakanje.c,172 :: 		kp = 0;
	CLRF       _kp+0
	CLRF       _kp+1
;MPSProekt_TerminalZaPlakanje.c,173 :: 		do  {
L_main66:
;MPSProekt_TerminalZaPlakanje.c,174 :: 		kp = Keypad_Key_Click();
	CALL       _Keypad_Key_Click+0
	MOVF       R0+0, 0
	MOVWF      _kp+0
	CLRF       _kp+1
;MPSProekt_TerminalZaPlakanje.c,176 :: 		while (!kp);
	MOVF       _kp+0, 0
	IORWF      _kp+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main66
;MPSProekt_TerminalZaPlakanje.c,178 :: 		switch (kp)
	GOTO       L_main69
;MPSProekt_TerminalZaPlakanje.c,180 :: 		case 1: kp = 1; break;
L_main71:
	MOVLW      1
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main70
;MPSProekt_TerminalZaPlakanje.c,181 :: 		case 2: kp = 4; break;
L_main72:
	MOVLW      4
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main70
;MPSProekt_TerminalZaPlakanje.c,182 :: 		case 3: kp = 7; break;
L_main73:
	MOVLW      7
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main70
;MPSProekt_TerminalZaPlakanje.c,183 :: 		case 4: kp = 'b'; break;  //back
L_main74:
	MOVLW      98
	MOVWF      _kp+0
	CLRF       _kp+1
	GOTO       L_main70
;MPSProekt_TerminalZaPlakanje.c,184 :: 		case 5: kp = 2; break;
L_main75:
	MOVLW      2
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main70
;MPSProekt_TerminalZaPlakanje.c,185 :: 		case 6: kp = 5; break;
L_main76:
	MOVLW      5
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main70
;MPSProekt_TerminalZaPlakanje.c,186 :: 		case 7: kp = 8; break;
L_main77:
	MOVLW      8
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main70
;MPSProekt_TerminalZaPlakanje.c,187 :: 		case 8: kp = 0; break;
L_main78:
	CLRF       _kp+0
	CLRF       _kp+1
	GOTO       L_main70
;MPSProekt_TerminalZaPlakanje.c,188 :: 		case 9: kp = 3; break;
L_main79:
	MOVLW      3
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main70
;MPSProekt_TerminalZaPlakanje.c,189 :: 		case 10: kp = 6; break;
L_main80:
	MOVLW      6
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main70
;MPSProekt_TerminalZaPlakanje.c,190 :: 		case 11: kp = 9; break;
L_main81:
	MOVLW      9
	MOVWF      _kp+0
	MOVLW      0
	MOVWF      _kp+1
	GOTO       L_main70
;MPSProekt_TerminalZaPlakanje.c,191 :: 		case 12: kp = 'k'; break; // OK
L_main82:
	MOVLW      107
	MOVWF      _kp+0
	CLRF       _kp+1
	GOTO       L_main70
;MPSProekt_TerminalZaPlakanje.c,192 :: 		}
L_main69:
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main136
	MOVLW      1
	XORWF      _kp+0, 0
L__main136:
	BTFSC      STATUS+0, 2
	GOTO       L_main71
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main137
	MOVLW      2
	XORWF      _kp+0, 0
L__main137:
	BTFSC      STATUS+0, 2
	GOTO       L_main72
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main138
	MOVLW      3
	XORWF      _kp+0, 0
L__main138:
	BTFSC      STATUS+0, 2
	GOTO       L_main73
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main139
	MOVLW      4
	XORWF      _kp+0, 0
L__main139:
	BTFSC      STATUS+0, 2
	GOTO       L_main74
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main140
	MOVLW      5
	XORWF      _kp+0, 0
L__main140:
	BTFSC      STATUS+0, 2
	GOTO       L_main75
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main141
	MOVLW      6
	XORWF      _kp+0, 0
L__main141:
	BTFSC      STATUS+0, 2
	GOTO       L_main76
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main142
	MOVLW      7
	XORWF      _kp+0, 0
L__main142:
	BTFSC      STATUS+0, 2
	GOTO       L_main77
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main143
	MOVLW      8
	XORWF      _kp+0, 0
L__main143:
	BTFSC      STATUS+0, 2
	GOTO       L_main78
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main144
	MOVLW      9
	XORWF      _kp+0, 0
L__main144:
	BTFSC      STATUS+0, 2
	GOTO       L_main79
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main145
	MOVLW      10
	XORWF      _kp+0, 0
L__main145:
	BTFSC      STATUS+0, 2
	GOTO       L_main80
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main146
	MOVLW      11
	XORWF      _kp+0, 0
L__main146:
	BTFSC      STATUS+0, 2
	GOTO       L_main81
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main147
	MOVLW      12
	XORWF      _kp+0, 0
L__main147:
	BTFSC      STATUS+0, 2
	GOTO       L_main82
L_main70:
;MPSProekt_TerminalZaPlakanje.c,194 :: 		if (kp != 'k' && kp != 'b')
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main148
	MOVLW      107
	XORWF      _kp+0, 0
L__main148:
	BTFSC      STATUS+0, 2
	GOTO       L_main85
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main149
	MOVLW      98
	XORWF      _kp+0, 0
L__main149:
	BTFSC      STATUS+0, 2
	GOTO       L_main85
L__main96:
;MPSProekt_TerminalZaPlakanje.c,196 :: 		sifraKelner = kp;
	MOVF       _kp+0, 0
	MOVWF      _sifraKelner+0
;MPSProekt_TerminalZaPlakanje.c,198 :: 		}
L_main85:
;MPSProekt_TerminalZaPlakanje.c,201 :: 		if (kp=='k')
	MOVLW      0
	XORWF      _kp+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main150
	MOVLW      107
	XORWF      _kp+0, 0
L__main150:
	BTFSS      STATUS+0, 2
	GOTO       L_main86
;MPSProekt_TerminalZaPlakanje.c,203 :: 		j = 16;
	MOVLW      16
	MOVWF      _j+0
	MOVLW      0
	MOVWF      _j+1
;MPSProekt_TerminalZaPlakanje.c,204 :: 		k = 0;
	CLRF       _k+0
	CLRF       _k+1
;MPSProekt_TerminalZaPlakanje.c,205 :: 		for (i=0;i < 3; i++) {
	CLRF       _i+0
	CLRF       _i+1
L_main87:
	MOVLW      128
	XORWF      _i+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main151
	MOVLW      3
	SUBWF      _i+0, 0
L__main151:
	BTFSC      STATUS+0, 0
	GOTO       L_main88
;MPSProekt_TerminalZaPlakanje.c,206 :: 		tmpSifra = EEPROM_Read(j);
	MOVF       _j+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _tmpSifra+0
;MPSProekt_TerminalZaPlakanje.c,209 :: 		if (sifraKelner == tmpSifra) {
	MOVF       _sifraKelner+0, 0
	XORWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main90
;MPSProekt_TerminalZaPlakanje.c,210 :: 		j = j + 2;
	MOVLW      2
	ADDWF      _j+0, 0
	MOVWF      R0+0
	MOVF       _j+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _j+0
	MOVF       R0+1, 0
	MOVWF      _j+1
;MPSProekt_TerminalZaPlakanje.c,211 :: 		tmp = EEPROM_Read(j);
	MOVF       R0+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _tmp+0
;MPSProekt_TerminalZaPlakanje.c,212 :: 		while(tmp != '*') {
L_main91:
	MOVF       _tmp+0, 0
	XORLW      42
	BTFSC      STATUS+0, 2
	GOTO       L_main92
;MPSProekt_TerminalZaPlakanje.c,213 :: 		stringKelner[k] = tmp;
	MOVF       _k+0, 0
	ADDLW      _stringKelner+0
	MOVWF      FSR
	MOVF       _tmp+0, 0
	MOVWF      INDF+0
;MPSProekt_TerminalZaPlakanje.c,214 :: 		k++;
	INCF       _k+0, 1
	BTFSC      STATUS+0, 2
	INCF       _k+1, 1
;MPSProekt_TerminalZaPlakanje.c,215 :: 		j++;
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;MPSProekt_TerminalZaPlakanje.c,216 :: 		tmp = EEPROM_Read(j);
	MOVF       _j+0, 0
	MOVWF      FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _tmp+0
;MPSProekt_TerminalZaPlakanje.c,217 :: 		}
	GOTO       L_main91
L_main92:
;MPSProekt_TerminalZaPlakanje.c,220 :: 		k = 0;
	CLRF       _k+0
	CLRF       _k+1
;MPSProekt_TerminalZaPlakanje.c,221 :: 		tmp = EEPROM_Read(k);
	CLRF       FARG_EEPROM_Read_Address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _tmp+0
;MPSProekt_TerminalZaPlakanje.c,222 :: 		while (tmp != '*') {
L_main93:
	MOVF       _tmp+0, 0
	XORLW      42
	BTFSC      STATUS+0, 2
	GOTO       L_main94
;MPSProekt_TerminalZaPlakanje.c,223 :: 		stringRestoran[k] = tmp;
	MOVF       _k+0, 0
	ADDLW      _stringRestoran+0
	MOVWF      FSR
	MOVF       _tmp+0, 0
	MOVWF      INDF+0
;MPSProekt_TerminalZaPlakanje.c,224 :: 		k++;
	INCF       _k+0, 1
	BTFSC      STATUS+0, 2
	INCF       _k+1, 1
;MPSProekt_TerminalZaPlakanje.c,225 :: 		}
	GOTO       L_main93
L_main94:
;MPSProekt_TerminalZaPlakanje.c,228 :: 		UART1_Write_Text(stringRestoran);
	MOVLW      _stringRestoran+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MPSProekt_TerminalZaPlakanje.c,229 :: 		UART1_Write_Text(" NUM:");
	MOVLW      ?lstr8_MPSProekt_TerminalZaPlakanje+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MPSProekt_TerminalZaPlakanje.c,230 :: 		UART1_Write_Text(redenBrSmetka);
	MOVF       _redenBrSmetka+0, 0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MPSProekt_TerminalZaPlakanje.c,231 :: 		UART1_Write_Text(" KELNER:");
	MOVLW      ?lstr9_MPSProekt_TerminalZaPlakanje+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MPSProekt_TerminalZaPlakanje.c,232 :: 		UART1_Write_Text(stringKelner);
	MOVLW      _stringKelner+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MPSProekt_TerminalZaPlakanje.c,233 :: 		UART1_Write_Text(" VKUPNO:");
	MOVLW      ?lstr10_MPSProekt_TerminalZaPlakanje+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MPSProekt_TerminalZaPlakanje.c,234 :: 		WordToStr(sum, tempString);
	MOVF       _sum+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVF       _sum+1, 0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      _tempString+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;MPSProekt_TerminalZaPlakanje.c,235 :: 		UART1_Write_Text(tempString);
	MOVLW      _tempString+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MPSProekt_TerminalZaPlakanje.c,237 :: 		redenBrSmetka++;
	INCF       _redenBrSmetka+0, 1
	BTFSC      STATUS+0, 2
	INCF       _redenBrSmetka+1, 1
;MPSProekt_TerminalZaPlakanje.c,239 :: 		} else {
	GOTO       L_main95
L_main90:
;MPSProekt_TerminalZaPlakanje.c,240 :: 		j = j + 16;
	MOVLW      16
	ADDWF      _j+0, 1
	BTFSC      STATUS+0, 0
	INCF       _j+1, 1
;MPSProekt_TerminalZaPlakanje.c,241 :: 		}
L_main95:
;MPSProekt_TerminalZaPlakanje.c,205 :: 		for (i=0;i < 3; i++) {
	INCF       _i+0, 1
	BTFSC      STATUS+0, 2
	INCF       _i+1, 1
;MPSProekt_TerminalZaPlakanje.c,243 :: 		}
	GOTO       L_main87
L_main88:
;MPSProekt_TerminalZaPlakanje.c,244 :: 		}
L_main86:
;MPSProekt_TerminalZaPlakanje.c,246 :: 		}
	GOTO       L_main64
;MPSProekt_TerminalZaPlakanje.c,248 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
