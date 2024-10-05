v {xschem version=3.4.6RC file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 200 90 200 110 {
lab=vdd}
C {inverter.sym} 200 180 0 0 {name=x1}
C {devices/vsource.sym} 130 330 0 0 {name=vdd value=0.7 }
C {devices/gnd.sym} 200 250 0 0 {name=l1 lab=GND}
C {devices/gnd.sym} 130 360 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} 130 300 0 0 {name=p1 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 120 180 0 0 {name=p3 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 200 90 0 0 {name=p4 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 320 180 2 0 {name=p5 sig_type=std_logic lab=vout}
C {devices/code_shown.sym} 460 90 0 0 {name=s1 only_toplevel=false value="

.control
run
set filetype=ascii
set appendwrite

echo \\"WPfet,WNfet,Cgs\\" > results_cgs.csv

foreach wpfet 15 14 13 12 11 10 9 8 7 6 5 4 3 2
	foreach wnfet 15 14 13 12 11 10 9 8 7 6 5 4 3 2
		alter n.x1.xpfet1.npmos_finfet nfin = $wpfet
      		alter n.x1.xnfet1.nnmos_finfet nfin = $wnfet
		show n.x1.xpfet1.npmos_finfet : nfin
      		show n.x1.xnfet1.nnmos_finfet : nfin

		AC DEC 100 1e3 1e6
		setplot AC
		let igs = vac#branch
		let ygs = igs/0.7
		let imag_ygs = imag(ygs)
		let freq = 100e6
		let cgs = abs(imag_ygs/(2*pi*freq))
		meas ac cgs_max MAX cgs
		print cgs_max
		
		echo \\"$wpfet,$wnfet,$&cgs_max\\" >> results_cgs.csv
	end
end

.endc
.save all
.end
"
}
C {devices/vsource.sym} 320 330 0 0 {name=vac value="0.7 AC 1mv" }
C {devices/gnd.sym} 320 360 0 0 {name=l5 lab=GND}
C {devices/lab_pin.sym} 320 300 0 0 {name=p6 sig_type=std_logic lab=vin}
C {devices/title.sym} 270 750 0 0 {name=l2 author="Shaurya Chandra}
