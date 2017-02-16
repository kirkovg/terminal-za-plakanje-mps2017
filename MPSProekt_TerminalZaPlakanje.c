#include <built_in.h>
#include <stdlib.h>

char keypadPort at PORTD;

sbit LCD_RS at RA4_bit;
sbit LCD_EN at RA5_bit;
sbit LCD_D4 at RA0_bit;
sbit LCD_D5 at RA1_bit;
sbit LCD_D6 at RA2_bit;
sbit LCD_D7 at RA3_bit;
sbit LCD_RS_Direction at TRISA4_bit;
sbit LCD_EN_Direction at TRISA5_bit;
sbit LCD_D4_Direction at TRISA0_bit;
sbit LCD_D5_Direction at TRISA1_bit;
sbit LCD_D6_Direction at TRISA2_bit;
sbit LCD_D7_Direction at TRISA3_bit;

char* imeRestoran = "Panorama*";
char* kelner1 = "1 Horhe*";
char* kelner2 = "2 Lenche*";
char* kelner3 = "3 Kire*";
char tempString[10];
char stringRestoran[15];

int i = 0;
int j = 0;
int kp = 0;
int k;
int redenBrSmetka = 1;

int baksis = 0;
int sum = 0;
char sifraKelner;
char tmpSifra;

char stringKelner[20];
char tmp;

void main() {
    ANSEL = 0;
    ANSELH.b1 = 1;
    C1ON_bit = 0;
    C2ON_bit = 0;
    Keypad_Init();
    Lcd_Init();
    //UART1_Init(9600);
    Lcd_Cmd(_LCD_CURSOR_OFF);
    Lcd_Cmd(_LCD_CLEAR);
    Lcd_Out(1,1,"Nema za Naplata");


    /* Vnesuvanje vo EEPROM */
    for (i=0; i<strlen(imeRestoran); i++) {
        EEPROM_Write(j + i, imeRestoran[i]);
    }
    j += 16; // za nov red vo EEPROM
    for (i=0; i<strlen(kelner1); i++) {
        EEPROM_Write(j + i, kelner1[i]);
    }
    j += 16; // za nov red vo EEPROM
    for (i=0; i<strlen(kelner2); i++) {
        EEPROM_Write(j + i, kelner2[i]);
    }
    j += 16; // za nov red vo EEPROM
    for (i=0; i<strlen(kelner3); i++) {
        EEPROM_Write(j + i, kelner3[i]);
    }


    // NOTES
    // dali ko ke citas od eeprom trebit da convertiras od hex?
    // trebit while za celata aplikacija -> rb0 i rb1 pinoj

    // TODO: to implement
    // Dodaj baksis na suma, plus dodaj popust od tajmer

    // while ciklus za CENA NA PLAKJANJE
    while(1)
    {
          kp = 0;
          do  {
              kp = Keypad_Key_Click();
          }
          while (!kp);

          switch (kp)
          {
                case 1: kp = 1; break;
                case 2: kp = 4; break;
                case 3: kp = 7; break;
                case 4: kp = 'b'; break;  //back
                case 5: kp = 2; break;
                case 6: kp = 5; break;
                case 7: kp = 8; break;
                case 8: kp = 0; break;
                case 9: kp = 3; break;
                case 10: kp = 6; break;
                case 11: kp = 9; break;
                case 12: kp = 'k'; break; // OK
          }

          if((kp!= 'b') && (kp!= 'k'))
          {
              sum = sum * 10 + kp;
          }

          else if (kp=='b')
          {
               sum = sum/10;
          }
          else if (kp=='k')
          {
              Lcd_Cmd(_LCD_CLEAR);
              Lcd_Out(1,1,"Naplata:");
              WordToStr(sum, tempString);
              Ltrim(tempString);
              Lcd_Out(1,9,tempString);
              Lcd_Out(2,1,"Baksis:");
              break;
          }
    }

    // while ciklus za BAKSIS
    while(1)
    {
          kp = 0;
          do  {
              kp = Keypad_Key_Click();
          }
          while (!kp);

          switch (kp)
          {
                case 1: kp = 1; break;
                case 2: kp = 4; break;
                case 3: kp = 7; break;
                case 4: kp = 'b'; break;  //back
                case 5: kp = 2; break;
                case 6: kp = 5; break;
                case 7: kp = 8; break;
                case 8: kp = 0; break;
                case 9: kp = 3; break;
                case 10: kp = 6; break;
                case 11: kp = 9; break;
                case 12: kp = 'k'; break; // OK
          }

          if((kp!= 'b') && (kp!= 'k'))
          {
              baksis = baksis * 10 + kp;
          }

          else if (kp=='b')
          {
               baksis = baksis/10;
          }
          else if (kp=='k')
          {
              WordToStr(baksis, tempString);
              Ltrim(tempString);
              Lcd_Out(2,9,tempString);
              break;
          }

    }


    // while ciklus za EUSART
    while(1)
    {
          kp = 0;
          do  {
              kp = Keypad_Key_Click();
          }
          while (!kp);

          switch (kp)
          {
                case 1: kp = 1; break;
                case 2: kp = 4; break;
                case 3: kp = 7; break;
                case 4: kp = 'b'; break;  //back
                case 5: kp = 2; break;
                case 6: kp = 5; break;
                case 7: kp = 8; break;
                case 8: kp = 0; break;
                case 9: kp = 3; break;
                case 10: kp = 6; break;
                case 11: kp = 9; break;
                case 12: kp = 'k'; break; // OK
          }

          if (kp != 'k' && kp != 'b')
          {
             sifraKelner = kp;

          }


          if (kp=='k')
          {
             j = 16;
             k = 0;
             for (i=0;i < 3; i++) {
                tmpSifra = EEPROM_Read(j);

                // get sifra kelner + ime + vkupnacena
                if (sifraKelner == tmpSifra) {
                   j = j + 2;
                   tmp = EEPROM_Read(j);
                   while(tmp != '*') {
                      stringKelner[k] = tmp;
                      k++;
                      j++;
                      tmp = EEPROM_Read(j);
                   }

                   // get naziv restoran
                   k = 0;
                   tmp = EEPROM_Read(k);
                   while (tmp != '*') {
                      stringRestoran[k] = tmp;
                      k++;
                   }

                   // prati sve na eusart
                   UART1_Write_Text(stringRestoran);
                   UART1_Write_Text(" NUM:");
                   UART1_Write_Text(redenBrSmetka);
                   UART1_Write_Text(" KELNER:");
                   UART1_Write_Text(stringKelner);
                   UART1_Write_Text(" VKUPNO:");
                   WordToStr(sum, tempString);
                   UART1_Write_Text(tempString);

                   redenBrSmetka++;

                } else {
                   j = j + 16;
                }

             }
          }

    }

}