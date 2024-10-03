v {xschem version=3.4.6RC file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 280 -160 350 -160 {
lab=GND}
N 350 -160 350 -130 {
lab=GND}
N 350 -130 350 -120 {
lab=GND}
N 280 -230 280 -190 {
lab=vds}
N 280 -130 280 -100 {
lab=GND}
N 280 -120 350 -120 {
lab=GND}
C {asap_7nm_nfet.sym} 260 -160 0 0 {name=nfet1 model=asap_7nm_nfet spiceprefix=X l=7e-009 nfin=14}
C {devices/lab_pin.sym} 280 -230 0 0 {name=p1 sig_type=std_logic lab=vds

}
C {devices/gnd.sym} 280 -100 0 0 {name=l1 lab=GND}
C {devices/lab_pin.sym} 240 -160 0 0 {name=p2 sig_type=std_logic lab=vgs



}
C {devices/vsource.sym} 50 -150 0 0 {name=Vgs value=0 savecurrent=false}
C {devices/lab_pin.sym} 50 -180 0 0 {name=p3 sig_type=std_logic lab=vgs



}
C {devices/gnd.sym} 50 -120 0 0 {name=l2 lab=GND}
C {devices/vsource.sym} 140 -150 0 0 {name=Vds value=0 savecurrent=false}
C {devices/gnd.sym} 140 -120 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} 140 -180 0 0 {name=p4 sig_type=std_logic lab=vds

}
C {devices/code_shown.sym} 400 -260 0 0 {name=s1 only_toplevel=false value="
.dc Vds 0 0.7 1m Vgs 0 0.7 0.2
.control
run
set xbrushwidth=3
plot -vds#branch
.endc
.save all
.end
"}
