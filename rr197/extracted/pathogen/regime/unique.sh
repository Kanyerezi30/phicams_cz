#!/bin/bash

# Define input file
input_file="allpresenceabs.csv"

# Check if input file exists
if [[ ! -f "$input_file" ]]; then
  echo "File not found!"
  exit 1
fi

# Temporary files for unique and common pathogens
temp_unique="unique_pathogens.txt"
temp_common="common_pathogens.txt"

# Extract unique pathogens for each drug regimen
awk -F, '
NR > 1 {
  drug_regimen[$2] = drug_regimen[$2] " " $1
}
END {
  for (drug in drug_regimen) {
    split(drug_regimen[drug], pathogens, " ")
    asort(pathogens)
    printf("%s: ", drug)
    for (i in pathogens) {
      if (pathogens[i] != "") printf("%s ", pathogens[i])
    }
    printf("\n")
  }
}' "$input_file" > "$temp_unique"

# Extract common pathogens across all drug regimens
awk -F, '
NR > 1 {
  drug_regimen[$2][$1]++
}
END {
  for (drug in drug_regimen) {
    for (pathogen in drug_regimen[drug]) {
      pathogen_count[pathogen]++
    }
  }
  for (pathogen in pathogen_count) {
    if (pathogen_count[pathogen] == length(drug_regimen)) {
      printf("%s\n", pathogen)
    }
  }
}' "$input_file" > "$temp_common"

# Display results
echo "Unique pathogens for each drug regimen:"
cat "$temp_unique"
echo
echo "Common pathogens across all drug regimens:"
cat "$temp_common"

# Clean up temporary files
rm "$temp_unique" "$temp_common"
