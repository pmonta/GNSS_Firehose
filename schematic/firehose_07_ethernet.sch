v 20110115 2
C 38900 41100 0 0 0 title-D.sym
C 50500 52800 1 0 0 vsc8601.sym
{
T 55200 52700 5 10 1 1 0 6 1
refdes=U16
T 55200 61300 5 10 0 0 0 0 1
device=VSC8601
T 55200 61500 5 10 0 0 0 0 1
footprint=LQFP64_EP
}
C 62300 55900 1 0 0 rj45_gigabit.sym
{
T 64800 60300 5 10 1 1 0 6 1
refdes=J7
T 65000 60600 5 10 0 0 0 0 1
device=SI-51005-F
T 65000 60800 5 10 0 0 0 0 1
footprint=SI-51005-F
}
T 66900 62000 9 24 1 0 0 0 1
Ethernet
T 66200 41900 9 14 1 0 0 0 1
Ethernet
T 66300 41200 9 10 1 0 0 0 1
8
T 67900 41200 9 10 1 0 0 0 1
9
T 70000 41500 9 10 1 0 0 0 1
1
T 70000 41200 9 10 1 0 0 0 1
Copyright (c) 2012 Peter Monta
N 50600 59800 48900 59800 4
{
T 49100 59800 5 10 1 1 0 0 1
netname=PHY_TX_CLK
}
N 50600 59600 48900 59600 4
{
T 49100 59600 5 10 1 1 0 0 1
netname=PHY_TXD0
}
N 50600 59400 48900 59400 4
{
T 49100 59400 5 10 1 1 0 0 1
netname=PHY_TXD1
}
N 50600 59200 48900 59200 4
{
T 49100 59200 5 10 1 1 0 0 1
netname=PHY_TXD2
}
N 50600 59000 48900 59000 4
{
T 49100 59000 5 10 1 1 0 0 1
netname=PHY_TXD3
}
N 50600 58800 48900 58800 4
{
T 49100 58800 5 10 1 1 0 0 1
netname=PHY_TX_CTL
}
N 50600 58400 48900 58400 4
{
T 49100 58400 5 10 1 1 0 0 1
netname=PHY_RX_CLK
}
N 50600 58200 48900 58200 4
{
T 49100 58200 5 10 1 1 0 0 1
netname=PHY_RXD0
}
N 50600 58000 48900 58000 4
{
T 49100 58000 5 10 1 1 0 0 1
netname=PHY_RXD1
}
N 50600 57800 48900 57800 4
{
T 49100 57800 5 10 1 1 0 0 1
netname=PHY_RXD2
}
N 50600 57600 48900 57600 4
{
T 49100 57600 5 10 1 1 0 0 1
netname=PHY_RXD3
}
N 50600 57400 48900 57400 4
{
T 49100 57400 5 10 1 1 0 0 1
netname=PHY_RX_CTL
}
N 47400 56200 50600 56200 4
N 50600 56000 48900 56000 4
{
T 49100 56000 5 10 1 1 0 0 1
netname=PHY_NSRESET
}
N 50600 55400 48900 55400 4
{
T 49100 55400 5 10 1 1 0 0 1
netname=PHY_MDC
}
N 50600 55200 48900 55200 4
{
T 49100 55200 5 10 1 1 0 0 1
netname=PHY_MDIO
}
N 50600 55000 48900 55000 4
{
T 49100 55000 5 10 1 1 0 0 1
netname=PHY_MDINT
}
N 56100 59300 59400 59300 4
N 59400 59300 59400 59700 4
N 59400 59700 62400 59700 4
N 56100 59100 59600 59100 4
N 59600 59100 59600 59500 4
N 59600 59500 62400 59500 4
N 56100 58900 60500 58900 4
N 60500 58900 60500 59100 4
N 60500 59100 62400 59100 4
N 56100 58700 60700 58700 4
N 60700 58700 60700 58900 4
N 60700 58900 62400 58900 4
N 56100 58500 62400 58500 4
N 56100 58300 62400 58300 4
N 56100 57900 60400 57900 4
N 60400 57900 60400 57700 4
N 60400 57700 62400 57700 4
N 56100 58100 60600 58100 4
N 60600 58100 60600 57900 4
N 60600 57900 62400 57900 4
N 52100 61300 50200 61300 4
{
T 50300 61300 5 10 1 1 0 0 1
netname=VCC_1.2V_PHY
}
N 52300 61300 52300 61700 4
N 52300 61700 50700 61700 4
{
T 50800 61700 5 10 1 1 0 0 1
netname=VCC_1.2V_PHY_ANALOG
}
N 52700 61300 56600 61300 4
{
T 55600 61300 5 10 1 1 0 0 1
netname=VCC_3.3V
}
C 52900 52600 1 0 0 gnd-1.sym
N 52900 52900 53100 52900 4
C 63800 55700 1 0 0 gnd-1.sym
C 63400 54600 1 0 0 gnd-1.sym
C 63700 54900 1 90 0 capacitor-1.sym
{
T 63000 55100 5 10 0 0 90 0 1
device=CAPACITOR
T 63200 55100 5 10 1 1 90 0 1
refdes=C169
T 62800 55100 5 10 0 0 90 0 1
symversion=0.1
T 64000 55000 5 10 1 1 90 0 1
value=NONE
T 63700 54900 5 10 0 1 0 0 1
footprint=0603.fp
}
N 63500 56000 63500 55800 4
N 64300 56000 65300 56000 4
{
T 64800 55800 5 10 1 1 0 0 1
netname=chassis_gnd
}
N 62400 57300 60400 57300 4
{
T 60500 57300 5 10 1 1 0 0 1
netname=VCC_3.3V
}
N 62000 57300 62000 56900 4
N 62000 56900 62400 56900 4
C 60400 56600 1 0 0 resistor-1.sym
{
T 60700 57000 5 10 0 0 0 0 1
device=RESISTOR
T 60600 56900 5 10 1 1 0 0 1
refdes=R51
T 60400 56600 5 10 1 1 0 0 1
value=220
T 60400 56600 5 10 0 1 0 0 1
footprint=0402.fp
}
C 60400 55900 1 0 0 resistor-1.sym
{
T 60700 56300 5 10 0 0 0 0 1
device=RESISTOR
T 60600 56200 5 10 1 1 0 0 1
refdes=R52
T 60400 55900 5 10 1 1 0 0 1
value=220
T 60400 55900 5 10 0 1 0 0 1
footprint=0402.fp
}
C 46500 56100 1 0 0 resistor-1.sym
{
T 46800 56500 5 10 0 0 0 0 1
device=RESISTOR
T 46700 56400 5 10 1 1 0 0 1
refdes=R53
T 46600 55900 5 10 1 1 0 0 1
value=15k
T 46500 56100 5 10 0 1 0 0 1
footprint=0402.fp
}
C 59100 47000 1 180 0 resistor-1.sym
{
T 58800 46600 5 10 0 0 180 0 1
device=RESISTOR
T 58600 47200 5 10 1 1 180 0 1
refdes=R54
T 59000 47200 5 10 1 1 180 0 1
value=2k
T 59100 47000 5 10 0 1 90 0 1
footprint=0402.fp
}
C 65600 49700 1 90 0 resistor-1.sym
{
T 65200 50000 5 10 0 0 90 0 1
device=RESISTOR
T 65300 49900 5 10 1 1 90 0 1
refdes=R55
T 65600 49700 5 10 0 1 0 0 1
footprint=0402.fp
T 65600 49700 5 10 1 1 0 0 1
value=2.26k
}
C 57500 50700 1 0 0 resistor-1.sym
{
T 57800 51100 5 10 0 0 0 0 1
device=RESISTOR
T 57700 51000 5 10 1 1 0 0 1
refdes=R56
T 58100 51000 5 10 1 1 0 0 1
value=2k
T 57500 50700 5 10 0 1 0 0 1
footprint=0402.fp
}
C 65600 50600 1 90 0 resistor-1.sym
{
T 65200 50900 5 10 0 0 90 0 1
device=RESISTOR
T 65300 50800 5 10 1 1 90 0 1
refdes=R57
T 65600 50600 5 10 0 1 0 0 1
footprint=0402.fp
T 65700 51000 5 10 1 1 0 0 1
value=NONE
}
C 56800 53000 1 90 0 resistor-1.sym
{
T 56400 53300 5 10 0 0 90 0 1
device=RESISTOR
T 56500 53200 5 10 1 1 90 0 1
refdes=R58
T 56800 53000 5 10 1 1 0 0 1
value=10k
T 56800 53000 5 10 0 1 0 0 1
footprint=0402.fp
}
N 62400 57100 61300 57100 4
N 61300 57100 61300 56700 4
N 62400 56700 61600 56700 4
N 61600 56700 61600 56000 4
N 61600 56000 61300 56000 4
N 59100 56700 60400 56700 4
N 60400 56000 59500 56000 4
C 56600 52700 1 0 0 gnd-1.sym
N 56100 53900 56700 53900 4
N 56100 56100 59100 56100 4
N 56100 55900 59500 55900 4
N 59100 56100 59100 56700 4
N 59500 55900 59500 56000 4
N 57300 55100 56100 55100 4
{
T 56500 55100 5 10 1 1 0 0 1
netname=reg_out
}
N 57300 55300 56100 55300 4
{
T 56600 55300 5 10 1 1 0 0 1
netname=reg_en
}
N 57300 56500 56100 56500 4
{
T 56700 56500 5 10 1 1 0 0 1
netname=oscen
}
N 57300 56700 56100 56700 4
{
T 56800 56700 5 10 1 1 0 0 1
netname=xtal2
}
N 57300 56900 56100 56900 4
{
T 56800 56900 5 10 1 1 0 0 1
netname=xtal1
}
N 57300 57300 56100 57300 4
{
T 56500 57300 5 10 1 1 0 0 1
netname=ref_rext
}
N 57300 57500 56100 57500 4
{
T 56600 57500 5 10 1 1 0 0 1
netname=ref_filt
}
N 48900 57000 50600 57000 4
{
T 49100 57000 5 10 1 1 0 0 1
netname=cmode0
}
N 48900 56800 50600 56800 4
{
T 49100 56800 5 10 1 1 0 0 1
netname=cmode1
}
N 48900 56600 50600 56600 4
{
T 49100 56600 5 10 1 1 0 0 1
netname=cmode2
}
N 48900 56400 50600 56400 4
{
T 49100 56400 5 10 1 1 0 0 1
netname=cmode3
}
N 48900 55800 50600 55800 4
{
T 49100 55800 5 10 1 1 0 0 1
netname=pllmode
}
N 57500 50800 56100 50800 4
{
T 56200 50800 5 10 1 1 0 0 1
netname=PHY_MDINT
}
N 58400 50800 60000 50800 4
{
T 59000 50800 5 10 1 1 0 0 1
netname=VCC_3.3V
}
C 57500 50100 1 0 0 resistor-1.sym
{
T 57800 50500 5 10 0 0 0 0 1
device=RESISTOR
T 57700 50400 5 10 1 1 0 0 1
refdes=R59
T 58100 50400 5 10 1 1 0 0 1
value=2k
T 57500 50100 5 10 0 1 0 0 1
footprint=0402.fp
}
N 57500 50200 56100 50200 4
{
T 56200 50200 5 10 1 1 0 0 1
netname=PHY_MDIO
}
N 58400 50200 60000 50200 4
{
T 59000 50200 5 10 1 1 0 0 1
netname=VCC_3.3V
}
N 65500 50600 63700 50600 4
{
T 63800 50600 5 10 1 1 0 0 1
netname=cmode0
}
N 65500 51500 66900 51500 4
{
T 66000 51600 5 10 1 1 0 0 1
netname=VCC_3.3V
}
C 65400 49400 1 0 0 gnd-1.sym
C 65600 47100 1 90 0 resistor-1.sym
{
T 65200 47400 5 10 0 0 90 0 1
device=RESISTOR
T 65300 47300 5 10 1 1 90 0 1
refdes=R60
T 65600 47100 5 10 0 1 0 0 1
footprint=0402.fp
T 65600 47100 5 10 1 1 0 0 1
value=4.02k
}
C 65600 48000 1 90 0 resistor-1.sym
{
T 65200 48300 5 10 0 0 90 0 1
device=RESISTOR
T 65300 48200 5 10 1 1 90 0 1
refdes=R61
T 65600 48000 5 10 0 1 0 0 1
footprint=0402.fp
T 65700 48400 5 10 1 1 0 0 1
value=NONE
}
N 65500 48000 63700 48000 4
{
T 63800 48000 5 10 1 1 0 0 1
netname=cmode2
}
N 65500 48900 66900 48900 4
{
T 66000 49000 5 10 1 1 0 0 1
netname=VCC_3.3V
}
C 65400 46800 1 0 0 gnd-1.sym
C 68600 49700 1 90 0 resistor-1.sym
{
T 68200 50000 5 10 0 0 90 0 1
device=RESISTOR
T 68300 49900 5 10 1 1 90 0 1
refdes=R62
T 68600 49700 5 10 0 1 0 0 1
footprint=0402.fp
T 68600 49700 5 10 1 1 0 0 1
value=0
}
C 68600 50600 1 90 0 resistor-1.sym
{
T 68200 50900 5 10 0 0 90 0 1
device=RESISTOR
T 68300 50800 5 10 1 1 90 0 1
refdes=R63
T 68600 50600 5 10 0 1 0 0 1
footprint=0402.fp
T 68700 51000 5 10 1 1 0 0 1
value=NONE
}
N 68500 50600 66700 50600 4
{
T 66800 50600 5 10 1 1 0 0 1
netname=cmode1
}
N 68500 51500 69900 51500 4
{
T 69000 51600 5 10 1 1 0 0 1
netname=VCC_3.3V
}
C 68400 49400 1 0 0 gnd-1.sym
C 68600 47100 1 90 0 resistor-1.sym
{
T 68200 47400 5 10 0 0 90 0 1
device=RESISTOR
T 68300 47300 5 10 1 1 90 0 1
refdes=R64
T 68600 47100 5 10 0 1 0 0 1
footprint=0402.fp
T 68600 47100 5 10 1 1 0 0 1
value=0
}
C 68600 48000 1 90 0 resistor-1.sym
{
T 68200 48300 5 10 0 0 90 0 1
device=RESISTOR
T 68300 48200 5 10 1 1 90 0 1
refdes=R65
T 68600 48000 5 10 0 1 0 0 1
footprint=0402.fp
T 68700 48400 5 10 1 1 0 0 1
value=NONE
}
N 68500 48000 66700 48000 4
{
T 66800 48000 5 10 1 1 0 0 1
netname=cmode3
}
N 68500 48900 69900 48900 4
{
T 69000 49000 5 10 1 1 0 0 1
netname=VCC_3.3V
}
C 68400 46800 1 0 0 gnd-1.sym
C 57500 49100 1 0 0 resistor-1.sym
{
T 57800 49500 5 10 0 0 0 0 1
device=RESISTOR
T 57700 49400 5 10 1 1 0 0 1
refdes=R66
T 58100 49400 5 10 1 1 0 0 1
value=10k
T 57500 49100 5 10 0 1 0 0 1
footprint=0402.fp
}
N 57500 49200 56100 49200 4
{
T 56200 49200 5 10 1 1 0 0 1
netname=reg_en
}
N 58400 49200 60000 49200 4
{
T 59000 49200 5 10 1 1 0 0 1
netname=VCC_3.3V
}
N 58200 46900 56700 46900 4
{
T 56900 46900 5 10 1 1 0 0 1
netname=ref_rext
}
C 59100 46400 1 180 0 capacitor-1.sym
{
T 58900 45700 5 10 0 0 180 0 1
device=CAPACITOR
T 58600 45900 5 10 1 1 180 0 1
refdes=C170
T 58900 45500 5 10 0 0 180 0 1
symversion=0.1
T 59100 45900 5 10 1 1 180 0 1
value=1 uF
T 59100 46400 5 10 0 1 90 0 1
footprint=0603.fp
}
N 58200 46200 56700 46200 4
{
T 56900 46200 5 10 1 1 0 0 1
netname=ref_filt
}
C 55200 46000 1 90 0 resistor-1.sym
{
T 54800 46300 5 10 0 0 90 0 1
device=RESISTOR
T 54900 46200 5 10 1 1 90 0 1
refdes=R67
T 55200 46000 5 10 1 1 0 0 1
value=10k
T 55200 46000 5 10 0 1 0 0 1
footprint=0402.fp
}
N 55100 46900 53600 46900 4
{
T 53800 46900 5 10 1 1 0 0 1
netname=pllmode
}
C 55000 45700 1 0 0 gnd-1.sym
C 47800 55300 1 90 0 capacitor-1.sym
{
T 47100 55500 5 10 0 0 90 0 1
device=CAPACITOR
T 47300 55500 5 10 1 1 90 0 1
refdes=C171
T 46900 55500 5 10 0 0 90 0 1
symversion=0.1
T 47800 55300 5 10 1 1 0 0 1
value=1 uF
T 47800 55300 5 10 0 1 0 0 1
footprint=0603.fp
}
C 47500 55000 1 0 0 gnd-1.sym
N 46500 56200 45000 56200 4
{
T 45100 56200 5 10 1 1 0 0 1
netname=PHY_NRESET
}
C 46500 49100 1 90 0 capacitor-1.sym
{
T 45800 49300 5 10 0 0 90 0 1
device=CAPACITOR
T 46000 49300 5 10 1 1 90 0 1
refdes=C172
T 45600 49300 5 10 0 0 90 0 1
symversion=0.1
T 46500 49100 5 10 1 1 0 0 1
value=1 nF
T 46500 49100 5 10 0 1 0 0 1
footprint=0402.fp
}
C 48400 50000 1 90 0 capacitor-1.sym
{
T 47700 50200 5 10 0 0 90 0 1
device=CAPACITOR
T 47900 50200 5 10 1 1 90 0 1
refdes=C173
T 47500 50200 5 10 0 0 90 0 1
symversion=0.1
T 48400 50000 5 10 1 1 0 0 1
value=10 uF
T 48400 50000 5 10 0 1 0 0 1
footprint=0805.fp
}
C 47100 50800 1 0 0 inductor-1.sym
{
T 47300 51300 5 10 0 0 0 0 1
device=INDUCTOR
T 47300 51100 5 10 1 1 0 0 1
refdes=L8
T 47300 51500 5 10 0 0 0 0 1
symversion=0.1
T 47100 50700 5 10 1 1 0 0 1
value=4.7 uH
T 47100 50800 5 10 0 1 0 0 1
footprint=1210.fp
}
C 44900 46000 1 90 0 resistor-1.sym
{
T 44500 46300 5 10 0 0 90 0 1
device=RESISTOR
T 44600 46200 5 10 1 1 90 0 1
refdes=R68
T 44900 46000 5 10 1 1 0 0 1
value=10k
T 44900 46000 5 10 0 1 0 0 1
footprint=0402.fp
}
C 46400 50000 1 90 0 resistor-1.sym
{
T 46000 50300 5 10 0 0 90 0 1
device=RESISTOR
T 46100 50200 5 10 1 1 90 0 1
refdes=R69
T 46400 50000 5 10 1 1 0 0 1
value=15
T 46400 50000 5 10 0 1 0 0 1
footprint=0402.fp
}
C 46200 48800 1 0 0 gnd-1.sym
C 49200 50000 1 90 0 capacitor-1.sym
{
T 48500 50200 5 10 0 0 90 0 1
device=CAPACITOR
T 48700 50200 5 10 1 1 90 0 1
refdes=C174
T 48300 50200 5 10 0 0 90 0 1
symversion=0.1
T 49200 50000 5 10 1 1 0 0 1
value=1 uF
T 49200 50000 5 10 0 1 0 0 1
footprint=0603.fp
}
C 51900 50000 1 90 0 capacitor-1.sym
{
T 51200 50200 5 10 0 0 90 0 1
device=CAPACITOR
T 51400 50200 5 10 1 1 90 0 1
refdes=C175
T 51000 50200 5 10 0 0 90 0 1
symversion=0.1
T 51900 50000 5 10 1 1 0 0 1
value=10 uF
T 51900 50000 5 10 0 1 0 0 1
footprint=0805.fp
}
C 50600 50800 1 0 0 inductor-1.sym
{
T 50800 51300 5 10 0 0 0 0 1
device=INDUCTOR
T 50800 51100 5 10 1 1 0 0 1
refdes=L9
T 50800 51500 5 10 0 0 0 0 1
symversion=0.1
T 50800 50700 5 10 1 1 0 0 1
value=FB
T 50600 50800 5 10 0 1 0 0 1
footprint=0603.fp
}
C 48100 49700 1 0 0 gnd-1.sym
C 48900 49700 1 0 0 gnd-1.sym
C 51600 49700 1 0 0 gnd-1.sym
N 44800 50900 47100 50900 4
{
T 44900 51000 5 10 1 1 0 0 1
netname=reg_out
}
N 48000 50900 50600 50900 4
{
T 48900 51000 5 10 1 1 0 0 1
netname=VCC_1.2V_PHY
}
N 51500 50900 54600 50900 4
{
T 53000 51000 5 10 1 1 0 0 1
netname=VCC_1.2V_PHY_ANALOG
}
C 49600 46800 1 0 0 crystal-1.sym
{
T 49800 47300 5 10 0 0 0 0 1
device=CRYSTAL
T 49800 47100 5 10 1 1 0 0 1
refdes=Y1
T 49800 47500 5 10 0 0 0 0 1
symversion=0.1
T 49600 46500 5 10 1 1 0 0 1
value=25 MHz
T 49600 46800 5 10 0 1 0 0 1
footprint=CTS_ATS.fp
}
C 51000 46000 1 90 0 capacitor-1.sym
{
T 50300 46200 5 10 0 0 90 0 1
device=CAPACITOR
T 50500 46200 5 10 1 1 90 0 1
refdes=C176
T 50100 46200 5 10 0 0 90 0 1
symversion=0.1
T 51000 46000 5 10 1 1 0 0 1
value=33 pF
T 51000 46000 5 10 0 1 0 0 1
footprint=0402.fp
}
C 49300 46000 1 90 0 capacitor-1.sym
{
T 48600 46200 5 10 0 0 90 0 1
device=CAPACITOR
T 48800 46200 5 10 1 1 90 0 1
refdes=C177
T 48400 46200 5 10 0 0 90 0 1
symversion=0.1
T 49300 46000 5 10 1 1 0 0 1
value=33 pF
T 49300 46000 5 10 0 1 0 0 1
footprint=0402.fp
}
C 49000 45700 1 0 0 gnd-1.sym
C 50700 45700 1 0 0 gnd-1.sym
N 49600 46900 48000 46900 4
{
T 48300 46900 5 10 1 1 0 0 1
netname=xtal1
}
N 50300 46900 51700 46900 4
{
T 51100 46900 5 10 1 1 0 0 1
netname=xtal2
}
N 44800 46900 46200 46900 4
{
T 45200 46900 5 10 1 1 0 0 1
netname=VCC_3.3V
}
N 44800 46000 44800 45800 4
N 44800 45800 43300 45800 4
{
T 43400 45800 5 10 1 1 0 0 1
netname=oscen
}
C 53100 50000 1 90 0 capacitor-1.sym
{
T 52400 50200 5 10 0 0 90 0 1
device=CAPACITOR
T 52600 50200 5 10 1 1 90 0 1
refdes=C178
T 52200 50200 5 10 0 0 90 0 1
symversion=0.1
T 53100 50000 5 10 1 1 0 0 1
value=0.1 uF
T 53100 50000 5 10 0 1 0 0 1
footprint=0402.fp
}
C 52800 49700 1 0 0 gnd-1.sym
C 46200 43100 1 90 0 capacitor-1.sym
{
T 45500 43300 5 10 0 0 90 0 1
device=CAPACITOR
T 45700 43300 5 10 1 1 90 0 1
refdes=C179
T 45300 43300 5 10 0 0 90 0 1
symversion=0.1
T 45800 42800 5 10 1 1 0 0 1
value=0.1 uF
T 46200 43100 5 10 0 1 0 0 1
footprint=0402.fp
}
C 47000 43100 1 90 0 capacitor-1.sym
{
T 46300 43300 5 10 0 0 90 0 1
device=CAPACITOR
T 46500 43300 5 10 1 1 90 0 1
refdes=C180
T 46100 43300 5 10 0 0 90 0 1
symversion=0.1
T 46600 42800 5 10 1 1 0 0 1
value=0.1 uF
T 47000 43100 5 10 0 1 0 0 1
footprint=0402.fp
}
C 47800 43100 1 90 0 capacitor-1.sym
{
T 47100 43300 5 10 0 0 90 0 1
device=CAPACITOR
T 47300 43300 5 10 1 1 90 0 1
refdes=C181
T 46900 43300 5 10 0 0 90 0 1
symversion=0.1
T 47200 42800 5 10 1 1 0 0 1
value=0.1 uF
T 47800 43100 5 10 0 1 0 0 1
footprint=0402.fp
}
C 52300 43100 1 90 0 capacitor-1.sym
{
T 51600 43300 5 10 0 0 90 0 1
device=CAPACITOR
T 51800 43300 5 10 1 1 90 0 1
refdes=C182
T 51400 43300 5 10 0 0 90 0 1
symversion=0.1
T 51900 42800 5 10 1 1 0 0 1
value=0.1 uF
T 52300 43100 5 10 0 1 0 0 1
footprint=0402.fp
}
C 53100 43100 1 90 0 capacitor-1.sym
{
T 52400 43300 5 10 0 0 90 0 1
device=CAPACITOR
T 52600 43300 5 10 1 1 90 0 1
refdes=C183
T 52200 43300 5 10 0 0 90 0 1
symversion=0.1
T 52700 42800 5 10 1 1 0 0 1
value=0.1 uF
T 53100 43100 5 10 0 1 0 0 1
footprint=0402.fp
}
C 53900 43100 1 90 0 capacitor-1.sym
{
T 53200 43300 5 10 0 0 90 0 1
device=CAPACITOR
T 53400 43300 5 10 1 1 90 0 1
refdes=C184
T 53000 43300 5 10 0 0 90 0 1
symversion=0.1
T 53500 42800 5 10 1 1 0 0 1
value=0.1 uF
T 53900 43100 5 10 0 1 0 0 1
footprint=0402.fp
}
C 54700 43100 1 90 0 capacitor-1.sym
{
T 54000 43300 5 10 0 0 90 0 1
device=CAPACITOR
T 54200 43300 5 10 1 1 90 0 1
refdes=C185
T 53800 43300 5 10 0 0 90 0 1
symversion=0.1
T 54300 42800 5 10 1 1 0 0 1
value=0.1 uF
T 54700 43100 5 10 0 1 0 0 1
footprint=0402.fp
}
C 56300 43100 1 90 0 capacitor-1.sym
{
T 55600 43300 5 10 0 0 90 0 1
device=CAPACITOR
T 55800 43300 5 10 1 1 90 0 1
refdes=C186
T 55400 43300 5 10 0 0 90 0 1
symversion=0.1
T 55900 42800 5 10 1 1 0 0 1
value=0.1 uF
T 56300 43100 5 10 0 1 0 0 1
footprint=0402.fp
}
C 55500 43100 1 90 0 capacitor-1.sym
{
T 54800 43300 5 10 0 0 90 0 1
device=CAPACITOR
T 55000 43300 5 10 1 1 90 0 1
refdes=C187
T 54600 43300 5 10 0 0 90 0 1
symversion=0.1
T 55100 42800 5 10 1 1 0 0 1
value=0.1 uF
T 55500 43100 5 10 0 1 0 0 1
footprint=0402.fp
}
C 57100 43100 1 90 0 capacitor-1.sym
{
T 56400 43300 5 10 0 0 90 0 1
device=CAPACITOR
T 56600 43300 5 10 1 1 90 0 1
refdes=C188
T 56200 43300 5 10 0 0 90 0 1
symversion=0.1
T 56700 42800 5 10 1 1 0 0 1
value=0.1 uF
T 57100 43100 5 10 0 1 0 0 1
footprint=0402.fp
}
C 57900 43100 1 90 0 capacitor-1.sym
{
T 57200 43300 5 10 0 0 90 0 1
device=CAPACITOR
T 57400 43300 5 10 1 1 90 0 1
refdes=C189
T 57000 43300 5 10 0 0 90 0 1
symversion=0.1
T 57500 42800 5 10 1 1 0 0 1
value=0.1 uF
T 57900 43100 5 10 0 1 0 0 1
footprint=0402.fp
}
C 58700 43100 1 90 0 capacitor-1.sym
{
T 58000 43300 5 10 0 0 90 0 1
device=CAPACITOR
T 58200 43300 5 10 1 1 90 0 1
refdes=C190
T 57800 43300 5 10 0 0 90 0 1
symversion=0.1
T 58300 42800 5 10 1 1 0 0 1
value=0.1 uF
T 58700 43100 5 10 0 1 0 0 1
footprint=0402.fp
}
C 60300 43100 1 90 0 capacitor-1.sym
{
T 59600 43300 5 10 0 0 90 0 1
device=CAPACITOR
T 59800 43300 5 10 1 1 90 0 1
refdes=C191
T 59400 43300 5 10 0 0 90 0 1
symversion=0.1
T 59700 42800 5 10 1 1 0 0 1
value=0.1 uF
T 60300 43100 5 10 0 1 0 0 1
footprint=0402.fp
}
C 59500 43100 1 90 0 capacitor-1.sym
{
T 58800 43300 5 10 0 0 90 0 1
device=CAPACITOR
T 59000 43300 5 10 1 1 90 0 1
refdes=C192
T 58600 43300 5 10 0 0 90 0 1
symversion=0.1
T 59100 42800 5 10 1 1 0 0 1
value=0.1 uF
T 59500 43100 5 10 0 1 0 0 1
footprint=0402.fp
}
N 44600 44000 47600 44000 4
{
T 44700 44100 5 10 1 1 0 0 1
netname=VCC_1.2V_PHY
}
N 46000 43100 47800 43100 4
N 49800 44000 60100 44000 4
{
T 50000 44100 5 10 1 1 0 0 1
netname=VCC_3.3V
}
N 50700 43100 60300 43100 4
C 47700 42800 1 0 0 gnd-1.sym
C 60200 42800 1 0 0 gnd-1.sym
C 50900 43100 1 90 0 capacitor-1.sym
{
T 50200 43300 5 10 0 0 90 0 1
device=CAPACITOR
T 50400 43300 5 10 1 1 90 0 1
refdes=C193
T 50000 43300 5 10 0 0 90 0 1
symversion=0.1
T 50500 42800 5 10 1 1 0 0 1
value=10 uF
T 50900 43100 5 10 0 0 0 0 1
footprint=0805.fp
}
N 59300 45900 59300 46900 4
C 59200 45600 1 0 0 gnd-1.sym
N 59100 46200 59300 46200 4
N 59100 46900 59300 46900 4
T 59900 46400 9 10 1 0 0 0 2
see design guide
for layout hint