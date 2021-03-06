EESchema Schematic File Version 2
LIBS:GNSS_Firehose
LIBS:GNSS_Firehose-cache
EELAYER 25 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 9 10
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
L R R145
U 1 1 58DB5132
P 2150 2300
F 0 "R145" H 2050 2550 50  0000 C CNN
F 1 "0" H 2050 2450 50  0000 C CNN
F 2 "footprints:0805" H 2150 2300 50  0001 C CNN
F 3 "" H 2150 2300 50  0001 C CNN
	1    2150 2300
	1    0    0    -1  
$EndComp
$Comp
L PJ-063BH J8
U 1 1 58DB547A
P 1400 2300
F 0 "J8" H 1050 1950 60  0000 C CNN
F 1 "PJ-063BH" H 1050 1800 60  0000 C CNN
F 2 "footprints:PJ-063BH" H 1400 2300 60  0001 C CNN
F 3 "" H 1400 2300 60  0001 C CNN
	1    1400 2300
	1    0    0    -1  
$EndComp
$Comp
L PMOSFET Q1
U 1 1 58DB5B80
P 3100 2350
F 0 "Q1" V 3500 2400 60  0000 C CNN
F 1 "Si2369DS" V 3400 2400 60  0000 C CNN
F 2 "footprints:SOT23" H 3110 2350 60  0001 C CNN
F 3 "" H 3110 2350 60  0001 C CNN
	1    3100 2350
	0    1    -1   0   
$EndComp
$Comp
L TVS Z1
U 1 1 58DB5D9E
P 2550 2450
F 0 "Z1" V 2050 2450 60  0000 C CNN
F 1 "SMAJ9.0CA" V 2150 2450 60  0000 C CNN
F 2 "footprints:SMAJ" H 2550 2450 60  0001 C CNN
F 3 "" H 2550 2450 60  0001 C CNN
	1    2550 2450
	0    1    1    0   
$EndComp
$Comp
L GND #PWR0181
U 1 1 58DB5E05
P 2550 2650
F 0 "#PWR0181" H 2750 2550 50  0001 C CNN
F 1 "GND" H 2750 2450 50  0001 C CNN
F 2 "" H 2550 2650 50  0001 C CNN
F 3 "" H 2550 2650 50  0001 C CNN
	1    2550 2650
	1    0    0    -1  
$EndComp
$Comp
L LTC3633 U17
U 1 1 58DB624F
P 6200 3850
F 0 "U17" H 6750 2950 60  0000 C CNN
F 1 "LTC3633" H 6850 2800 60  0000 C CNN
F 2 "footprints:UFD28" H 6200 3850 60  0001 C CNN
F 3 "" H 6200 3850 60  0001 C CNN
	1    6200 3850
	1    0    0    -1  
$EndComp
$Comp
L CP C194
U 1 1 58DB66DF
P 3850 2450
F 0 "C194" V 3450 2350 50  0000 C CNN
F 1 "47 uF 20V" V 3550 2350 50  0000 C CNN
F 2 "footprints:tantalum-size-D" H 3850 2450 50  0001 C CNN
F 3 "" H 3850 2450 50  0001 C CNN
	1    3850 2450
	0    1    1    0   
$EndComp
$Comp
L CP C198
U 1 1 58DB6748
P 4150 2450
F 0 "C198" V 3750 2600 50  0000 C CNN
F 1 "47 uF 20V" V 3850 2600 50  0000 C CNN
F 2 "footprints:tantalum-size-D" H 4150 2450 50  0001 C CNN
F 3 "" H 4150 2450 50  0001 C CNN
	1    4150 2450
	0    1    1    0   
$EndComp
$Comp
L L L11
U 1 1 58DB723F
P 4200 3900
F 0 "L11" H 4100 4150 50  0000 C CNN
F 1 "1 uH" H 4100 4050 50  0000 C CNN
F 2 "footprints:NRS5020" H 4200 3900 50  0001 C CNN
F 3 "" H 4200 3900 50  0001 C CNN
	1    4200 3900
	1    0    0    -1  
$EndComp
$Comp
L R R70
U 1 1 58DB729A
P 4200 4400
F 0 "R70" H 4200 4300 50  0000 C CNN
F 1 "54.9k" H 4200 4200 50  0000 C CNN
F 2 "footprints:0402" H 4200 4400 50  0001 C CNN
F 3 "" H 4200 4400 50  0001 C CNN
	1    4200 4400
	1    0    0    -1  
$EndComp
$Comp
L R R87
U 1 1 58DB7327
P 3150 3900
F 0 "R87" H 3150 4150 50  0000 C CNN
F 1 "0" H 3150 4050 50  0000 C CNN
F 2 "footprints:1210" H 3150 3900 50  0001 C CNN
F 3 "" H 3150 3900 50  0001 C CNN
	1    3150 3900
	1    0    0    -1  
$EndComp
$Comp
L R R71
U 1 1 58DB744C
P 4850 4550
F 0 "R71" V 4850 4750 50  0000 C CNN
F 1 "12.1k" V 4950 4750 50  0000 C CNN
F 2 "footprints:0402" H 4850 4550 50  0001 C CNN
F 3 "" H 4850 4550 50  0001 C CNN
	1    4850 4550
	0    1    1    0   
$EndComp
$Comp
L C C213
U 1 1 58DB7532
P 2850 4050
F 0 "C213" V 2850 3850 50  0000 C CNN
F 1 "NONE" V 2950 3850 50  0000 C CNN
F 2 "footprints:1210" H 2850 4050 50  0001 C CNN
F 3 "" H 2850 4050 50  0001 C CNN
	1    2850 4050
	0    1    1    0   
$EndComp
$Comp
L C C200
U 1 1 58DB7597
P 3450 4050
F 0 "C200" V 3450 4250 50  0000 C CNN
F 1 "22 uF" V 3550 4250 50  0000 C CNN
F 2 "footprints:1210" H 3450 4050 50  0001 C CNN
F 3 "" H 3450 4050 50  0001 C CNN
	1    3450 4050
	0    1    1    0   
$EndComp
$Comp
L C C199
U 1 1 58DB75F4
P 4750 3700
F 0 "C199" H 4750 3500 50  0000 C CNN
F 1 "0.1 uF 25V" H 4850 3600 50  0000 C CNN
F 2 "footprints:0402" H 4750 3700 50  0001 C CNN
F 3 "" H 4750 3700 50  0001 C CNN
	1    4750 3700
	-1   0    0    1   
$EndComp
$Comp
L test_point TP23
U 1 1 58DB7666
P 5300 3500
F 0 "TP23" H 5100 3500 50  0000 C CNN
F 1 "test_point" H 5300 3350 50  0001 C CNN
F 2 "footprints:TP_SMT" H 5300 3500 50  0001 C CNN
F 3 "" H 5300 3500 50  0001 C CNN
	1    5300 3500
	1    0    0    -1  
$EndComp
$Comp
L test_point TP24
U 1 1 58DB7795
P 5300 3600
F 0 "TP24" H 5100 3600 50  0000 C CNN
F 1 "test_point" H 5300 3450 50  0001 C CNN
F 2 "footprints:TP_SMT" H 5300 3600 50  0001 C CNN
F 3 "" H 5300 3600 50  0001 C CNN
	1    5300 3600
	1    0    0    -1  
$EndComp
$Comp
L R R74
U 1 1 58DB7805
P 4550 3200
F 0 "R74" V 4500 3000 50  0000 C CNN
F 1 "162k" V 4600 3000 50  0000 C CNN
F 2 "footprints:0402" H 4550 3200 50  0001 C CNN
F 3 "" H 4550 3200 50  0001 C CNN
	1    4550 3200
	0    1    1    0   
$EndComp
$Comp
L GND #PWR0182
U 1 1 58DB7F3C
P 2850 4250
F 0 "#PWR0182" H 3050 4150 50  0001 C CNN
F 1 "GND" H 3050 4050 50  0001 C CNN
F 2 "" H 2850 4250 50  0001 C CNN
F 3 "" H 2850 4250 50  0001 C CNN
	1    2850 4250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0183
U 1 1 58DB7F7A
P 3450 4250
F 0 "#PWR0183" H 3650 4150 50  0001 C CNN
F 1 "GND" H 3650 4050 50  0001 C CNN
F 2 "" H 3450 4250 50  0001 C CNN
F 3 "" H 3450 4250 50  0001 C CNN
	1    3450 4250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0184
U 1 1 58DB7FB8
P 4850 4750
F 0 "#PWR0184" H 5050 4650 50  0001 C CNN
F 1 "GND" H 5050 4550 50  0001 C CNN
F 2 "" H 4850 4750 50  0001 C CNN
F 3 "" H 4850 4750 50  0001 C CNN
	1    4850 4750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0185
U 1 1 58DB7FF6
P 6200 4850
F 0 "#PWR0185" H 6400 4750 50  0001 C CNN
F 1 "GND" H 6400 4650 50  0001 C CNN
F 2 "" H 6200 4850 50  0001 C CNN
F 3 "" H 6200 4850 50  0001 C CNN
	1    6200 4850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0186
U 1 1 58DB8034
P 4550 3400
F 0 "#PWR0186" H 4750 3300 50  0001 C CNN
F 1 "GND" H 4750 3200 50  0001 C CNN
F 2 "" H 4550 3400 50  0001 C CNN
F 3 "" H 4550 3400 50  0001 C CNN
	1    4550 3400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0187
U 1 1 58DB8072
P 3850 2650
F 0 "#PWR0187" H 4050 2550 50  0001 C CNN
F 1 "GND" H 4050 2450 50  0001 C CNN
F 2 "" H 3850 2650 50  0001 C CNN
F 3 "" H 3850 2650 50  0001 C CNN
	1    3850 2650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0188
U 1 1 58DB80B0
P 4150 2650
F 0 "#PWR0188" H 4350 2550 50  0001 C CNN
F 1 "GND" H 4350 2450 50  0001 C CNN
F 2 "" H 4150 2650 50  0001 C CNN
F 3 "" H 4150 2650 50  0001 C CNN
	1    4150 2650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0189
U 1 1 58DB80EE
P 3200 2650
F 0 "#PWR0189" H 3400 2550 50  0001 C CNN
F 1 "GND" H 3400 2450 50  0001 C CNN
F 2 "" H 3200 2650 50  0001 C CNN
F 3 "" H 3200 2650 50  0001 C CNN
	1    3200 2650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0190
U 1 1 58DB812C
P 1700 2600
F 0 "#PWR0190" H 1900 2500 50  0001 C CNN
F 1 "GND" H 1900 2400 50  0001 C CNN
F 2 "" H 1700 2600 50  0001 C CNN
F 3 "" H 1700 2600 50  0001 C CNN
	1    1700 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 2450 1700 2450
Wire Wire Line
	1700 2450 1700 2550
Wire Wire Line
	1600 2300 2000 2300
Wire Wire Line
	2300 2300 2900 2300
Connection ~ 2550 2300
Wire Wire Line
	3300 2300 6450 2300
Connection ~ 3850 2300
Connection ~ 4150 2300
Connection ~ 5950 2300
Connection ~ 6050 2300
Connection ~ 6350 2300
Wire Wire Line
	5050 2300 5050 2900
Wire Wire Line
	5050 2800 5300 2800
Connection ~ 5050 2300
Wire Wire Line
	5050 2900 5300 2900
Connection ~ 5050 2800
Wire Wire Line
	5300 3200 4900 3200
Wire Wire Line
	4900 3200 4900 3050
Wire Wire Line
	4900 3050 4550 3050
Wire Wire Line
	4350 3900 5300 3900
Wire Wire Line
	5300 4000 5200 4000
Wire Wire Line
	5200 4000 5200 3900
Connection ~ 5200 3900
Wire Wire Line
	3300 3900 4050 3900
Connection ~ 3450 3900
Wire Wire Line
	2200 3900 3000 3900
Connection ~ 2850 3900
Wire Wire Line
	3850 4400 4050 4400
Wire Wire Line
	3850 3900 3850 4400
Connection ~ 3850 3900
Wire Wire Line
	5300 4200 3850 4200
Connection ~ 3850 4200
Wire Wire Line
	4350 4400 5300 4400
Connection ~ 4850 4400
Wire Wire Line
	4500 3900 4500 3700
Wire Wire Line
	4500 3700 4600 3700
Connection ~ 4500 3900
Wire Wire Line
	4900 3700 5300 3700
$Comp
L R R75
U 1 1 58DB8DDF
P 4500 5950
F 0 "R75" H 4500 5800 50  0000 C CNN
F 1 "330" H 4500 5700 50  0000 C CNN
F 2 "footprints:0402" H 4500 5950 50  0001 C CNN
F 3 "" H 4500 5950 50  0001 C CNN
	1    4500 5950
	1    0    0    -1  
$EndComp
$Comp
L LED LED4
U 1 1 58DB8E71
P 5050 5950
F 0 "LED4" H 5100 5800 60  0000 C CNN
F 1 "LED" H 5100 5650 60  0001 C CNN
F 2 "footprints:APA2106" H 5060 5950 60  0001 C CNN
F 3 "" H 5060 5950 60  0001 C CNN
	1    5050 5950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0191
U 1 1 58DB8ECB
P 5550 6050
F 0 "#PWR0191" H 5750 5950 50  0001 C CNN
F 1 "GND" H 5750 5850 50  0001 C CNN
F 2 "" H 5550 6050 50  0001 C CNN
F 3 "" H 5550 6050 50  0001 C CNN
	1    5550 6050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 4800 6250 4800
Connection ~ 6200 4800
$Comp
L C C195
U 1 1 58DB903C
P 7800 2950
F 0 "C195" V 7750 3150 50  0000 C CNN
F 1 "2.2 uF" V 7850 3200 50  0000 C CNN
F 2 "footprints:0603" H 7800 2950 50  0001 C CNN
F 3 "" H 7800 2950 50  0001 C CNN
	1    7800 2950
	0    1    1    0   
$EndComp
$Comp
L GND #PWR0192
U 1 1 58DB90D8
P 7800 3150
F 0 "#PWR0192" H 8000 3050 50  0001 C CNN
F 1 "GND" H 8000 2950 50  0001 C CNN
F 2 "" H 7800 3150 50  0001 C CNN
F 3 "" H 7800 3150 50  0001 C CNN
	1    7800 3150
	1    0    0    -1  
$EndComp
$Comp
L C C197
U 1 1 58DB911F
P 7650 3700
F 0 "C197" H 7600 3500 50  0000 C CNN
F 1 "0.1 uF 25V" H 7500 3600 50  0000 C CNN
F 2 "footprints:0402" H 7650 3700 50  0001 C CNN
F 3 "" H 7650 3700 50  0001 C CNN
	1    7650 3700
	-1   0    0    1   
$EndComp
$Comp
L L L10
U 1 1 58DB91DE
P 8200 3900
F 0 "L10" H 8200 4150 50  0000 C CNN
F 1 "0.47 uF" H 8200 4050 50  0000 C CNN
F 2 "footprints:NRS5020" H 8200 3900 50  0001 C CNN
F 3 "" H 8200 3900 50  0001 C CNN
	1    8200 3900
	1    0    0    -1  
$EndComp
$Comp
L R R73
U 1 1 58DB92A2
P 8200 4400
F 0 "R73" H 8200 4300 50  0000 C CNN
F 1 "10k" H 8200 4200 50  0000 C CNN
F 2 "footprints:0402" H 8200 4400 50  0001 C CNN
F 3 "" H 8200 4400 50  0001 C CNN
	1    8200 4400
	1    0    0    -1  
$EndComp
$Comp
L R R72
U 1 1 58DB9367
P 7650 4550
F 0 "R72" V 7650 4350 50  0000 C CNN
F 1 "10k" V 7750 4350 50  0000 C CNN
F 2 "footprints:0402" H 7650 4550 50  0001 C CNN
F 3 "" H 7650 4550 50  0001 C CNN
	1    7650 4550
	0    1    1    0   
$EndComp
$Comp
L C C196
U 1 1 58DB940D
P 9050 4050
F 0 "C196" V 9000 3850 50  0000 C CNN
F 1 "47 uF" V 9100 3850 50  0000 C CNN
F 2 "footprints:1210" H 9050 4050 50  0001 C CNN
F 3 "" H 9050 4050 50  0001 C CNN
	1    9050 4050
	0    1    1    0   
$EndComp
$Comp
L R R143
U 1 1 58DB9510
P 9300 3900
F 0 "R143" H 9300 4150 50  0000 C CNN
F 1 "0" H 9300 4050 50  0000 C CNN
F 2 "footprints:1210" H 9300 3900 50  0001 C CNN
F 3 "" H 9300 3900 50  0001 C CNN
	1    9300 3900
	1    0    0    -1  
$EndComp
$Comp
L C C237
U 1 1 58DB95E6
P 9550 4050
F 0 "C237" V 9500 4250 50  0000 C CNN
F 1 "NONE" V 9600 4250 50  0000 C CNN
F 2 "footprints:1210" H 9550 4050 50  0001 C CNN
F 3 "" H 9550 4050 50  0001 C CNN
	1    9550 4050
	0    1    1    0   
$EndComp
$Comp
L GND #PWR0193
U 1 1 58DB96BD
P 7650 4750
F 0 "#PWR0193" H 7850 4650 50  0001 C CNN
F 1 "GND" H 7850 4550 50  0001 C CNN
F 2 "" H 7650 4750 50  0001 C CNN
F 3 "" H 7650 4750 50  0001 C CNN
	1    7650 4750
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0194
U 1 1 58DB9719
P 9050 4250
F 0 "#PWR0194" H 9250 4150 50  0001 C CNN
F 1 "GND" H 9250 4050 50  0001 C CNN
F 2 "" H 9050 4250 50  0001 C CNN
F 3 "" H 9050 4250 50  0001 C CNN
	1    9050 4250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR0195
U 1 1 58DB9775
P 9550 4250
F 0 "#PWR0195" H 9750 4150 50  0001 C CNN
F 1 "GND" H 9750 4050 50  0001 C CNN
F 2 "" H 9550 4250 50  0001 C CNN
F 3 "" H 9550 4250 50  0001 C CNN
	1    9550 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4350 5950 4100 5950
Wire Wire Line
	4650 5950 4900 5950
Wire Wire Line
	5200 5950 5550 5950
Wire Wire Line
	5550 5950 5550 6000
Wire Wire Line
	7100 3900 8050 3900
Wire Wire Line
	8350 3900 9150 3900
Connection ~ 9050 3900
Wire Wire Line
	9450 3900 10150 3900
Connection ~ 9550 3900
Wire Wire Line
	7100 3700 7500 3700
Wire Wire Line
	7800 3700 7900 3700
Wire Wire Line
	7900 3700 7900 3900
Connection ~ 7900 3900
Wire Wire Line
	7100 4200 8550 4200
Wire Wire Line
	8550 3900 8550 4400
Connection ~ 8550 3900
Wire Wire Line
	8550 4400 8350 4400
Connection ~ 8550 4200
Wire Wire Line
	7100 4400 8050 4400
Connection ~ 7650 4400
$Comp
L test_point TP25
U 1 1 58DBA36E
P 7100 3500
F 0 "TP25" H 7300 3500 50  0000 C CNN
F 1 "test_point" H 7100 3350 50  0001 C CNN
F 2 "footprints:TP_SMT" H 7100 3500 50  0001 C CNN
F 3 "" H 7100 3500 50  0001 C CNN
	1    7100 3500
	1    0    0    -1  
$EndComp
$Comp
L test_point TP26
U 1 1 58DBA414
P 7100 3600
F 0 "TP26" H 7300 3600 50  0000 C CNN
F 1 "test_point" H 7100 3450 50  0001 C CNN
F 2 "footprints:TP_SMT" H 7100 3600 50  0001 C CNN
F 3 "" H 7100 3600 50  0001 C CNN
	1    7100 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	7100 2700 7100 3300
Connection ~ 7100 3200
Connection ~ 7100 3100
Connection ~ 7100 3000
Connection ~ 7100 2900
Wire Wire Line
	7100 2700 7800 2700
Wire Wire Line
	7800 2700 7800 2800
Connection ~ 7100 2800
Wire Wire Line
	7100 4000 7250 4000
Wire Wire Line
	7250 4000 7250 3900
Connection ~ 7250 3900
$Comp
L VCC_3.3V #PWR0196
U 1 1 58E0661D
P 2200 3900
F 0 "#PWR0196" H 2380 3670 50  0001 C CNN
F 1 "VCC_3.3V" H 2330 3770 50  0001 C CNN
F 2 "" H 2200 3900 50  0001 C CNN
F 3 "" H 2200 3900 50  0001 C CNN
	1    2200 3900
	1    0    0    -1  
$EndComp
$Comp
L VCC_3.3V #PWR0197
U 1 1 58E06686
P 4100 5950
F 0 "#PWR0197" H 4280 5720 50  0001 C CNN
F 1 "VCC_3.3V" H 4230 5820 50  0001 C CNN
F 2 "" H 4100 5950 50  0001 C CNN
F 3 "" H 4100 5950 50  0001 C CNN
	1    4100 5950
	1    0    0    -1  
$EndComp
$Comp
L VCC_1.2V #PWR0198
U 1 1 58DF69EC
P 10150 3900
F 0 "#PWR0198" H 10330 3670 50  0001 C CNN
F 1 "VCC_1.2V" H 10280 3770 50  0001 C CNN
F 2 "" H 10150 3900 50  0001 C CNN
F 3 "" H 10150 3900 50  0001 C CNN
	1    10150 3900
	1    0    0    -1  
$EndComp
Text Notes 9050 950  0    150  ~ 30
Power
Text Notes 1050 3150 0    100  ~ 20
DC input
Text Notes 1250 3400 0    100  ~ 20
5V
Text Notes 2400 4650 0    100  ~ 20
3.3V
Text Notes 9600 4650 0    100  ~ 20
1.2V
$EndSCHEMATC
