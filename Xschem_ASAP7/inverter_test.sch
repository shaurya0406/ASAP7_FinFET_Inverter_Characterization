v {xschem version=3.4.6RC file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 540 270 540 290 {
lab=vdd}
C {inverter.sym} 540 360 0 0 {name=x1}
C {devices/vsource.sym} 470 510 0 0 {name=vdd value=0.7 }
C {devices/vsource.sym} 560 510 0 0 {name=vin value="PULSE(0 0.7 0p 10p 10p 20p 60p 2)" }
C {devices/gnd.sym} 540 430 0 0 {name=l1 lab=GND}
C {devices/gnd.sym} 560 540 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} 470 540 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} 470 480 0 0 {name=p1 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 560 480 0 0 {name=p2 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 460 360 0 0 {name=p3 sig_type=std_logic lab=vin}
C {devices/lab_pin.sym} 540 270 0 0 {name=p4 sig_type=std_logic lab=vdd}
C {devices/lab_pin.sym} 660 360 2 0 {name=p5 sig_type=std_logic lab=vout}
C {devices/code_shown.sym} 750 260 0 0 {name=s1 only_toplevel=false value="

.control
run
set filetype=ascii
set appendwrite

echo \\"WPfet,WNfet,Vm,Id,Gain,NMH,NML,Gm,tpd,tRise,tFall,Fsw,Power,Rout\\" > results.csv
let wpfet = 6
foreach wpfet 14 13 12 11 10 9 8 7 6 5 4 3 2
	foreach wnfet 14 13 12 11 10 9 8 7 6 5 4 3 2
		alter n.x1.xpfet1.npmos_finfet nfin = $wpfet
      		alter n.x1.xnfet1.nnmos_finfet nfin = $wnfet
		show n.x1.xpfet1.npmos_finfet : nfin
      		show n.x1.xnfet1.nnmos_finfet : nfin
		
		dc vin 0 0.7 1m

		set brushwidth 3

		setplot dc
		*plot vin vout
		meas dc vm when vin=vout
		
		if $&dc.vm > 0.34
			if $&dc.vm < 0.36
				
				let id = abs(vdd#branch)
				meas dc id_max MAX id
				print id_max

				let gm = real(deriv(id, vin))
				meas dc gm_max MAX gm
				print gm_max

				let rout = abs(real(deriv(vout, id)))
				meas dc rout_max MAX rout
				print rout_max
		
				let gain = abs(deriv(vout))
				meas dc gain_max MAX gain
				let gain_scaled = (gain >= 1)*0.7
				*plot gain_scaled vout
				meas dc vil find vin when gain_scaled=0.7 cross=1
				meas dc vih find vin when gain_scaled=0.7 cross=last
				let vol = 0
				let voh = 0.7
				let nmh = voh-vih
				let nml = vil-vol
				print nmh
				print nml

				tran 0.02p 125p
				setplot tran

				*plot vin vout
				meas tran tin_rise50 when vin=0.35 RISE=2
				meas tran tout_fall50 when vout=0.35 FALL=2
				meas tran tin_fall50 when vin=0.35 FALL=2
				meas tran tout_rise50 when vout=0.35 RISE=2
				meas tran tout_rise10 when vout=0.07 RISE=2
				meas tran tout_rise90 when vout=0.63 RISE=2
				meas tran tout_fall10 when vout=0.07 FALL=2
				meas tran tout_fall90 when vout=0.63 FALL=2

				let tpHL = tout_fall50-tin_rise50
				let tpLH = tout_rise50-tin_fall50
				let tpd = (tpHL+tpLH)/2
				let tr = tout_rise90 - tout_rise10
				let tf = tout_fall10 - tout_fall90
				let fsw = 1/(tr+tf)
				let id_tran = vdd#branch
				*plot id*1000 vout
				meas tran id_integ integ id_tran from=60e-12 to=120e-12
				let power_int = id_integ*0.7
				let power = abs(power_int/60)

				print tpHL
				print tpLH
				print tpd
				print tr
				print tf
				print fsw
				print power
				

				echo \\"$wpfet,$wnfet,$&dc.vm,$&dc.id_max,$&dc.gain_max,$&dc.nmh,$&dc.nml,$&dc.gm_max,$&tran.tpd,$&tran.tr,$&tran.tf,$&tran.fsw,$&tran.power,$&dc.rout_max\\" >> results.csv
			end
		end
   	end
	*$&wpfet = $&wpfet-1
end


.endc
.save all
.end
"}
C {devices/title.sym} 490 790 0 0 {name=l4 author="Shaurya Chandra"}
