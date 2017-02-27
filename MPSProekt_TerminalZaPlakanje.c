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
char tempString[8];
char stringRestoran[10];
char stringKelner[10];
int redica[10];
int masaPosledna = 0;  // reden broj na poslednata masa vo redicata
int masaPrva = 0;  // reden broj na prvata masa vo redicata
int masiZafateni = 0; // vkupen broj na zafateni masi

int i = 0;
int j = 0;
int kp = 0;
int k;
int redenBrSmetka = 1;
int cnt = 0;
int cnt1 = 0;
int brInt = 0;
int popust = 0;
int baksis = 0;
int sum = 0;
char sifraKelner;
char tmpSifra;
int masaNum = 0;
char tmp;

void interrupt()
{
     if(INTF_bit == 1)
     {
          masaNum=0;
          while(!masaNum)
          {
                masaNum = ADC_Read(10);
          }

          redica[masaPosledna] = masaNum;
          if(masiZafateni == 0)   //ako doshla prva masa za naplata
          {
              TMR0 = 131;
              cnt = 0;
          }

          // dodadeno 20/02 19:45
          if (masaPosledna == 9)  // ako poslednata pozicija sega e zafatena, pochni od nulta
          {
               masaPosledna = 0;
          }
          else {
               masaPosledna++; // pomesti posledna na sledna pozicija za sledna masa
          }
          // do tuka

          masiZafateni++; // zgolemi go brojot na vkupno zafateni masi

          INTF_bit = 0;
     }

     if (TMR0IF_bit == 1)
     {
        if(masiZafateni >0)
        {
            cnt++;
            if (cnt >= 25)
            {
               cnt1++;
               if(cnt1 == 21)
               {
                  popust += 5;
                  cnt1 = 0;
               }
               TMR0 = 241;
            }
            else
            {
                TMR0 = 131;
            }
        }
        TMR0IF_bit = 0;
     }

}

void main() {
    ANSEL = 0;
    ANSELH = 4;
    TRISB  = 0b00000011; // RB0 e vlezen pin
    INTCON = 0b10110000;
    C1ON_bit = 0;
    C2ON_bit = 0;
    Keypad_Init();
    Lcd_Init();
    UART1_Init(9600);
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
    j += 16;
    for (i=0; i<strlen(kelner2); i++) {
        EEPROM_Write(j + i, kelner2[i]);
    }
    j += 16;
    for (i=0; i<strlen(kelner3); i++) {
        EEPROM_Write(j + i, kelner3[i]);
    }

    // while ciklus za CENA NA PLAKJANJE
    // if(1){
      OPTION_REG = 0b10000101;
      TMR0 = 241;

      while(1)
      {
              sum = 0;
              baksis = 0;
              if (masiZafateni == 0)
              {
                //Lcd_Cmd(_LCD_CURSOR_OFF);
                //Lcd_Cmd(_LCD_CLEAR);
                Lcd_Out(1,1,"Nema za Naplata");
              }
              else
              {
                Lcd_Cmd(_LCD_CURSOR_OFF);
                Lcd_Cmd(_LCD_CLEAR);
                WordToStr(redica[masaPrva], tempString);
                Ltrim(tempString);
                Lcd_Out(1,1,"Masa ");
                Lcd_Out(1,6,tempString);

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

                      if((kp >= 0) && (kp <= 9))
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
                          Lcd_Out(1,10,tempString);
                          Lcd_Out(2,1,"Baksis:");

                          break;
                      }
                } // end while cena

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

                      if((kp >= 0) && (kp <= 9))
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
                        strcpy(tempString, ""); // dodadeno za proverka v2.2
                        break;
                    }

              } // end while baksis

              sum = sum + baksis - popust; // vkupnata cena shto treba da se plati so popust
              Lcd_Cmd(_LCD_CURSOR_OFF);
              Lcd_Cmd(_LCD_CLEAR);

              //memset(tempString, '\0', 8);

              // while ciklus za EUSART  ( ** pak prajt problemi nekoj ciklusov ** Irina)
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
                          case 4: kp = 10; break;  //back
                          case 5: kp = 2; break;
                          case 6: kp = 5; break;
                          case 7: kp = 8; break;
                          case 8: kp = 0; break;
                          case 9: kp = 3; break;
                          case 10: kp = 6; break;
                          case 11: kp = 9; break;
                          case 12: kp = 11; break; // OK
                    }

                    if((kp >= 0) && (kp <= 9))
                    {
                       sifraKelner = kp + '0';

                    }

                    PORTB.B4 = 1;
                    // BOMB

                    if (kp==11)
                    {
                       // se rabotat skoro
                       j = 16;
                       k = 0;
                       for (i=0;i < 3; i++) {

                          tmpSifra = EEPROM_Read(j);

                          // get sifra kelner + ime + vkupnacena
                          if (sifraKelner == tmpSifra) {
                             //UART1_Write_Text("Vo IF");         //test
                            j = j + 2;
                             tmp = EEPROM_Read(j);
                             PORTB = tmp;
                             while(tmp != '*') {
                                stringKelner[k] = tmp;
                                //UART1_Write(tmp);  //test
                                k++;
                                j++;
                                tmp = EEPROM_Read(j);
                             }

                             // get naziv restoran
                             k = 0;
                             tmp = 0;

                             while (1) {
                                tmp = EEPROM_Read(k);
                                if(tmp=='*')
                                {
                                 break;
                                }
                                stringRestoran[k] = tmp;
                                k++;
                             }

                              UART1_Write_Text(stringRestoran);
                              UART1_Write_Text(" NUM:");

                              WordToStr(redenBrSmetka, tempString);
                              Ltrim(tempString);
                              UART1_Write_Text(tempString);
                              memset(tempString, '\0', 8);

                              UART1_Write_Text(" KELNER:");

                              UART1_Write_Text(stringKelner);
                              memset(stringKelner, '\0', 10);

                              UART1_Write_Text(" VKUPNO:");

                              WordToStr(sum, tempString);
                              Ltrim(tempString);
                              UART1_Write_Text(tempString);
                              memset(tempString, '\0', 8);

                              redenBrSmetka++;

                             break;
                          } else {
                             j = j + 16;
                          }

                       } // end for za kelneri

                       break;
                    } // end if kliknato OK

                }// end while UART

            masiZafateni--; // namali go brojot vkupno zafateni masi

            // dodadeno 20/02 19:45
            if (masaPrva == 9) // posledna masa
            {
                masaPrva = 0;
            }
            else {
                 masaPrva++; // odi na sledna masa za sluzhenje (nadesno vo nizata)
            }
            // do tuka

            if(masiZafateni>=0)
            {
                cnt1 = 0;
                cnt = 0;
                popust = 0;
                TMR0 = 131;
            }

          } // end else (ima masi za sluzhenje)

    }// end main while
    //} od regionot e
}