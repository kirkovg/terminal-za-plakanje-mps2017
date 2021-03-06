# Проект по Микропроцесорски системи 2016/17
Изработка на терминал за плаќање во ресторан со помош на mikroC

## Опис
Напишете програма за PIC16F887 кој се користи за контрола на
терминал за плаќање во еден ресторан. Контролерот е поврзан со LCD екран (пинови од
портата А), Keypad тастатура (Порта D), сериска комуникација овозможена преку EUSART
(пинови пд портата C). Покрај овие веќе дефинирани компоненти контролерот е поврзан
со уште еден контролер именуван CALLControl со кој е поврзан со пиновите RBO и RB1.
Преку пинот RB0 се добива сигнал Data Ready кoj генерира прекин тогаш кога ќе има
аналоген сигнал кој ќе треба да се прочита од RB1.

Келнерот кој наплаќа е крајниот корисник на контролерот. Во ресторанот има повеќе
келнери кои можат да го користат терминалот. Програмата на контролерот на терминалот
овозможува:
* Вo EEPROM да се чуваат информации за: Името на ресторанот, Името на секој
келнер и неговата шифра со која се прави автентикација како што е пишано 
подолу. Забелешка: Внесувањето во EEPROM може да се направи во посебна
програма.
* Кога некој клиент повикува за плаќање на сметка (со притискање на некој тастер на
маса) тогаш контролерот CALLControl преку пинот RBO предизвикува прекин на
контролерот на терминалот и преку пинот RB1 се праќа аналогна вредност која
одговара на идентификацискиот број на масата која повикува сметка.
* На LCD екранот се прикажува информација за тоа на која маса следно келнерот
треба да наплати: **Masa XXX**. Се запазува редоследот на плаќање да е FIFO (Прв
пријавен, прв услужен). Aко има масa коja чека на ред на LCD се прикажува
следната маса за наплата, а инаку на LCD се прикажува: **Nema za naplata**.
* Koга келнерот ќе добие приказ на LCD за некоја маса, тој треба да оди да
наплати на масата. Се претпоставува дека келнерот оди до масата која е означена
на LCD и потоа се извршуваат следните активности по дадениот редослед:
  * Келнерот ја внесува сумата под сметката преку Keypad и притиска ОК
  * Сумата која ја внесува се прикажува на LCD. 
  * Kлиентот преку Keypad внесува инфпрмација за тоа колкав бакшиш сака да
    остави и притиска ОК.
  * Кeлнерот ја внесува својата шифра за автентикација и притиска ОК. Со оваа
    акција претпоставуваме дека плаќањето завршило.
  * Преку сериска кпмуникација се праќа текстот кој би се печател на сметката.
    Се претпоставува дека оваа информација стигнува до печатач каде се печати
    сметката.
  * Завршува наплата за дадената маса, па следи наплата за друга маса (ако
    постои)
    
* Клиентот треба да чека за наплата најмногу 100ms. Ова би значело дека од
моментот кога повикал за наплата до моментот кога е послужен треба да поминат
најмногу 100ms. Ако клиентот чека повеќе време за наплата тогаш од вкупната
цена се одзема по 5денари за секои 10ms и ова влегува по попустот

* Текстот кој треба да се печати на печатач и кој се праќа преку сериска комуникација треба
да е во следниот формат:
  * NNN NUM:**XXX** KELNER: **Name** VKUPNO: **VkupnaCena**
    , каде NNN e називот на ресторанот, **XXX** e реден број на сметката (со вклучување
    на програмата одбројувањето на редниот број на сметката почнува од 1), **Name** е
    името на келнерот кој наплаќа, **VkupnаCena** е цената која треба да се наплати 
    (зависи пд основната цена, бакшишот и од попустот)
* Типките на Keypad го имаат следното значење:

1 | 2 | 3 | Нема значење
------------ | ------------- | ------------- | ------------- 
4 | 5 | 6 | Нема значење
7 | 8 | 9 | Нема значење
BACK | 0 | OK | Нема значење

## Пример на извршување 
Во EEPROM има запишано информации за ресторанот TREND и информации за келнерите: Игор со шифра 1
и Ана со шифра 2.

LCD: | N | e | m | a | | z | a | | N | a | p | l | a | t | a | |
------------ | ------------- | ------------- | ------------- | ------------ | ------------- | ------------- | ------------- | ------------ | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | -------------

RB0 - прекин

RB1 - вредност 10

LCD: | М | a | s | a | | 1 | 0 | | | | | | | | | | 
------------ | ------------- | ------------- | ------------- | ------------ | ------------- | ------------- | ------------- | ------------ | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | -------------

RB0-прекин

RB2- вредност 15

Keypad: 1 0 0 OK (*Сметката е 100 денари*)

LCD ред 1: | N | a | p | l | a | t | a | : | 1 | 0 | 0 | | | | | | 
------------ | ------------- | ------------- | ------------- | ------------ | ------------- | ------------- | ------------- | ------------ | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | -------------
LCD ред 2: | B | a | k | s | i | s | : | | | | | | | | | | 

Keypad: 2 0 OK (*Бакшишот е 20 денари*)

LCD ред 1: | N | a | p | l | a | t | a | : | 1 | 0 | 0 | | | | | | 
------------ | ------------- | ------------- | ------------- | ------------ | ------------- | ------------- | ------------- | ------------ | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | -------------
LCD ред 2: | B | a | k | s | i | s | : | 2 | 0 | | | | | | | | 

Keypad: 1 OK (*Шифрата на келнерот е 1*)

EUSART: TREND NUM:**001** KELNER: **Igor** VKUPNO: **120** (*Нема попуст. Клиентот чека помалку од 100ms*)

RB0-прекин

RB2- вреднпсу 8

LCD: | М | a | s | a | | 1 | 5 | | | | | | | | | | 
------------ | ------------- | ------------- | ------------- | ------------ | ------------- | ------------- | ------------- | ------------ | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | -------------

Keypad: 1 5 0 BACK 8 OK (*Сметката е 158 денари*)

LCD ред 1: | N | a | p | l | a | t | a | : | 1 | 5 | 8 | | | | | | 
------------ | ------------- | ------------- | ------------- | ------------ | ------------- | ------------- | ------------- | ------------ | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | -------------
LCD ред 2: | B | a | k | s | i | s | : | | | | | | | | | | 

Keypad: 3 0 OK (*Бакшишот е 30 денари*)

LCD ред 1: | N | a | p | l | a | t | a | : | 1 | 5 | 8 | | | | | | 
------------ | ------------- | ------------- | ------------- | ------------ | ------------- | ------------- | ------------- | ------------ | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | -------------
LCD ред 2: | B | a | k | s | i | s | : | 3 | 0 | | | | | | | | 

Keypad: 1 OK (*Шифрата на келнерот е 1*)
EUSART: TREND NUM:**002** KELNER: **Igor** VKUPNO: **178** (*Попустот е 10 денари ако се претпоставува дека клиентот е послужен со каснење од 20ms*)

LCD: | М | a | s | a | | 8 | | | | | | | | | | | 
------------ | ------------- | ------------- | ------------- | ------------ | ------------- | ------------- | ------------- | ------------ | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | -------------

...

## Автори
* [Ирина Ристевска](https://www.facebook.com/irina.ristevska)
* [Кристијан Ѓорески](https://www.facebook.com/kgjoreski)
* [Ѓорѓи Кирков](https://github.com/kirkovg)
