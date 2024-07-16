#!/bin/bash

# Define input file
input_file="allpresenceabs.csv"

# Check if input file exists
if [[ ! -f "$input_file" ]]; then
  echo "File not found!"
  exit 1
fi

# Temporary files
temp_all="all_pathogens.txt"
temp_common="common_pathogens.txt"
temp_sorted="sorted_pathogens.txt"

# Extract all pathogens for each drug regimen
awk -F, 'NR > 1 { print $2, $1 }' "$input_file" | sort -k1,1 -k2,2 > "$temp_all"

# Find unique pathogens for each drug regimen
awk '{
  if ($1 != last_drug) {
    if (NR > 1) {
      for (pathogen in pathogens) {
        printf("%s ", pathogen
      }
      print ""
      delete pathogens
    }
    last_drug = $1
    printf("%s: ", $1)
  }
  pathogens[$2] = 1
}
END {
  for (pathogen in pathogens) {
    printf("%s ", pathogen)
  }
  print ""
}' "$temp_all" > "$temp_sorted"

# Display unique pathogens for each drug regimen
echo "Unique pathogens for each drug regimen:"
cat "$temp_sorted"

# Find common pathogens across all drug regimens
awk '{ print $2 }' "$temp_all" | sort | uniq -c | awk '$1 == NR' > "$temp_common"

# Display common pathogens across all drug regimens
echo
echo "Common pathogens across all drug regimens:"
cat "$temp_common"

# Clean up temporary files
rm "$temp_all" "$temp_sorted" "$temp_common"

