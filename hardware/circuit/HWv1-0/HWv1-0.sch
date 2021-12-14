EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "DMX-Console-ATmega328P"
Date "2021-12-14"
Rev "1.0"
Comp ""
Comment1 "then the crystal and the 22pF capacitor are also not needed"
Comment2 "The ATmega328P can be replaced with an Arduino"
Comment3 ""
Comment4 "A simple circuit based on a ATmega328P to control DMX"
$EndDescr
$Comp
L MCU_Microchip_ATmega:ATmega328P-PU U?
U 1 1 61B96791
P 2150 2600
F 0 "U?" H 1506 2646 50  0000 R CNN
F 1 "ATmega328P-PU" H 1506 2555 50  0000 R CNN
F 2 "Package_DIP:DIP-28_W7.62mm" H 2150 2600 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega328_P%20AVR%20MCU%20with%20picoPower%20Technology%20Data%20Sheet%2040001984A.pdf" H 2150 2600 50  0001 C CNN
	1    2150 2600
	1    0    0    -1  
$EndComp
$Comp
L Device:R_POT RV?
U 1 1 61B97955
P 1400 5950
F 0 "RV?" H 1331 5996 50  0000 R CNN
F 1 "R_POT" H 1331 5905 50  0000 R CNN
F 2 "" H 1400 5950 50  0001 C CNN
F 3 "~" H 1400 5950 50  0001 C CNN
	1    1400 5950
	1    0    0    -1  
$EndComp
$Comp
L Device:R_POT RV?
U 1 1 61B9809F
P 2150 5950
F 0 "RV?" H 2081 5996 50  0000 R CNN
F 1 "R_POT" H 2081 5905 50  0000 R CNN
F 2 "" H 2150 5950 50  0001 C CNN
F 3 "~" H 2150 5950 50  0001 C CNN
	1    2150 5950
	1    0    0    -1  
$EndComp
$Comp
L Device:R_POT RV?
U 1 1 61B98ADD
P 2900 5950
F 0 "RV?" H 2831 5996 50  0000 R CNN
F 1 "R_POT" H 2831 5905 50  0000 R CNN
F 2 "" H 2900 5950 50  0001 C CNN
F 3 "~" H 2900 5950 50  0001 C CNN
	1    2900 5950
	1    0    0    -1  
$EndComp
$Comp
L Device:R_POT RV?
U 1 1 61B98FB3
P 3650 5950
F 0 "RV?" H 3581 5996 50  0000 R CNN
F 1 "R_POT" H 3581 5905 50  0000 R CNN
F 2 "" H 3650 5950 50  0001 C CNN
F 3 "~" H 3650 5950 50  0001 C CNN
	1    3650 5950
	1    0    0    -1  
$EndComp
$Comp
L Display_Character:HY1602E DS?
U 1 1 61B9CEE1
P 9850 5100
F 0 "DS?" H 9850 6081 50  0000 C CNN
F 1 "HY1602E" H 9850 5990 50  0000 C CNN
F 2 "Display:HY1602E" H 9850 4200 50  0001 C CIN
F 3 "http://www.icbank.com/data/ICBShop/board/HY1602E.pdf" H 10050 5200 50  0001 C CNN
	1    9850 5100
	1    0    0    -1  
$EndComp
$Comp
L Interface_Expansion:PCF8574TS U?
U 1 1 61B9DA09
P 8100 5200
F 0 "U?" H 8100 6081 50  0000 C CNN
F 1 "PCF8574TS" H 8100 5990 50  0000 C CNN
F 2 "Package_SO:SSOP-20_4.4x6.5mm_P0.65mm" H 8100 5200 50  0001 C CNN
F 3 "http://www.nxp.com/documents/data_sheet/PCF8574_PCF8574A.pdf" H 8100 5200 50  0001 C CNN
	1    8100 5200
	1    0    0    -1  
$EndComp
$Comp
L Device:Crystal Y?
U 1 1 61B9F14A
P 3650 2000
F 0 "Y?" H 3650 2268 50  0000 C CNN
F 1 "16MHz" H 3650 2177 50  0000 C CNN
F 2 "" H 3650 2000 50  0001 C CNN
F 3 "~" H 3650 2000 50  0001 C CNN
	1    3650 2000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 61BA0481
P 3450 1500
F 0 "C?" H 3565 1546 50  0000 L CNN
F 1 "22pF" H 3565 1455 50  0000 L CNN
F 2 "" H 3488 1350 50  0001 C CNN
F 3 "~" H 3450 1500 50  0001 C CNN
	1    3450 1500
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 61BA0B17
P 3850 1500
F 0 "C?" H 3965 1546 50  0000 L CNN
F 1 "22pF" H 3965 1455 50  0000 L CNN
F 2 "" H 3888 1350 50  0001 C CNN
F 3 "~" H 3850 1500 50  0001 C CNN
	1    3850 1500
	1    0    0    -1  
$EndComp
$Comp
L Device:CP C?
U 1 1 61BA1707
P 3750 3950
F 0 "C?" H 3868 3996 50  0000 L CNN
F 1 "220µF" H 3868 3905 50  0000 L CNN
F 2 "" H 3788 3800 50  0001 C CNN
F 3 "~" H 3750 3950 50  0001 C CNN
	1    3750 3950
	1    0    0    -1  
$EndComp
$Comp
L Connector:XLR3 J?
U 1 1 61BA267E
P 7200 2100
F 0 "J?" H 7200 2465 50  0000 C CNN
F 1 "XLR3" H 7200 2374 50  0000 C CNN
F 2 "" H 7200 2100 50  0001 C CNN
F 3 " ~" H 7200 2100 50  0001 C CNN
	1    7200 2100
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 61BA359B
P 4200 2600
F 0 "R?" H 4270 2646 50  0000 L CNN
F 1 "5k" H 4270 2555 50  0000 L CNN
F 2 "" V 4130 2600 50  0001 C CNN
F 3 "~" H 4200 2600 50  0001 C CNN
	1    4200 2600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 61BA414D
P 4500 2600
F 0 "R?" H 4570 2646 50  0000 L CNN
F 1 "5k" H 4570 2555 50  0000 L CNN
F 2 "" V 4430 2600 50  0001 C CNN
F 3 "~" H 4500 2600 50  0001 C CNN
	1    4500 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 5500 8700 5500
Wire Wire Line
	8700 5500 8700 5700
Wire Wire Line
	8700 5700 9450 5700
Wire Wire Line
	8600 5400 8750 5400
Wire Wire Line
	8750 5400 8750 5600
Wire Wire Line
	8750 5600 9450 5600
Wire Wire Line
	8600 5300 8800 5300
Wire Wire Line
	8800 5300 8800 5500
Wire Wire Line
	8800 5500 9450 5500
Wire Wire Line
	8600 5200 8850 5200
Wire Wire Line
	8850 5200 8850 5400
Wire Wire Line
	8850 5400 9450 5400
Wire Wire Line
	8600 4800 9450 4800
Wire Wire Line
	8600 4900 9400 4900
Wire Wire Line
	9400 4900 9400 4700
Wire Wire Line
	9400 4700 9450 4700
Wire Wire Line
	8600 5000 9350 5000
Wire Wire Line
	9350 5000 9350 4500
Wire Wire Line
	9350 4500 9450 4500
Wire Wire Line
	8100 5900 8100 6000
Wire Wire Line
	8100 6000 9850 6000
Wire Wire Line
	9850 6000 9850 5900
Wire Wire Line
	9850 4300 8400 4300
Wire Wire Line
	8400 4300 8400 4500
Wire Wire Line
	8400 4500 8100 4500
$Comp
L Device:R R?
U 1 1 61BB64F1
P 10350 4900
F 0 "R?" H 10420 4946 50  0000 L CNN
F 1 "330R" H 10420 4855 50  0000 L CNN
F 2 "" V 10280 4900 50  0001 C CNN
F 3 "~" H 10350 4900 50  0001 C CNN
	1    10350 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	10250 5100 10350 5100
Wire Wire Line
	10350 5100 10350 5050
Wire Wire Line
	10350 4750 10350 4300
Wire Wire Line
	10350 4300 9850 4300
Connection ~ 9850 4300
Wire Wire Line
	10250 5200 10250 6000
Wire Wire Line
	10250 6000 9850 6000
Connection ~ 9850 6000
$Comp
L Device:R_POT RV?
U 1 1 61BB831A
P 10600 4500
F 0 "RV?" H 10530 4546 50  0000 R CNN
F 1 "R_POT" H 10530 4455 50  0000 R CNN
F 2 "" H 10600 4500 50  0001 C CNN
F 3 "~" H 10600 4500 50  0001 C CNN
	1    10600 4500
	-1   0    0    -1  
$EndComp
Wire Wire Line
	10250 4500 10450 4500
Wire Wire Line
	10600 4350 10600 4300
Wire Wire Line
	10600 4300 10350 4300
Connection ~ 10350 4300
Wire Wire Line
	10600 4650 10600 6000
Wire Wire Line
	10600 6000 10250 6000
Connection ~ 10250 6000
Wire Notes Line
	10950 4000 7350 4000
Wire Notes Line
	7350 4000 7350 6300
Wire Notes Line
	7350 6300 10950 6300
Wire Notes Line
	10950 6300 10950 4000
Text Notes 9800 6250 0    50   ~ 0
16x2 LCD with I²C converter
Text GLabel 7050 4500 0    50   Input ~ 0
+5V
Text GLabel 7050 6000 0    50   Input ~ 0
GND
Wire Wire Line
	8100 4500 7050 4500
Connection ~ 8100 4500
Wire Wire Line
	8100 6000 7050 6000
Connection ~ 8100 6000
Wire Wire Line
	7050 4900 7600 4900
Wire Wire Line
	7600 4800 7050 4800
$Comp
L Interface_UART:MAX485E U?
U 1 1 61BDB504
P 4700 3500
F 0 "U?" H 4700 4181 50  0000 C CNN
F 1 "MAX485E" H 4700 4090 50  0000 C CNN
F 2 "" H 4700 2800 50  0001 C CNN
F 3 "https://datasheets.maximintegrated.com/en/ds/MAX1487E-MAX491E.pdf" H 4700 3550 50  0001 C CNN
	1    4700 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	1400 6100 1400 6200
Wire Wire Line
	1400 6200 2150 6200
Wire Wire Line
	2150 6200 2150 6100
Wire Wire Line
	2150 6200 2900 6200
Wire Wire Line
	2900 6200 2900 6100
Connection ~ 2150 6200
Wire Wire Line
	2900 6200 3650 6200
Wire Wire Line
	3650 6200 3650 6100
Connection ~ 2900 6200
Wire Wire Line
	1400 5800 1400 5700
Wire Wire Line
	1400 5700 2150 5700
Wire Wire Line
	2150 5700 2150 5800
Wire Wire Line
	2150 5700 2900 5700
Wire Wire Line
	2900 5700 2900 5800
Connection ~ 2150 5700
Wire Wire Line
	2900 5700 3650 5700
Wire Wire Line
	3650 5700 3650 5800
Connection ~ 2900 5700
Wire Notes Line
	950  5300 950  6550
Wire Notes Line
	950  6550 4000 6550
Wire Notes Line
	4000 6550 4000 5300
Wire Notes Line
	4000 5300 950  5300
Text Notes 3650 6500 0    50   ~ 0
Faders
Text GLabel 1650 5200 1    50   UnSpc ~ 0
fader1
Text GLabel 2400 5200 1    50   UnSpc ~ 0
fader2
Text GLabel 3150 5200 1    50   UnSpc ~ 0
fader3
Text GLabel 3900 5200 1    50   UnSpc ~ 0
fader4
Text GLabel 850  6200 0    50   Input ~ 0
+5V
Text GLabel 900  5700 0    50   Input ~ 0
GND
Text GLabel 7050 4800 0    50   BiDi ~ 0
SCL
Text GLabel 7050 4900 0    50   BiDi ~ 0
SDA
Wire Wire Line
	1550 5950 1650 5950
Wire Wire Line
	1650 5950 1650 5200
Wire Wire Line
	2300 5950 2400 5950
Wire Wire Line
	2400 5950 2400 5200
Wire Wire Line
	3050 5950 3150 5950
Wire Wire Line
	3150 5950 3150 5200
Wire Wire Line
	3900 5950 3900 5200
Wire Wire Line
	3800 5950 3900 5950
$Comp
L Switch:SW_MEC_5G SW?
U 1 1 61C77D9F
P 3650 2900
F 0 "SW?" H 3650 3185 50  0000 C CNN
F 1 "SW_MEC_5G" H 3650 3094 50  0000 C CNN
F 2 "" H 3650 3100 50  0001 C CNN
F 3 "http://www.apem.com/int/index.php?controller=attachment&id_attachment=488" H 3650 3100 50  0001 C CNN
	1    3650 2900
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_DPST_x2 SW?
U 1 1 61C78EA5
P 9550 1900
F 0 "SW?" H 9550 2135 50  0000 C CNN
F 1 "SW_DPST_x2" H 9550 2044 50  0000 C CNN
F 2 "" H 9550 1900 50  0001 C CNN
F 3 "~" H 9550 1900 50  0001 C CNN
	1    9550 1900
	1    0    0    -1  
$EndComp
$Comp
L Connector:USB_B_Micro J?
U 1 1 61C799DE
P 8850 2100
F 0 "J?" H 8907 2567 50  0000 C CNN
F 1 "USB_B_Micro" H 8907 2476 50  0000 C CNN
F 2 "" H 9000 2050 50  0001 C CNN
F 3 "~" H 9000 2050 50  0001 C CNN
	1    8850 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	2750 2000 3450 2000
Wire Wire Line
	2750 2100 3450 2100
Wire Wire Line
	3450 2100 3450 2200
Wire Wire Line
	3450 2200 3800 2200
Wire Wire Line
	3800 2200 3800 2000
Wire Wire Line
	3800 2000 3850 2000
Wire Wire Line
	3850 2000 3850 1650
Connection ~ 3800 2000
Wire Wire Line
	3450 2000 3450 1650
Connection ~ 3450 2000
Wire Wire Line
	3450 2000 3500 2000
Wire Wire Line
	3450 1350 3450 1300
Wire Wire Line
	3450 1300 3650 1300
Wire Wire Line
	3850 1300 3850 1350
$Comp
L Device:Rotary_Encoder_Switch SW?
U 1 1 61CA657B
P 5600 6600
F 0 "SW?" H 5600 6967 50  0000 C CNN
F 1 "Rotary_Encoder_Switch" H 5600 6876 50  0000 C CNN
F 2 "" H 5450 6760 50  0001 C CNN
F 3 "~" H 5600 6860 50  0001 C CNN
	1    5600 6600
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 61CB5F94
P 4150 3200
F 0 "R?" H 4220 3246 50  0000 L CNN
F 1 "100R" H 4220 3155 50  0000 L CNN
F 2 "" V 4080 3200 50  0001 C CNN
F 3 "~" H 4150 3200 50  0001 C CNN
	1    4150 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 3400 4150 3400
Wire Wire Line
	4150 3400 4150 3350
Wire Wire Line
	2750 2900 3450 2900
Text GLabel 3000 2300 2    50   UnSpc ~ 0
fader1
Text GLabel 3000 2400 2    50   UnSpc ~ 0
fader2
Text GLabel 3000 2500 2    50   UnSpc ~ 0
fader3
Text GLabel 3000 2600 2    50   UnSpc ~ 0
fader4
Wire Wire Line
	2750 2300 3000 2300
Wire Wire Line
	2750 2400 3000 2400
Wire Wire Line
	2750 2500 3000 2500
Wire Wire Line
	2750 2600 3000 2600
Text GLabel 3000 3800 2    50   UnSpc ~ 0
RE-CLK
Text GLabel 3000 1400 2    50   UnSpc ~ 0
RE-DT
Text GLabel 3000 3700 2    50   UnSpc ~ 0
RE-SW
Wire Wire Line
	2750 3700 3000 3700
Wire Wire Line
	3000 3800 2750 3800
Wire Wire Line
	3000 1400 2750 1400
Text GLabel 3650 1150 1    50   Input ~ 0
GND
Wire Wire Line
	3850 2900 4050 2900
Wire Wire Line
	4150 2900 4150 3050
Wire Wire Line
	3650 1300 3650 1150
Connection ~ 3650 1300
Wire Wire Line
	3650 1300 3850 1300
Wire Wire Line
	4300 3500 4050 3500
Wire Wire Line
	4050 3500 4050 2900
Connection ~ 4050 2900
Wire Wire Line
	4050 2900 4150 2900
Wire Wire Line
	2150 4100 2150 4150
Wire Wire Line
	2150 4150 3750 4150
Wire Wire Line
	4700 4150 4700 4100
Wire Wire Line
	4050 3500 4050 4150
Connection ~ 4050 3500
Connection ~ 4050 4150
Wire Wire Line
	4050 4150 4700 4150
Text GLabel 4050 4200 3    50   Input ~ 0
GND
Wire Wire Line
	4050 4200 4050 4150
Wire Wire Line
	2750 3300 3550 3300
Wire Wire Line
	3550 3300 3550 3700
Wire Wire Line
	3550 3700 4300 3700
Wire Wire Line
	4300 3600 3900 3600
Wire Wire Line
	3900 3600 3900 3000
Wire Wire Line
	3900 3000 4400 3000
Text GLabel 4800 3000 2    50   Input ~ 0
+5V
Wire Wire Line
	4800 3000 4700 3000
Connection ~ 4700 3000
Wire Wire Line
	2150 1100 2150 1050
Wire Wire Line
	2150 1050 2250 1050
Wire Wire Line
	2250 1050 2250 1100
Text GLabel 2050 950  0    50   Input ~ 0
+5V
Wire Wire Line
	2150 1050 2150 950 
Wire Wire Line
	2150 950  2050 950 
Connection ~ 2150 1050
Wire Wire Line
	2750 2800 3500 2800
Wire Wire Line
	3500 2400 4200 2400
Wire Wire Line
	2750 2700 3450 2700
Wire Wire Line
	4200 2400 4200 2450
Wire Wire Line
	3500 2400 3500 2800
Wire Wire Line
	4200 2750 4400 2750
Wire Wire Line
	4400 2750 4400 3000
Connection ~ 4400 2750
Wire Wire Line
	4400 2750 4500 2750
Connection ~ 4400 3000
Wire Wire Line
	4400 3000 4700 3000
Text GLabel 4900 2400 2    50   BiDi ~ 0
SCL
Text GLabel 4900 2300 2    50   BiDi ~ 0
SDA
Wire Wire Line
	4200 2400 4900 2400
Connection ~ 4200 2400
Wire Wire Line
	4900 2300 4500 2300
Wire Wire Line
	3450 2300 3450 2700
Wire Wire Line
	4500 2450 4500 2300
Connection ~ 4500 2300
Wire Wire Line
	4500 2300 3450 2300
Wire Wire Line
	3750 4100 3750 4150
Connection ~ 3750 4150
Wire Wire Line
	3750 4150 4050 4150
Wire Wire Line
	3750 3800 3750 3600
Wire Wire Line
	3750 3600 3900 3600
Connection ~ 3900 3600
Wire Notes Line
	5600 750  650  750 
Wire Notes Line
	650  750  650  4650
Wire Notes Line
	650  4650 5600 4650
Wire Notes Line
	5600 750  5600 4650
Text Notes 5500 4600 2    50   ~ 0
Mainboard
Text GLabel 5300 3700 2    50   Output ~ 0
HOT
Text GLabel 5300 3400 2    50   Output ~ 0
COLD
Wire Wire Line
	5100 3400 5300 3400
Wire Wire Line
	5100 3700 5300 3700
Text GLabel 3000 3100 2    50   BiDi ~ 0
RXD
Text GLabel 3000 3200 2    50   BiDi ~ 0
TXD
Wire Wire Line
	2750 3100 3000 3100
Wire Wire Line
	3000 3200 2750 3200
Text GLabel 6450 6500 2    50   UnSpc ~ 0
RE-SW
Text GLabel 4750 6500 0    50   UnSpc ~ 0
RE-CLK
Text GLabel 4750 6700 0    50   UnSpc ~ 0
RE-DT
Text GLabel 6500 6850 2    50   Input ~ 0
GND
Text GLabel 6500 7000 2    50   Input ~ 0
+5V
$Comp
L Device:R R?
U 1 1 61E3B00D
P 5000 6250
F 0 "R?" H 5070 6296 50  0000 L CNN
F 1 "10k" H 5070 6205 50  0000 L CNN
F 2 "" V 4930 6250 50  0001 C CNN
F 3 "~" H 5000 6250 50  0001 C CNN
	1    5000 6250
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 61E3B91C
P 5000 6950
F 0 "R?" H 5070 6996 50  0000 L CNN
F 1 "10k" H 5070 6905 50  0000 L CNN
F 2 "" V 4930 6950 50  0001 C CNN
F 3 "~" H 5000 6950 50  0001 C CNN
	1    5000 6950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 61E3C309
P 6100 6250
F 0 "R?" H 6170 6296 50  0000 L CNN
F 1 "10k" H 6170 6205 50  0000 L CNN
F 2 "" V 6030 6250 50  0001 C CNN
F 3 "~" H 6100 6250 50  0001 C CNN
	1    6100 6250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 6600 5200 6600
Wire Wire Line
	5200 6600 5200 6850
Wire Wire Line
	5200 6850 5950 6850
Wire Wire Line
	5300 6700 5000 6700
Wire Wire Line
	5300 6500 5000 6500
Wire Wire Line
	5000 6400 5000 6500
Connection ~ 5000 6500
Wire Wire Line
	5000 6700 5000 6800
Connection ~ 5000 6700
Wire Wire Line
	5000 6100 5150 6100
Wire Wire Line
	5150 6100 5150 7000
Wire Wire Line
	5150 7000 6000 7000
Wire Wire Line
	5150 7000 5150 7100
Wire Wire Line
	5150 7100 5000 7100
Connection ~ 5150 7000
Wire Wire Line
	6100 6400 6100 6500
Connection ~ 6100 6500
Wire Wire Line
	6100 6500 5900 6500
Wire Wire Line
	5950 6850 5950 6700
Wire Wire Line
	5950 6700 5900 6700
Connection ~ 5950 6850
Wire Wire Line
	6100 6100 6000 6100
Wire Wire Line
	6000 6100 6000 7000
Connection ~ 6000 7000
Text Notes 6300 7200 2    50   ~ 0
Rotary Encoder Module
Wire Notes Line
	4850 6050 6350 6050
Wire Notes Line
	6350 6050 6350 7250
Wire Notes Line
	6350 7250 4850 7250
Wire Notes Line
	4850 7250 4850 6050
Wire Wire Line
	6100 6500 6450 6500
Wire Wire Line
	5950 6850 6500 6850
Wire Wire Line
	6000 7000 6500 7000
Wire Wire Line
	4750 6500 5000 6500
Wire Wire Line
	4750 6700 5000 6700
Text GLabel 6600 2100 0    50   Input ~ 0
GND
Text GLabel 6600 2250 0    50   Input ~ 0
HOT
Text GLabel 6600 2400 0    50   Input ~ 0
COLD
Wire Wire Line
	6600 2100 6900 2100
Wire Wire Line
	6600 2250 6900 2250
Wire Wire Line
	6900 2250 6900 2400
Wire Wire Line
	6900 2400 7200 2400
Wire Wire Line
	6600 2400 6850 2400
Wire Wire Line
	6850 2400 6850 2500
Wire Wire Line
	6850 2500 7500 2500
Wire Wire Line
	7500 2500 7500 2100
Wire Notes Line
	6750 1650 6750 2700
Wire Notes Line
	6750 2700 7600 2700
Wire Notes Line
	7600 2700 7600 1650
Wire Notes Line
	7600 1650 6750 1650
Text Notes 7100 2650 0    50   ~ 0
DMX Output
Wire Wire Line
	9150 1900 9350 1900
Text GLabel 10150 1900 2    50   Output ~ 0
+5V
Text GLabel 10150 2150 2    50   Output ~ 0
GND
Wire Wire Line
	9750 1900 10150 1900
Wire Wire Line
	8850 2500 8850 2550
Wire Wire Line
	8850 2550 9300 2550
Wire Wire Line
	9300 2550 9300 2150
Wire Wire Line
	9300 2150 10150 2150
Wire Notes Line
	8600 2700 9900 2700
Wire Notes Line
	9900 2700 9900 1600
Wire Notes Line
	9900 1600 8600 1600
Wire Notes Line
	8600 1600 8600 2700
Text Notes 9800 2650 2    50   ~ 0
Power Input
$EndSCHEMATC
