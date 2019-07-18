EESchema Schematic File Version 4
LIBS:AstroCameraAimer-cache
EELAYER 29 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Astrophotography Camera Controller"
Date "2019-05-10"
Rev "3"
Comp "csammis"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L LocalICs:A3967 U3
U 1 1 5B679A45
P 9600 2200
F 0 "U3" H 8550 3465 50  0000 C CNN
F 1 "A3967" H 8550 3374 50  0000 C CNN
F 2 "Package_SO:SOIC-24W_7.5x15.4mm_P1.27mm" H 9050 3350 50  0001 C CNN
F 3 "" H 9600 2200 50  0001 C CNN
	1    9600 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	8500 2800 8600 2800
Wire Wire Line
	8700 2800 8600 2800
Connection ~ 8600 2800
Wire Wire Line
	8700 2800 8800 2800
Connection ~ 8700 2800
$Comp
L power:GND #PWR021
U 1 1 5B679FBE
P 8900 2800
F 0 "#PWR021" H 8900 2550 50  0001 C CNN
F 1 "GND" H 8905 2627 50  0001 C CNN
F 2 "" H 8900 2800 50  0001 C CNN
F 3 "" H 8900 2800 50  0001 C CNN
	1    8900 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8800 2800 8900 2800
Connection ~ 8800 2800
$Comp
L Connector_Generic:Conn_01x08 J3
U 1 1 5B67FAD6
P 5250 6075
F 0 "J3" H 5200 6475 50  0000 L CNN
F 1 "LCD" H 5200 5575 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B08B-XH-A_1x08_P2.50mm_Vertical" H 5250 6075 50  0001 C CNN
F 3 "" H 5250 6075 50  0001 C CNN
	1    5250 6075
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR011
U 1 1 5B68A78E
P 5000 6575
F 0 "#PWR011" H 5000 6325 50  0001 C CNN
F 1 "GND" H 5005 6402 50  0001 C CNN
F 2 "" H 5000 6575 50  0001 C CNN
F 3 "" H 5000 6575 50  0001 C CNN
	1    5000 6575
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 3100 2900 3100
$Comp
L power:GND #PWR07
U 1 1 5B68B7B8
P 2800 3800
F 0 "#PWR07" H 2800 3550 50  0001 C CNN
F 1 "GND" H 2805 3627 50  0001 C CNN
F 2 "" H 2800 3800 50  0001 C CNN
F 3 "" H 2800 3800 50  0001 C CNN
	1    2800 3800
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR06
U 1 1 5B68CE17
P 2200 3750
F 0 "#PWR06" H 2200 3600 50  0001 C CNN
F 1 "+3.3V" H 2215 3923 50  0000 C CNN
F 2 "" H 2200 3750 50  0001 C CNN
F 3 "" H 2200 3750 50  0001 C CNN
	1    2200 3750
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 2300 7750 2300
Wire Wire Line
	7850 2200 7750 2200
Wire Wire Line
	7750 2200 7750 2300
$Comp
L power:+3.3V #PWR08
U 1 1 5B691534
P 4950 5775
F 0 "#PWR08" H 4950 5625 50  0001 C CNN
F 1 "+3.3V" H 4850 5925 50  0000 L CNN
F 2 "" H 4950 5775 50  0001 C CNN
F 3 "" H 4950 5775 50  0001 C CNN
	1    4950 5775
	1    0    0    -1  
$EndComp
$Comp
L power:+9V #PWR013
U 1 1 5B694020
P 6950 1550
F 0 "#PWR013" H 6950 1400 50  0001 C CNN
F 1 "+9V" H 6850 1700 50  0000 L CNN
F 2 "" H 6950 1550 50  0001 C CNN
F 3 "" H 6950 1550 50  0001 C CNN
	1    6950 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 1550 7650 1550
Wire Wire Line
	7850 1650 7650 1650
Wire Wire Line
	7650 1650 7650 1550
$Comp
L Device:R_Small_US R20
U 1 1 5B6A540B
P 9950 2200
F 0 "R20" H 9775 2200 39  0000 L CNN
F 1 "20K" H 9775 2125 39  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 9990 2190 50  0001 C CNN
F 3 "" H 9950 2200 50  0001 C CNN
	1    9950 2200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR023
U 1 1 5B6AB3DB
P 9375 2400
F 0 "#PWR023" H 9375 2150 50  0001 C CNN
F 1 "GND" H 9380 2227 50  0001 C CNN
F 2 "" H 9375 2400 50  0001 C CNN
F 3 "" H 9375 2400 50  0001 C CNN
	1    9375 2400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR026
U 1 1 5B6AE017
P 9950 2300
F 0 "#PWR026" H 9950 2050 50  0001 C CNN
F 1 "GND" H 9955 2127 50  0001 C CNN
F 2 "" H 9950 2300 50  0001 C CNN
F 3 "" H 9950 2300 50  0001 C CNN
	1    9950 2300
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R16
U 1 1 5B6B0F6A
P 9475 1650
F 0 "R16" V 9425 1525 39  0000 C CNN
F 1 "0.75Ω" V 9425 1800 39  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 9515 1640 50  0001 C CNN
F 3 "" H 9475 1650 50  0001 C CNN
	1    9475 1650
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small_US R17
U 1 1 5B6B1111
P 9475 1800
F 0 "R17" V 9425 1675 39  0000 C CNN
F 1 "0.75Ω" V 9425 1950 39  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 9515 1790 50  0001 C CNN
F 3 "" H 9475 1800 50  0001 C CNN
	1    9475 1800
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR025
U 1 1 5B6B603D
P 9750 1800
F 0 "#PWR025" H 9750 1550 50  0001 C CNN
F 1 "GND" H 9755 1627 50  0001 C CNN
F 2 "" H 9750 1800 50  0001 C CNN
F 3 "" H 9750 1800 50  0001 C CNN
	1    9750 1800
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R9
U 1 1 5B6B6077
P 6400 2000
F 0 "R9" H 6450 1950 50  0000 L CNN
F 1 "20K" H 6450 2050 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6440 1990 50  0001 C CNN
F 3 "" H 6400 2000 50  0001 C CNN
	1    6400 2000
	-1   0    0    1   
$EndComp
$Comp
L Device:R_Small_US R8
U 1 1 5B6B6122
P 6400 1700
F 0 "R8" H 6250 1750 50  0000 L CNN
F 1 "13K" H 6200 1650 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 6440 1690 50  0001 C CNN
F 3 "" H 6400 1700 50  0001 C CNN
	1    6400 1700
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR09
U 1 1 5B6B9D77
P 6400 2150
F 0 "#PWR09" H 6400 1900 50  0001 C CNN
F 1 "GND" H 6405 1977 50  0001 C CNN
F 2 "" H 6400 2150 50  0001 C CNN
F 3 "" H 6400 2150 50  0001 C CNN
	1    6400 2150
	1    0    0    -1  
$EndComp
$Comp
L Device:CP1_Small C2
U 1 1 5B6C94F0
P 2650 3500
F 0 "C2" V 2700 3700 50  0000 C CNN
F 1 "10uF" V 2750 3500 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 2650 3500 50  0001 C CNN
F 3 "" H 2650 3500 50  0001 C CNN
	1    2650 3500
	0    -1   -1   0   
$EndComp
$Comp
L Device:C_Small C3
U 1 1 5B6CFCB3
P 2650 3750
F 0 "C3" V 2550 3550 50  0000 C CNN
F 1 "0.1uF" V 2550 3750 50  0000 C CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 2650 3750 50  0001 C CNN
F 3 "" H 2650 3750 50  0001 C CNN
	1    2650 3750
	0    1    1    0   
$EndComp
Wire Wire Line
	2550 3750 2500 3750
Wire Wire Line
	2750 3750 2800 3750
Connection ~ 2800 3750
Wire Wire Line
	2800 3750 2800 3800
Wire Wire Line
	2550 3500 2500 3500
Wire Wire Line
	2500 3500 2500 3750
Wire Wire Line
	2750 3500 2800 3500
Wire Wire Line
	2800 3500 2800 3750
$Comp
L Device:C_Small C4
U 1 1 5B7074C1
P 6700 2000
F 0 "C4" H 6775 1950 50  0000 L CNN
F 1 "1uF" H 6775 2050 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 6700 2000 50  0001 C CNN
F 3 "" H 6700 2000 50  0001 C CNN
	1    6700 2000
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR012
U 1 1 5B7075DD
P 6700 2150
F 0 "#PWR012" H 6700 1900 50  0001 C CNN
F 1 "GND" H 6705 1977 50  0001 C CNN
F 2 "" H 6700 2150 50  0001 C CNN
F 3 "" H 6700 2150 50  0001 C CNN
	1    6700 2150
	1    0    0    -1  
$EndComp
$Comp
L power:+9V #PWR019
U 1 1 5B7323FF
P 8250 4000
F 0 "#PWR019" H 8250 3850 50  0001 C CNN
F 1 "+9V" H 8265 4173 50  0000 C CNN
F 2 "" H 8250 4000 50  0001 C CNN
F 3 "" H 8250 4000 50  0001 C CNN
	1    8250 4000
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x02 J4
U 1 1 5B7327A7
P 7650 4100
F 0 "J4" H 7600 3900 50  0000 L CNN
F 1 "Battery" V 7750 3900 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B02B-XH-A_1x02_P2.50mm_Vertical" H 7650 4100 50  0001 C CNN
F 3 "" H 7650 4100 50  0001 C CNN
	1    7650 4100
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR016
U 1 1 5B73523A
P 7850 4550
F 0 "#PWR016" H 7850 4300 50  0001 C CNN
F 1 "GND" H 7855 4377 50  0001 C CNN
F 2 "" H 7850 4550 50  0001 C CNN
F 3 "" H 7850 4550 50  0001 C CNN
	1    7850 4550
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR024
U 1 1 5B75EC5B
P 9275 4000
F 0 "#PWR024" H 9275 3850 50  0001 C CNN
F 1 "+3.3V" H 9290 4173 50  0000 C CNN
F 2 "" H 9275 4000 50  0001 C CNN
F 3 "" H 9275 4000 50  0001 C CNN
	1    9275 4000
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x04 J5
U 1 1 5B768068
P 10550 1300
F 0 "J5" H 10500 1500 50  0000 L CNN
F 1 "Stepper Motor" V 10650 1000 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B04B-XH-A_1x04_P2.50mm_Vertical" H 10550 1300 50  0001 C CNN
F 3 "" H 10550 1300 50  0001 C CNN
	1    10550 1300
	1    0    0    -1  
$EndComp
Wire Wire Line
	9250 1200 10350 1200
Wire Wire Line
	10350 1300 9250 1300
Wire Wire Line
	9250 1400 10350 1400
Wire Wire Line
	10350 1500 9250 1500
$Comp
L Connector_Generic:Conn_01x04 J1
U 1 1 5B794916
P 600 1400
F 0 "J1" H 600 1100 50  0000 C CNN
F 1 "SBW" H 600 1650 50  0000 C CNN
F 2 "Connector_JST:JST_XH_B04B-XH-A_1x04_P2.50mm_Vertical" H 600 1400 50  0001 C CNN
F 3 "" H 600 1400 50  0001 C CNN
	1    600  1400
	-1   0    0    1   
$EndComp
$Comp
L Device:R_Small_US R1
U 1 1 5B79A19C
P 1050 1050
F 0 "R1" H 1118 1096 50  0000 L CNN
F 1 "47K" H 1118 1005 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 1090 1040 50  0001 C CNN
F 3 "" H 1050 1050 50  0001 C CNN
	1    1050 1050
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR02
U 1 1 5B79A24D
P 950 900
F 0 "#PWR02" H 950 750 50  0001 C CNN
F 1 "+3.3V" H 965 1073 50  0000 C CNN
F 2 "" H 950 900 50  0001 C CNN
F 3 "" H 950 900 50  0001 C CNN
	1    950  900 
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C1
U 1 1 5B79A2A8
P 1050 1450
F 0 "C1" H 925 1525 39  0000 L CNN
F 1 "1nF" H 900 1375 39  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 1050 1450 50  0001 C CNN
F 3 "" H 1050 1450 50  0001 C CNN
	1    1050 1450
	1    0    0    -1  
$EndComp
Connection ~ 1050 1200
Wire Wire Line
	1050 1200 1450 1200
Wire Wire Line
	1050 1350 1050 1200
$Comp
L power:GND #PWR03
U 1 1 5B7A31FD
P 1050 1550
F 0 "#PWR03" H 1050 1300 50  0001 C CNN
F 1 "GND" H 1055 1377 50  0001 C CNN
F 2 "" H 1050 1550 50  0001 C CNN
F 3 "" H 1050 1550 50  0001 C CNN
	1    1050 1550
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG02
U 1 1 5B7AB73F
P 7950 4000
F 0 "#FLG02" H 7950 4075 50  0001 C CNN
F 1 "PWR_FLAG" H 7950 4150 39  0000 C CNN
F 2 "" H 7950 4000 50  0001 C CNN
F 3 "" H 7950 4000 50  0001 C CNN
	1    7950 4000
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5B7B6BF6
P 7850 4500
F 0 "#FLG01" H 7850 4575 50  0001 C CNN
F 1 "PWR_FLAG" V 7850 4625 39  0000 L CNN
F 2 "" H 7850 4500 50  0001 C CNN
F 3 "" H 7850 4500 50  0001 C CNN
	1    7850 4500
	0    1    1    0   
$EndComp
Text GLabel 4600 1400 2    39   Output ~ 0
FOCUS
Text GLabel 4600 1500 2    39   Output ~ 0
SHUTTER
Wire Wire Line
	4400 1400 4600 1400
Wire Wire Line
	4400 1500 4600 1500
Text GLabel 3850 4325 0    39   Input ~ 0
FOCUS
Text GLabel 3850 4925 0    39   Input ~ 0
SHUTTER
$Comp
L Device:R_Small_US R4
U 1 1 5B7E875D
P 4000 4925
F 0 "R4" V 3795 4925 50  0000 C CNN
F 1 "390" V 3886 4925 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 4040 4915 50  0001 C CNN
F 3 "" H 4000 4925 50  0001 C CNN
	1    4000 4925
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small_US R3
U 1 1 5B7F651B
P 4000 4325
F 0 "R3" V 3795 4325 50  0000 C CNN
F 1 "390" V 3886 4325 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 4040 4315 50  0001 C CNN
F 3 "" H 4000 4325 50  0001 C CNN
	1    4000 4325
	0    1    1    0   
$EndComp
$Comp
L Connector_Generic:Conn_01x03 J2
U 1 1 5B7FA201
P 5250 4725
F 0 "J2" H 5200 4925 50  0000 L CNN
F 1 "Shutter" V 5350 4575 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B03B-XH-A_1x03_P2.50mm_Vertical" H 5250 4725 50  0001 C CNN
F 3 "" H 5250 4725 50  0001 C CNN
	1    5250 4725
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R19
U 1 1 5BFADEE8
P 9275 4300
F 0 "R19" H 9325 4350 39  0000 L CNN
F 1 "JUMPER" H 9325 4275 39  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 9315 4290 50  0001 C CNN
F 3 "" H 9275 4300 50  0001 C CNN
	1    9275 4300
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R12
U 1 1 5BFBA57B
P 7850 4250
F 0 "R12" H 7900 4300 39  0000 L CNN
F 1 "JUMPER" H 7900 4225 39  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 7890 4240 50  0001 C CNN
F 3 "" H 7850 4250 50  0001 C CNN
	1    7850 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	800  1200 1050 1200
Wire Wire Line
	800  1300 1450 1300
$Comp
L Connector:TestPoint TP1
U 1 1 5BFED893
P 7850 4400
F 0 "TP1" V 7875 4575 39  0000 L CNN
F 1 "GND" V 7800 4575 39  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 8050 4400 50  0001 C CNN
F 3 "" H 8050 4400 50  0001 C CNN
	1    7850 4400
	0    -1   -1   0   
$EndComp
$Comp
L Connector:TestPoint TP2
U 1 1 5BFEDCCA
P 9275 4150
F 0 "TP2" V 9250 4325 39  0000 L CNN
F 1 "3.3V" V 9325 4325 39  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 9475 4150 50  0001 C CNN
F 3 "" H 9475 4150 50  0001 C CNN
	1    9275 4150
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR05
U 1 1 5BFF9C2B
P 1500 5500
F 0 "#PWR05" H 1500 5250 50  0001 C CNN
F 1 "GND" H 1505 5327 50  0001 C CNN
F 2 "" H 1500 5500 50  0001 C CNN
F 3 "" H 1500 5500 50  0001 C CNN
	1    1500 5500
	1    0    0    -1  
$EndComp
Text GLabel 1350 5400 0    39   Output ~ 0
SELECT_BTN
Text GLabel 1350 5300 0    39   Output ~ 0
OK_BTN
Text GLabel 4750 2400 2    39   Input ~ 0
SELECT_BTN
Text GLabel 4750 2500 2    39   Input ~ 0
OK_BTN
$Comp
L power:PWR_FLAG #FLG03
U 1 1 5C02DE1E
P 9275 4050
F 0 "#FLG03" H 9275 4125 50  0001 C CNN
F 1 "PWR_FLAG" V 9275 4175 39  0000 L CNN
F 2 "" H 9275 4050 50  0001 C CNN
F 3 "" H 9275 4050 50  0001 C CNN
	1    9275 4050
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR01
U 1 1 5C042C04
P 850 1550
F 0 "#PWR01" H 850 1300 50  0001 C CNN
F 1 "GND" H 855 1377 50  0001 C CNN
F 2 "" H 850 1550 50  0001 C CNN
F 3 "" H 850 1550 50  0001 C CNN
	1    850  1550
	1    0    0    -1  
$EndComp
Text GLabel 4600 1200 2    39   Output ~ 0
DRIVER_DIR
Wire Wire Line
	4400 1200 4600 1200
Text GLabel 7700 2100 0    39   Input ~ 0
DRIVER_DIR
Text GLabel 4600 1300 2    39   Output ~ 0
DRIVER_STEP
Wire Wire Line
	4400 1300 4600 1300
Text GLabel 7700 2000 0    39   Input ~ 0
DRIVER_STEP
Text GLabel 7700 1400 0    39   Input ~ 0
DRIVER_nSLEEP
Text GLabel 4600 1600 2    39   Output ~ 0
DRIVER_nSLEEP
Wire Wire Line
	4400 1600 4600 1600
Connection ~ 7650 1550
Text GLabel 7700 1200 0    39   Input ~ 0
DRIVER_nENABLE
Text GLabel 7700 1300 0    39   Input ~ 0
DRIVER_nRESET
Wire Wire Line
	6950 1550 7650 1550
Text GLabel 4600 1700 2    39   Output ~ 0
DRIVER_nENABLE
Text GLabel 4600 1800 2    39   Output ~ 0
DRIVER_nRESET
Wire Wire Line
	4400 1700 4600 1700
Wire Wire Line
	4400 1800 4600 1800
Wire Wire Line
	7700 1200 7850 1200
Wire Wire Line
	6700 2100 6700 2150
Wire Wire Line
	6400 1850 7850 1850
Wire Wire Line
	7700 2000 7850 2000
Wire Wire Line
	7700 2100 7850 2100
Wire Wire Line
	800  1400 850  1400
Wire Wire Line
	850  900  950  900 
Wire Wire Line
	850  900  850  1400
Connection ~ 950  900 
Wire Wire Line
	950  900  1050 900 
Wire Wire Line
	800  1500 850  1500
Wire Wire Line
	850  1500 850  1550
Wire Wire Line
	2500 3750 2200 3750
Connection ~ 2500 3750
$Comp
L Device:R_Small_US R2
U 1 1 5CD51D49
P 1400 5150
F 0 "R2" H 1450 5200 39  0000 L CNN
F 1 "100K" H 1450 5125 39  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 1440 5140 50  0001 C CNN
F 3 "" H 1400 5150 50  0001 C CNN
	1    1400 5150
	1    0    0    -1  
$EndComp
$Comp
L Device:Crystal_Small Y1
U 1 1 5CDBA737
P 5750 2800
F 0 "Y1" H 5750 2650 31  0000 C CNN
F 1 "32Khz" H 5750 2700 31  0000 C CNN
F 2 "Crystal:Crystal_SMD_MicroCrystal_CC7V-T1A-2Pin_3.2x1.5mm_HandSoldering" H 5750 2800 50  0001 C CNN
F 3 "~" H 5750 2800 50  0001 C CNN
	1    5750 2800
	-1   0    0    1   
$EndComp
$Comp
L Device:C_Small C10
U 1 1 5CDF1F2E
P 5850 2900
F 0 "C10" H 5950 2950 31  0000 L CNN
F 1 "CL2" H 5950 2900 31  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 5850 2900 50  0001 C CNN
F 3 "~" H 5850 2900 50  0001 C CNN
	1    5850 2900
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C9
U 1 1 5CDF1FC2
P 5650 2900
F 0 "C9" H 5450 2950 31  0000 L CNN
F 1 "CL1" H 5450 2900 31  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 5650 2900 50  0001 C CNN
F 3 "~" H 5650 2900 50  0001 C CNN
	1    5650 2900
	1    0    0    -1  
$EndComp
Connection ~ 5850 2800
$Comp
L power:GND #PWR027
U 1 1 5CE04BC0
P 5650 3000
F 0 "#PWR027" H 5650 2750 50  0001 C CNN
F 1 "GND" H 5655 2827 50  0001 C CNN
F 2 "" H 5650 3000 50  0001 C CNN
F 3 "" H 5650 3000 50  0001 C CNN
	1    5650 3000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR028
U 1 1 5CE04C25
P 5850 3000
F 0 "#PWR028" H 5850 2750 50  0001 C CNN
F 1 "GND" H 5855 2827 50  0001 C CNN
F 2 "" H 5850 3000 50  0001 C CNN
F 3 "" H 5850 3000 50  0001 C CNN
	1    5850 3000
	1    0    0    -1  
$EndComp
Wire Notes Line
	5400 2550 6100 2550
Wire Notes Line
	6100 2550 6100 3200
Wire Notes Line
	6100 3200 5400 3200
Wire Notes Line
	5400 3200 5400 2550
Text Notes 5650 3300 2    39   ~ 0
Optional
Connection ~ 5650 2800
Wire Wire Line
	4950 5775 5050 5775
Wire Wire Line
	5050 5875 5000 5875
Text Label 4550 2700 0    39   ~ 0
LCD_CLK
Text Label 4550 2800 0    39   ~ 0
LCD_MOSI
Text Label 4550 2900 0    39   ~ 0
LCD_DC
Wire Wire Line
	4400 2500 4750 2500
Wire Wire Line
	4400 2400 4750 2400
Entry Wire Line
	4250 6275 4350 6375
Entry Wire Line
	4250 6175 4350 6275
Entry Wire Line
	4250 6075 4350 6175
Text Label 4400 6375 0    39   ~ 0
LCD_CLK
Text Label 4400 6275 0    39   ~ 0
LCD_MOSI
Text Label 4400 6175 0    39   ~ 0
LCD_DC
Wire Wire Line
	5000 5875 5000 6575
Wire Wire Line
	1450 1700 1450 3200
Text Label 4550 3200 0    39   ~ 0
LCD_RST
Entry Wire Line
	4250 5975 4350 6075
Text Label 4400 6075 0    39   ~ 0
LCD_RST
Wire Wire Line
	4350 6075 5050 6075
Wire Wire Line
	4350 6175 5050 6175
Wire Wire Line
	4350 6275 5050 6275
Wire Wire Line
	4350 6375 5050 6375
Wire Wire Line
	5650 2300 5650 2800
Wire Wire Line
	4400 2300 5650 2300
Wire Wire Line
	5850 2200 5850 2800
Wire Wire Line
	4400 2200 5850 2200
Wire Wire Line
	2800 3100 2800 3500
Connection ~ 2800 3100
Connection ~ 2800 3500
Wire Wire Line
	2500 3100 2500 3500
Connection ~ 2500 3500
Text Label 9300 1200 0    39   ~ 0
9V_Coil1A
Text Label 9300 1300 0    39   ~ 0
9V_Coil1B
Text Label 9300 1400 0    39   ~ 0
9V_Coil2A
Text Label 9300 1500 0    39   ~ 0
9V_Coil2B
Text Label 7500 1550 0    39   ~ 0
9V
$Comp
L power:GND #PWR0101
U 1 1 5CCCA02C
P 8550 6000
F 0 "#PWR0101" H 8550 5750 50  0001 C CNN
F 1 "GND" H 8555 5827 50  0001 C CNN
F 2 "" H 8550 6000 50  0001 C CNN
F 3 "" H 8550 6000 50  0001 C CNN
	1    8550 6000
	1    0    0    -1  
$EndComp
Text GLabel 8300 4000 2    39   Input ~ 0
BATT_9V
Wire Wire Line
	7850 4000 7950 4000
Connection ~ 7950 4000
Wire Wire Line
	7950 4000 8250 4000
Connection ~ 8250 4000
Wire Wire Line
	8250 4000 8300 4000
Wire Wire Line
	7850 4400 7850 4500
Connection ~ 7850 4500
Wire Wire Line
	7850 4500 7850 4550
Text GLabel 9225 4450 0    39   Input ~ 0
SUPPLY_3.3V
Wire Wire Line
	9275 4450 9225 4450
Text GLabel 9200 5650 2    39   Input ~ 0
SUPPLY_3.3V
Text GLabel 7800 5650 0    39   Input ~ 0
BATT_9V
$Comp
L Device:C_Small C11
U 1 1 5CD5A15C
P 7950 5750
F 0 "C11" H 8025 5800 39  0000 L CNN
F 1 "1uF" H 8025 5725 39  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 7950 5750 50  0001 C CNN
F 3 "" H 7950 5750 50  0001 C CNN
	1    7950 5750
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C12
U 1 1 5CD5A471
P 9050 5750
F 0 "C12" H 9125 5775 39  0000 L CNN
F 1 "1uF" H 9125 5700 39  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 9050 5750 50  0001 C CNN
F 3 "" H 9050 5750 50  0001 C CNN
	1    9050 5750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5CD5AAD8
P 7950 5850
F 0 "#PWR0102" H 7950 5600 50  0001 C CNN
F 1 "GND" H 7955 5677 50  0001 C CNN
F 2 "" H 7950 5850 50  0001 C CNN
F 3 "" H 7950 5850 50  0001 C CNN
	1    7950 5850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 5CD5AB41
P 9050 5850
F 0 "#PWR0103" H 9050 5600 50  0001 C CNN
F 1 "GND" H 9055 5677 50  0001 C CNN
F 2 "" H 9050 5850 50  0001 C CNN
F 3 "" H 9050 5850 50  0001 C CNN
	1    9050 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 5650 7950 5650
Wire Wire Line
	8900 5650 9050 5650
Wire Wire Line
	8200 5800 8200 5650
Connection ~ 8200 5650
Connection ~ 9050 5650
Wire Wire Line
	9050 5650 9200 5650
Wire Notes Line
	9700 6200 7450 6200
Wire Notes Line
	7450 5350 9700 5350
Text Notes 7450 5300 0    39   ~ 0
Power supply: Fixed LDO
Wire Notes Line
	9700 5350 9700 6200
Wire Notes Line
	7450 5350 7450 6200
Connection ~ 7950 5650
Wire Wire Line
	7950 5650 8200 5650
Wire Wire Line
	9275 4050 9275 4150
Wire Wire Line
	9275 4050 9275 4000
Connection ~ 9275 4050
$Comp
L Mechanical:MountingHole H1
U 1 1 5CD4DBD1
P 1050 7250
F 0 "H1" H 1150 7296 50  0000 L CNN
F 1 "M2" H 1150 7205 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2" H 1050 7250 50  0001 C CNN
F 3 "~" H 1050 7250 50  0001 C CNN
	1    1050 7250
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 5CD4EA18
P 1400 7250
F 0 "H2" H 1500 7296 50  0000 L CNN
F 1 "M2" H 1500 7205 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2" H 1400 7250 50  0001 C CNN
F 3 "~" H 1400 7250 50  0001 C CNN
	1    1400 7250
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 5CD4EDB8
P 1750 7250
F 0 "H3" H 1850 7296 50  0000 L CNN
F 1 "M2" H 1850 7205 50  0000 L CNN
F 2 "MountingHole:MountingHole_2.2mm_M2" H 1750 7250 50  0001 C CNN
F 3 "~" H 1750 7250 50  0001 C CNN
	1    1750 7250
	1    0    0    -1  
$EndComp
Text Notes 4200 6025 3    39   ~ 0
Display
Wire Wire Line
	4350 5975 5050 5975
Text Label 4400 5975 0    39   ~ 0
LCD_nCS
Entry Wire Line
	4250 5875 4350 5975
Text GLabel 3625 6850 0    39   Input ~ 0
LCD_LED
Wire Wire Line
	1450 1600 1400 1600
Wire Wire Line
	1400 1600 1400 3300
Text Label 4550 3300 0    39   ~ 0
LCD_nCS
Text GLabel 4550 3550 2    39   Output ~ 0
LCD_LED
Text Notes 5050 3400 1    39   ~ 0
Display
Entry Wire Line
	4850 3300 4950 3400
Entry Wire Line
	4850 3200 4950 3300
Entry Wire Line
	4850 2900 4950 3000
Entry Wire Line
	4850 2800 4950 2900
Entry Wire Line
	4850 2700 4950 2800
Wire Wire Line
	4400 2700 4450 2700
Wire Wire Line
	4450 2700 4450 3550
Wire Wire Line
	4400 2800 4850 2800
Wire Wire Line
	4400 2900 4850 2900
Wire Wire Line
	4400 2600 4500 2600
Wire Wire Line
	4500 2600 4500 2700
Wire Wire Line
	4500 2700 4850 2700
$Comp
L power:GND #PWR018
U 1 1 5CE12C1A
P 4375 6850
F 0 "#PWR018" H 4375 6600 50  0001 C CNN
F 1 "GND" H 4380 6677 50  0001 C CNN
F 2 "" H 4375 6850 50  0001 C CNN
F 3 "" H 4375 6850 50  0001 C CNN
	1    4375 6850
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 5400 1500 5400
Wire Wire Line
	1450 3200 4850 3200
Wire Wire Line
	1400 3300 4850 3300
Wire Wire Line
	7700 1400 7850 1400
Wire Wire Line
	4450 3550 4550 3550
Wire Notes Line
	2000 7100 900  7100
$Comp
L power:GND #PWR0104
U 1 1 5CE5ACAD
P 1050 7350
F 0 "#PWR0104" H 1050 7100 50  0001 C CNN
F 1 "GND" H 1055 7177 50  0001 C CNN
F 2 "" H 1050 7350 50  0001 C CNN
F 3 "" H 1050 7350 50  0001 C CNN
	1    1050 7350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 5CE5BA1D
P 1400 7350
F 0 "#PWR0105" H 1400 7100 50  0001 C CNN
F 1 "GND" H 1405 7177 50  0001 C CNN
F 2 "" H 1400 7350 50  0001 C CNN
F 3 "" H 1400 7350 50  0001 C CNN
	1    1400 7350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0106
U 1 1 5CE5BC8C
P 1750 7350
F 0 "#PWR0106" H 1750 7100 50  0001 C CNN
F 1 "GND" H 1755 7177 50  0001 C CNN
F 2 "" H 1750 7350 50  0001 C CNN
F 3 "" H 1750 7350 50  0001 C CNN
	1    1750 7350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1750 7300 1750 7350
Wire Wire Line
	1400 7300 1400 7350
Wire Wire Line
	1050 7300 1050 7350
Wire Notes Line
	900  7100 900  7500
Wire Notes Line
	900  7500 2000 7500
Wire Notes Line
	2000 7100 2000 7500
Text Notes 900  7050 0    39   ~ 0
Through-hole PCB mounts
Wire Wire Line
	4750 4325 4950 4325
Wire Wire Line
	4750 4925 4950 4925
Wire Wire Line
	4950 4925 4950 4725
Wire Wire Line
	4950 4725 5050 4725
Wire Wire Line
	4750 4525 4850 4525
Wire Wire Line
	4850 4525 4850 4825
Wire Wire Line
	4850 4825 5050 4825
Wire Wire Line
	4750 5125 4850 5125
Wire Wire Line
	4850 5125 4850 4825
Connection ~ 4850 4825
Wire Wire Line
	5050 4625 4950 4625
Wire Wire Line
	4950 4625 4950 4325
$Comp
L power:GND #PWR020
U 1 1 5CFD3BC7
P 4150 4525
F 0 "#PWR020" H 4150 4275 50  0001 C CNN
F 1 "GND" H 4155 4352 50  0001 C CNN
F 2 "" H 4150 4525 50  0001 C CNN
F 3 "" H 4150 4525 50  0001 C CNN
	1    4150 4525
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR022
U 1 1 5CFD4006
P 4150 5125
F 0 "#PWR022" H 4150 4875 50  0001 C CNN
F 1 "GND" H 4155 4952 50  0001 C CNN
F 2 "" H 4150 5125 50  0001 C CNN
F 3 "" H 4150 5125 50  0001 C CNN
	1    4150 5125
	1    0    0    -1  
$EndComp
$Comp
L LocalSwitches:SiP32510 U5
U 1 1 5CFE0C7A
P 4275 6850
F 0 "U5" H 4000 7241 39  0000 C CNN
F 1 "SiP32510" H 4000 7166 39  0000 C CNN
F 2 "Package_TO_SOT_SMD:TSOT-23-6_HandSoldering" H 4425 6650 39  0001 C CNN
F 3 "" H 4275 6850 39  0001 C CNN
	1    4275 6850
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR029
U 1 1 5CFEA544
P 3425 6700
F 0 "#PWR029" H 3425 6550 50  0001 C CNN
F 1 "+3.3V" H 3325 6850 50  0000 L CNN
F 2 "" H 3425 6700 50  0001 C CNN
F 3 "" H 3425 6700 50  0001 C CNN
	1    3425 6700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3425 6700 3625 6700
Wire Wire Line
	4375 6475 4375 6700
Wire Wire Line
	7700 1300 7775 1300
$Comp
L power:+3.3V #PWR030
U 1 1 5D05B53C
P 7775 900
F 0 "#PWR030" H 7775 750 50  0001 C CNN
F 1 "+3.3V" H 7675 1050 50  0000 L CNN
F 2 "" H 7775 900 50  0001 C CNN
F 3 "" H 7775 900 50  0001 C CNN
	1    7775 900 
	1    0    0    -1  
$EndComp
Wire Wire Line
	7775 1100 7775 1300
Connection ~ 7775 1300
Wire Wire Line
	7775 1300 7850 1300
Text Notes 8825 900  0    39   ~ 0
0.4 Vcc at PFD for mixed decay
Wire Notes Line
	8800 625  8800 950 
Wire Notes Line
	8800 950  10525 950 
Wire Notes Line
	10525 950  10525 625 
Wire Notes Line
	10525 625  8800 625 
Text Notes 8825 750  0    39   ~ 0
Istepmax = Vref / (8 * Rsense) = 2V / 6Ω = 333mA
Wire Wire Line
	6700 1550 6700 1750
Wire Wire Line
	6700 1750 6700 1900
Connection ~ 6700 1750
Wire Wire Line
	9275 1800 9275 1750
Wire Wire Line
	9275 1750 9250 1750
$Comp
L Device:C_Small C7
U 1 1 5B6A40BB
P 9525 2200
F 0 "C7" V 9475 2075 39  0000 L CNN
F 1 "68pF" V 9475 2250 39  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 9563 2050 50  0001 C CNN
F 3 "" H 9525 2200 50  0001 C CNN
	1    9525 2200
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small_US R5
U 1 1 5D052E07
P 4650 6475
F 0 "R5" V 4750 6375 50  0000 C CNN
F 1 "390" V 4750 6575 50  0000 C CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 4690 6465 50  0001 C CNN
F 3 "" H 4650 6475 50  0001 C CNN
	1    4650 6475
	0    1    1    0   
$EndComp
$Comp
L Device:C_Small C8
U 1 1 5B6A5411
P 10100 2100
F 0 "C8" V 10000 2000 39  0000 L CNN
F 1 "68pF" V 10000 2125 39  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 10138 1950 50  0001 C CNN
F 3 "" H 10100 2100 50  0001 C CNN
	1    10100 2100
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small_US R6
U 1 1 5D0B2CF1
P 7775 1000
F 0 "R6" H 7625 1050 50  0000 L CNN
F 1 "100K" H 7525 950 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 7775 1000 50  0001 C CNN
F 3 "~" H 7775 1000 50  0001 C CNN
	1    7775 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 1550 6400 1600
Wire Wire Line
	6400 2100 6400 2150
Wire Wire Line
	7850 4100 7850 4150
Wire Wire Line
	7850 4350 7850 4400
Connection ~ 7850 4400
Wire Wire Line
	9275 4150 9275 4200
Connection ~ 9275 4150
Wire Wire Line
	6400 1800 6400 1850
Connection ~ 6400 1850
Wire Wire Line
	6400 1850 6400 1900
Wire Wire Line
	4375 6475 4550 6475
Wire Wire Line
	4750 6475 5050 6475
Wire Wire Line
	3850 4925 3900 4925
Wire Wire Line
	4100 4925 4150 4925
Wire Wire Line
	3850 4325 3900 4325
Wire Wire Line
	4100 4325 4150 4325
Wire Wire Line
	1350 5300 1400 5300
Wire Wire Line
	1400 5250 1400 5300
Connection ~ 1400 5300
Wire Wire Line
	1400 5300 1500 5300
Wire Wire Line
	1050 1150 1050 1200
$Comp
L Connector_Generic:Conn_01x03 J6
U 1 1 5D0B324D
P 1700 5400
F 0 "J6" H 1650 5600 50  0000 L CNN
F 1 "Buttons" V 1800 5250 50  0000 L CNN
F 2 "Connector_JST:JST_XH_B03B-XH-A_1x03_P2.50mm_Vertical" H 1700 5400 50  0001 C CNN
F 3 "" H 1700 5400 50  0001 C CNN
	1    1700 5400
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR04
U 1 1 5CD5822B
P 1400 5050
F 0 "#PWR04" H 1400 4900 50  0001 C CNN
F 1 "+3.3V" H 1400 5200 50  0000 C CNN
F 2 "" H 1400 5050 50  0001 C CNN
F 3 "" H 1400 5050 50  0001 C CNN
	1    1400 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	9275 4400 9275 4450
Wire Wire Line
	1050 900  1050 950 
$Comp
L power:+3.3V #PWR010
U 1 1 5BF6F8D9
P 6550 1550
F 0 "#PWR010" H 6550 1400 50  0001 C CNN
F 1 "+3.3V" H 6400 1700 50  0000 L CNN
F 2 "" H 6550 1550 50  0001 C CNN
F 3 "" H 6550 1550 50  0001 C CNN
	1    6550 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	6700 1750 7850 1750
$Comp
L power:+3.3V #PWR014
U 1 1 5B7B669E
P 7025 2200
F 0 "#PWR014" H 7025 2050 50  0001 C CNN
F 1 "+3.3V" H 6875 2350 50  0000 L CNN
F 2 "" H 7025 2200 50  0001 C CNN
F 3 "" H 7025 2200 50  0001 C CNN
	1    7025 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	7025 2200 7025 2250
$Comp
L power:GND #PWR015
U 1 1 5B69C5D6
P 7025 2750
F 0 "#PWR015" H 7025 2500 50  0001 C CNN
F 1 "GND" H 7030 2577 50  0001 C CNN
F 2 "" H 7025 2750 50  0001 C CNN
F 3 "" H 7025 2750 50  0001 C CNN
	1    7025 2750
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R10
U 1 1 5B6991D4
P 7025 2350
F 0 "R10" H 7075 2400 50  0000 L CNN
F 1 "100K" H 7075 2300 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 7065 2340 50  0001 C CNN
F 3 "" H 7025 2350 50  0001 C CNN
	1    7025 2350
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R11
U 1 1 5B699187
P 7025 2650
F 0 "R11" H 7075 2700 50  0000 L CNN
F 1 "68K" H 7075 2600 50  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 7065 2640 50  0001 C CNN
F 3 "" H 7025 2650 50  0001 C CNN
	1    7025 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	7025 2450 7025 2500
Wire Wire Line
	7750 2200 7025 2200
Connection ~ 7750 2200
Connection ~ 7025 2200
Wire Wire Line
	7850 2500 7025 2500
Connection ~ 7025 2500
Wire Wire Line
	7025 2500 7025 2550
$Comp
L Device:R_Small_US R15
U 1 1 5B6A3F6C
P 9375 2300
F 0 "R15" H 9200 2300 39  0000 L CNN
F 1 "20K" H 9200 2225 39  0000 L CNN
F 2 "Resistor_SMD:R_0603_1608Metric_Pad1.05x0.95mm_HandSolder" V 9415 2290 50  0001 C CNN
F 3 "" H 9375 2300 50  0001 C CNN
	1    9375 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	9250 2200 9375 2200
Wire Wire Line
	9250 2100 9950 2100
$Comp
L power:GND #PWR0107
U 1 1 5D239639
P 10200 2300
F 0 "#PWR0107" H 10200 2050 50  0001 C CNN
F 1 "GND" H 10205 2127 50  0001 C CNN
F 2 "" H 10200 2300 50  0001 C CNN
F 3 "" H 10200 2300 50  0001 C CNN
	1    10200 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	9950 2100 10000 2100
Connection ~ 9950 2100
Wire Wire Line
	10200 2100 10200 2300
Connection ~ 9375 2200
Wire Wire Line
	9375 2200 9425 2200
$Comp
L power:GND #PWR0108
U 1 1 5D264A2D
P 9625 2400
F 0 "#PWR0108" H 9625 2150 50  0001 C CNN
F 1 "GND" H 9630 2227 50  0001 C CNN
F 2 "" H 9625 2400 50  0001 C CNN
F 3 "" H 9625 2400 50  0001 C CNN
	1    9625 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	9625 2200 9625 2400
Wire Wire Line
	9275 1800 9375 1800
Wire Wire Line
	9250 1650 9375 1650
Wire Wire Line
	9575 1800 9750 1800
Wire Wire Line
	9575 1650 9750 1650
Wire Wire Line
	9750 1650 9750 1800
Connection ~ 9750 1800
Wire Wire Line
	6400 1550 6550 1550
Wire Wire Line
	6550 1550 6700 1550
Connection ~ 6550 1550
$Comp
L LocalGraphics:ProjectLogo LG1
U 1 1 5D07152C
P 2675 7375
F 0 "LG1" H 2450 7550 39  0000 L CNN
F 1 "ProjectLogo" H 2450 7400 39  0000 L CNN
F 2 "Logo:ursa_minor" H 2675 7375 39  0001 C CNN
F 3 "" H 2675 7375 39  0001 C CNN
	1    2675 7375
	1    0    0    -1  
$EndComp
Wire Notes Line
	2225 7100 2225 7500
Wire Notes Line
	2225 7500 2975 7500
Wire Notes Line
	2975 7500 2975 7100
Wire Notes Line
	2975 7100 2225 7100
Text Notes 2225 7050 0    39   ~ 0
Board markings
$Comp
L LocalIsolator:ILD205 U2
U 1 1 5D16A6B0
P 4450 4425
F 0 "U2" H 4450 4750 50  0000 C CNN
F 1 "ILD205" H 4450 4659 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 4250 4225 50  0001 L CIN
F 3 "https://www.vishay.com/docs/83640/ild74.pdf" H 4450 4425 50  0001 L CNN
	1    4450 4425
	1    0    0    -1  
$EndComp
$Comp
L LocalIsolator:ILD205 U2
U 2 1 5D16AF95
P 4450 5025
F 0 "U2" H 4450 5350 50  0000 C CNN
F 1 "ILD205" H 4450 5259 50  0000 C CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 4250 4825 50  0001 L CIN
F 3 "https://www.vishay.com/docs/83640/ild74.pdf" H 4450 5025 50  0001 L CNN
	2    4450 5025
	1    0    0    -1  
$EndComp
$Comp
L Connector:TestPoint TP4
U 1 1 5D1719B6
P 4400 1900
F 0 "TP4" V 4475 1900 39  0000 L CNN
F 1 "P1.7" V 4475 2050 39  0000 L CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 4600 1900 50  0001 C CNN
F 3 "~" H 4600 1900 50  0001 C CNN
	1    4400 1900
	0    1    1    0   
$EndComp
$Comp
L Connector:TestPoint TP3
U 1 1 5D172367
P 1450 1500
F 0 "TP3" V 1450 1725 39  0000 C CNN
F 1 "P3.0" V 1375 1725 39  0000 C CNN
F 2 "TestPoint:TestPoint_Pad_D1.0mm" H 1650 1500 50  0001 C CNN
F 3 "~" H 1650 1500 50  0001 C CNN
	1    1450 1500
	0    -1   -1   0   
$EndComp
$Comp
L LocalICs:MSP430FR2433 U1
U 1 1 5B6291B1
P 1050 2750
F 0 "U1" H 2756 4565 50  0000 C CNN
F 1 "MSP430FR2433" H 2756 4474 50  0000 C CNN
F 2 "Package_DFN_QFN:VQFN-24-1EP_4x4mm_P0.5mm_EP2.45x2.45mm" H 3150 4450 50  0001 C CNN
F 3 "" H 1050 2750 50  0001 C CNN
	1    1050 2750
	1    0    0    -1  
$EndComp
$Comp
L LocalPower:NCP718 U4
U 1 1 5CCC17DC
P 8450 5750
F 0 "U4" H 8300 5950 50  0000 L CNN
F 1 "NCP718" H 8800 5950 50  0000 R CNN
F 2 "Package_TO_SOT_SMD:SOT-23-5_HandSoldering" H 9300 5550 39  0001 C CNN
F 3 "" H 8450 5750 39  0001 C CNN
	1    8450 5750
	1    0    0    -1  
$EndComp
Wire Bus Line
	4950 3000 4950 3300
Wire Bus Line
	4950 3300 4950 3400
Wire Bus Line
	4250 6075 4250 6175
Wire Bus Line
	4250 6175 4250 6275
Wire Bus Line
	4250 5975 4250 6075
Wire Bus Line
	4250 5875 4250 5975
Wire Bus Line
	4950 2900 4950 3000
Wire Bus Line
	4950 2800 4950 2900
$EndSCHEMATC
