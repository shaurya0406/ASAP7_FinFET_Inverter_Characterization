v {xschem version=3.4.6RC file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 510 210 520 210 {
lab=vin}
N 510 210 510 330 {
lab=vin}
N 510 340 520 340 {
lab=vin}
N 560 240 560 300 {
lab=vout}
N 480 270 510 270 {
lab=vin}
N 560 270 590 270 {
lab=vout}
N 560 160 560 180 {
lab=vdd}
N 560 360 560 380 {
lab=gnd}
N 560 210 620 210 {
lab=vout}
N 620 210 620 250 {
lab=vout}
N 560 250 620 250 {
lab=vout}
N 560 370 620 370 {
lab=gnd}
N 560 300 560 310 {
lab=vout}
N 510 330 510 340 {
lab=vin}
N 560 340 620 340 {
lab=gnd}
N 620 340 620 370 {
lab=gnd}
C {asap_7nm_nfet.sym} 540 340 0 0 {name=nfet1 model=asap_7nm_nfet spiceprefix=X l=7e-009 nfin=13}
C {asap_7nm_pfet.sym} 540 210 0 0 {name=pfet1 model=asap_7nm_pfet spiceprefix=X l=7e-009 nfin=14}
C {devices/ipin.sym} 480 270 0 0 {name=p1 lab=vin}
C {devices/ipin.sym} 560 160 0 0 {name=p2 lab=vdd}
C {devices/ipin.sym} 560 380 0 0 {name=p4 lab=gnd}
C {devices/title.sym} 220 590 0 0 {name=l1 author="Shaurya Chandra"}
C {devices/opin.sym} 590 270 0 0 {name=p5 lab=vout}
