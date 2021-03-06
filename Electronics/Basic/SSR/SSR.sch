EESchema Schematic File Version 4
LIBS:SSR-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Triac_Thyristor:BT136-500 Q1
U 1 1 5DEC301E
P 6450 2750
F 0 "Q1" H 6578 2796 50  0001 L CNN
F 1 "BT137" H 6578 2750 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Vertical" H 6650 2675 50  0001 L CIN
F 3 "http://www.micropik.com/PDF/BT136-600.pdf" H 6450 2750 50  0001 L CNN
	1    6450 2750
	1    0    0    -1  
$EndComp
$Comp
L Relay_SolidState:MOC3041M U1
U 1 1 5DEC3C9B
P 5500 2750
F 0 "U1" H 5500 3075 50  0001 C CNN
F 1 "MOC3041" H 5500 2983 50  0000 C CNN
F 2 "" H 5300 2550 50  0001 L CIN
F 3 "http://www.fairchildsemi.com/ds/MO/MOC3031M.pdf" H 5465 2750 50  0001 L CNN
	1    5500 2750
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5DEC4527
P 6000 2400
F 0 "R1" H 6070 2446 50  0000 L CNN
F 1 "360" H 6070 2355 50  0000 L CNN
F 2 "" V 5930 2400 50  0001 C CNN
F 3 "~" H 6000 2400 50  0001 C CNN
	1    6000 2400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5DEC5091
P 5050 3000
F 0 "#PWR?" H 5050 2750 50  0001 C CNN
F 1 "GND" H 5055 2827 50  0000 C CNN
F 2 "" H 5050 3000 50  0001 C CNN
F 3 "" H 5050 3000 50  0001 C CNN
	1    5050 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6300 2850 6050 2850
Wire Wire Line
	5800 2650 6000 2650
Wire Wire Line
	6000 2650 6000 2550
Wire Wire Line
	6000 2250 6000 2200
Wire Wire Line
	6000 2200 6450 2200
Wire Wire Line
	6450 2200 6450 2600
Text GLabel 4950 2200 0    50   Input ~ 0
D13
Wire Wire Line
	5050 3000 5050 2850
Wire Wire Line
	5050 2850 5200 2850
$Comp
L Device:R Rin
U 1 1 5DEC4B9A
P 5050 2450
F 0 "Rin" H 5120 2496 50  0000 L CNN
F 1 "R" H 5120 2405 50  0000 L CNN
F 2 "" V 4980 2450 50  0001 C CNN
F 3 "~" H 5050 2450 50  0001 C CNN
	1    5050 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 5DF07B72
P 6050 3100
F 0 "R2" H 6120 3146 50  0000 L CNN
F 1 "330" H 6120 3055 50  0000 L CNN
F 2 "" V 5980 3100 50  0001 C CNN
F 3 "~" H 6050 3100 50  0001 C CNN
	1    6050 3100
	1    0    0    -1  
$EndComp
$Comp
L power:LINE #PWR?
U 1 1 5DF07F56
P 8100 2050
F 0 "#PWR?" H 8100 1900 50  0001 C CNN
F 1 "LINE" H 8117 2223 50  0000 C CNN
F 2 "" H 8100 2050 50  0001 C CNN
F 3 "" H 8100 2050 50  0001 C CNN
	1    8100 2050
	1    0    0    -1  
$EndComp
$Comp
L power:NEUT #PWR?
U 1 1 5DF0844E
P 8350 2050
F 0 "#PWR?" H 8350 1900 50  0001 C CNN
F 1 "NEUT" H 8367 2223 50  0000 C CNN
F 2 "" H 8350 2050 50  0001 C CNN
F 3 "" H 8350 2050 50  0001 C CNN
	1    8350 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 2300 5050 2200
Wire Wire Line
	5050 2200 4950 2200
Wire Wire Line
	5050 2600 5050 2650
Wire Wire Line
	5050 2650 5200 2650
Wire Wire Line
	6050 2950 6050 2850
Connection ~ 6050 2850
Wire Wire Line
	6050 2850 5800 2850
$Comp
L Device:R R3
U 1 1 5DF0CA74
P 7300 2500
F 0 "R3" H 7370 2546 50  0000 L CNN
F 1 "39*" H 7370 2455 50  0000 L CNN
F 2 "" V 7230 2500 50  0001 C CNN
F 3 "~" H 7300 2500 50  0001 C CNN
	1    7300 2500
	1    0    0    -1  
$EndComp
$Comp
L Device:R Rload
U 1 1 5DF0E684
P 8350 2550
F 0 "Rload" H 8420 2550 50  0000 L CNN
F 1 "R" H 8420 2505 50  0001 L CNN
F 2 "" V 8280 2550 50  0001 C CNN
F 3 "~" H 8350 2550 50  0001 C CNN
	1    8350 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	8100 2050 8100 2200
Wire Wire Line
	8100 2200 7300 2200
Connection ~ 6450 2200
Wire Wire Line
	7300 2350 7300 2200
Connection ~ 7300 2200
Wire Wire Line
	7300 2200 6450 2200
Wire Wire Line
	6050 3250 6050 3350
Wire Wire Line
	6050 3350 6450 3350
Wire Wire Line
	8350 3350 8350 2700
Wire Wire Line
	8350 2400 8350 2050
Wire Wire Line
	6450 2900 6450 3350
Connection ~ 6450 3350
Text Notes 8100 1750 0    50   ~ 0
220 VAC\n
Text Notes 5150 3700 0    50   ~ 0
* [EN] For highly inductive loads (power factor < 0.5), change this value to 360 ohms\n* [ES] Para cargas altamente inductivas (factor de potencia < 0.5), cambiar este valor a 360 ohms
$Comp
L Device:C C1
U 1 1 5DF088C8
P 7300 2950
F 0 "C1" H 7415 2996 50  0000 L CNN
F 1 "10nF x 500V" H 7415 2905 50  0000 L CNN
F 2 "" H 7338 2800 50  0001 C CNN
F 3 "~" H 7300 2950 50  0001 C CNN
	1    7300 2950
	1    0    0    -1  
$EndComp
Wire Wire Line
	6450 3350 7300 3350
Wire Wire Line
	7300 2800 7300 2650
Wire Wire Line
	7300 3100 7300 3350
Connection ~ 7300 3350
Wire Wire Line
	7300 3350 8350 3350
$EndSCHEMATC
