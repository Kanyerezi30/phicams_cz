#for i in $(cut -f2 -d"," allpresenceabs.csv  | sort -u); do grep -w $i allpresenceabs.csv | cut -f1 -d"," | sort -u > ${i}p.csv; done
comm -23 abc-3tc-dtgp.csv abc-3tc-lpvp.csv | sort -u > abc-3tc-dtgu.csv
comm -23 abc-3tc-dtgu.csv azt-3tc-dtgp.csv | sort -u > abc-3tc-dtgu2.csv
comm -23 abc-3tc-dtgu2.csv azt-3tc-lpvp.csv | sort -u > abc-3tc-dtgu3.csv
comm -23 abc-3tc-dtgu3.csv dtg-3tc-1p.csv | sort -u > abc-3tc-dtgu4.csv
comm -23 abc-3tc-dtgu4.csv dtg-etv-drv-rip.csv | sort -u > abc-3tc-dtgu5.csv
comm -23 abc-3tc-dtgu5.csv newly_diagnosedp.csv | sort -u > abc-3tc-dtgu6.csv
comm -23 abc-3tc-dtgu6.csv sero_exposedp.csv | sort -u > abc-3tc-dtgu7.csv
comm -23 abc-3tc-dtgu7.csv tdf-3tc-dtgp.csv | sort -u > abc-3tc-dtgu8.csv

comm -23 abc-3tc-lpvp.csv abc-3tc-dtgp.csv | sort -u > abc-3tc-lpvu.csv
comm -23 abc-3tc-lpvu.csv azt-3tc-dtgp.csv | sort -u > abc-3tc-lpvu2.csv
comm -23 abc-3tc-lpvu2.csv azt-3tc-lpvp.csv | sort -u > abc-3tc-lpvu3.csv
comm -23 abc-3tc-lpvu3.csv dtg-3tc-1p.csv | sort -u > abc-3tc-lpvu4.csv
comm -23 abc-3tc-lpvu4.csv dtg-etv-drv-rip.csv | sort -u > abc-3tc-lpvu5.csv
comm -23 abc-3tc-lpvu5.csv newly_diagnosedp.csv | sort -u > abc-3tc-lpvu6.csv
comm -23 abc-3tc-lpvu6.csv sero_exposedp.csv | sort -u > abc-3tc-lpvu7.csv
comm -23 abc-3tc-lpvu7.csv tdf-3tc-dtgp.csv | sort -u > abc-3tc-lpvu8.csv

comm -23 azt-3tc-dtgp.csv abc-3tc-dtgp.csv | sort -u > azt-3tc-dtgu.csv
comm -23 azt-3tc-dtgu.csv abc-3tc-lpvp.csv | sort -u > azt-3tc-dtgu2.csv
comm -23 azt-3tc-dtgu2.csv azt-3tc-lpvp.csv | sort -u > azt-3tc-dtgu3.csv
comm -23 azt-3tc-dtgu3.csv dtg-3tc-1p.csv | sort -u > azt-3tc-dtgu4.csv
comm -23 azt-3tc-dtgu4.csv dtg-etv-drv-rip.csv | sort -u > azt-3tc-dtgu5.csv
comm -23 azt-3tc-dtgu5.csv newly_diagnosedp.csv | sort -u > azt-3tc-dtgu6.csv
comm -23 azt-3tc-dtgu6.csv sero_exposedp.csv | sort -u > azt-3tc-dtgu7.csv
comm -23 azt-3tc-dtgu7.csv tdf-3tc-dtgp.csv | sort -u > azt-3tc-dtgu8.csv

comm -23 azt-3tc-lpvp.csv abc-3tc-dtgp.csv | sort -u > azt-3tc-lpvu.csv
comm -23 azt-3tc-lpvu.csv abc-3tc-lpvp.csv | sort -u > azt-3tc-lpvu2.csv
comm -23 azt-3tc-lpvu2.csv azt-3tc-dtgp.csv | sort -u > azt-3tc-lpvu3.csv
comm -23 azt-3tc-lpvu3.csv dtg-3tc-1p.csv | sort -u > azt-3tc-lpvu4.csv
comm -23 azt-3tc-lpvu4.csv dtg-etv-drv-rip.csv | sort -u > azt-3tc-lpvu5.csv
comm -23 azt-3tc-lpvu5.csv newly_diagnosedp.csv | sort -u > azt-3tc-lpvu6.csv
comm -23 azt-3tc-lpvu6.csv sero_exposedp.csv | sort -u > azt-3tc-lpvu7.csv
comm -23 azt-3tc-lpvu7.csv tdf-3tc-dtgp.csv | sort -u > azt-3tc-lpvu8.csv

comm -23 dtg-3tc-1p.csv abc-3tc-dtgp.csv | sort -u > dtg-3tc-1pu.csv
comm -23 dtg-3tc-1pu.csv abc-3tc-lpvp.csv | sort -u > dtg-3tc-1pu2.csv
comm -23 dtg-3tc-1pu2.csv azt-3tc-dtgp.csv | sort -u > dtg-3tc-1pu3.csv
comm -23 dtg-3tc-1pu3.csv azt-3tc-lpvp.csv | sort -u > dtg-3tc-1pu4.csv
comm -23 dtg-3tc-1pu4.csv dtg-etv-drv-rip.csv | sort -u > dtg-3tc-1pu5.csv
comm -23 dtg-3tc-1pu5.csv newly_diagnosedp.csv | sort -u > dtg-3tc-1pu6.csv
comm -23 dtg-3tc-1pu6.csv sero_exposedp.csv | sort -u > dtg-3tc-1pu7.csv
comm -23 dtg-3tc-1pu7.csv tdf-3tc-dtgp.csv | sort -u > dtg-3tc-1pu8.csv

comm -23 dtg-etv-drv-rip.csv abc-3tc-dtgp.csv | sort -u > dtg-etv-drv-ripu.csv
comm -23 dtg-etv-drv-ripu.csv abc-3tc-lpvp.csv | sort -u > dtg-etv-drv-ripu2.csv
comm -23 dtg-etv-drv-ripu2.csv azt-3tc-dtgp.csv | sort -u > dtg-etv-drv-ripu3.csv
comm -23 dtg-etv-drv-ripu3.csv azt-3tc-lpvp.csv | sort -u > dtg-etv-drv-ripu4.csv
comm -23 dtg-etv-drv-ripu4.csv dtg-3tc-1p.csv | sort -u > dtg-etv-drv-ripu5.csv
comm -23 dtg-etv-drv-ripu5.csv newly_diagnosedp.csv | sort -u > dtg-etv-drv-ripu6.csv
comm -23 dtg-etv-drv-ripu6.csv sero_exposedp.csv | sort -u > dtg-etv-drv-ripu7.csv
comm -23 dtg-etv-drv-ripu7.csv tdf-3tc-dtgp.csv | sort -u > dtg-etv-drv-ripu8.csv

comm -23 newly_diagnosedp.csv abc-3tc-dtgp.csv | sort -u > newly_diagnosedpu.csv
comm -23 newly_diagnosedpu.csv abc-3tc-lpvp.csv | sort -u > newly_diagnosedpu2.csv
comm -23 newly_diagnosedpu2.csv azt-3tc-dtgp.csv | sort -u > newly_diagnosedpu3.csv
comm -23 newly_diagnosedpu3.csv azt-3tc-lpvp.csv | sort -u > newly_diagnosedpu4.csv
comm -23 newly_diagnosedpu4.csv dtg-3tc-1p.csv | sort -u > newly_diagnosedpu5.csv
comm -23 newly_diagnosedpu5.csv dtg-etv-drv-rip.csv | sort -u > newly_diagnosedpu6.csv
comm -23 newly_diagnosedpu6.csv sero_exposedp.csv | sort -u > newly_diagnosedpu7.csv
comm -23 newly_diagnosedpu7.csv tdf-3tc-dtgp.csv | sort -u > newly_diagnosedpu8.csv

comm -23 sero_exposedp.csv abc-3tc-dtgp.csv | sort -u > sero_exposedpu.csv
comm -23 sero_exposedpu.csv abc-3tc-lpvp.csv | sort -u > sero_exposedpu2.csv
comm -23 sero_exposedpu2.csv azt-3tc-dtgp.csv | sort -u > sero_exposedpu3.csv
comm -23 sero_exposedpu3.csv azt-3tc-lpvp.csv | sort -u > sero_exposedpu4.csv
comm -23 sero_exposedpu4.csv dtg-3tc-1p.csv | sort -u > sero_exposedpu5.csv
comm -23 sero_exposedpu5.csv dtg-etv-drv-rip.csv | sort -u > sero_exposedpu6.csv
comm -23 sero_exposedpu6.csv newly_diagnosedp.csv | sort -u > sero_exposedpu7.csv
comm -23 sero_exposedpu7.csv tdf-3tc-dtgp.csv | sort -u > sero_exposedpu8.csv


### common to all
comm -12 abc-3tc-dtgp.csv abc-3tc-lpvp.csv | sort -u > comm1.csv
comm -12 comm1.csv azt-3tc-dtgp.csv | sort -u > comm2.csv
comm -23 comm2.csv azt-3tc-lpvp.csv | sort -u > comm3.csv
comm -23 comm3.csv dtg-3tc-1p.csv | sort -u > comm4.csv
comm -23 comm4.csv dtg-etv-drv-rip.csv | sort -u > comm5.csv
comm -23 comm5.csv newly_diagnosedp.csv | sort -u > comm6.csv
comm -23 comm6.csv sero_exposedp.csv | sort -u > comm7.csv
comm -23 comm7.csv tdf-3tc-dtgp.csv | sort -u > comm8.csv
