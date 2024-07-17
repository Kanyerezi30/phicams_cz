#for i in $(cut -f2 -d"," normalpresabs.csv  | sort -u); do grep -w $i normalpresabs.csv | cut -f1 -d"," | sort -u > ${i}p.csv; done
comm -23 basophilsp.csv eosinophilsp.csv | sort -u > basophilsu.csv
comm -23 basophilsu.csv lymphocytesp.csv | sort -u > basophilsu2.csv
comm -23 basophilsu2.csv monocytesp.csv | sort -u > basophilsu3.csv
comm -23 basophilsu3.csv neutrophilsp.csv | sort -u > basophilsu4.csv

comm -23 eosinophilsp.csv basophilsp.csv | sort -u > eosinophilsu.csv
comm -23 eosinophilsu.csv lymphocytesp.csv | sort -u > eosinophilsu2.csv
comm -23 eosinophilsu2.csv monocytesp.csv | sort -u > eosinophilsu3.csv
comm -23 eosinophilsu3.csv neutrophilsp.csv | sort -u > eosinophilsu4.csv

comm -23 lymphocytesp.csv basophilsp.csv | sort -u > lymphocytesu.csv
comm -23 lymphocytesu.csv eosinophilsp.csv | sort -u > lymphocytesu2.csv
comm -23 lymphocytesu2.csv monocytesp.csv | sort -u > lymphocytesu3.csv
comm -23 lymphocytesu3.csv neutrophilsp.csv | sort -u > lymphocytesu4.csv

comm -23 monocytesp.csv basophilsp.csv | sort -u > monocytesu.csv
comm -23 monocytesu.csv eosinophilsp.csv | sort -u > monocytesu2.csv
comm -23 monocytesu2.csv lymphocytesp.csv | sort -u > monocytesu3.csv
comm -23 monocytesu3.csv neutrophilsp.csv | sort -u > monocytesu4.csv

comm -23 neutrophilsp.csv basophilsp.csv | sort -u > neutrophilsu.csv
comm -23 neutrophilsu.csv eosinophilsp.csv | sort -u > neutrophilsu2.csv
comm -23 neutrophilsu2.csv lymphocytesp.csv | sort -u > neutrophilsu3.csv
comm -23 neutrophilsu3.csv monocytesp.csv | sort -u > neutrophilsu4.csv

### common to all
comm -12 basophilsp.csv eosinophilsp.csv | sort -u > comm1.csv
comm -12 comm1.csv lymphocytesp.csv | sort -u > comm2.csv
comm -12 comm2.csv monocytesp.csv | sort -u > comm3.csv
comm -12 comm3.csv neutrophilsp.csv | sort -u > comm4.csv
#comm -12 abc-3tc-dtgp.csv abc-3tc-lpvp.csv | sort -u > comm1.csv
#comm -12 comm1.csv azt-3tc-dtgp.csv | sort -u > comm2.csv
#comm -23 comm2.csv azt-3tc-lpvp.csv | sort -u > comm3.csv
#comm -23 comm3.csv dtg-3tc-1p.csv | sort -u > comm4.csv
#comm -23 comm4.csv dtg-etv-drv-rip.csv | sort -u > comm5.csv
#comm -23 comm5.csv newly_diagnosedp.csv | sort -u > comm6.csv
#comm -23 comm6.csv sero_exposedp.csv | sort -u > comm7.csv
#comm -23 comm7.csv tdf-3tc-dtgp.csv | sort -u > comm8.csv
