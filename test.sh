#!/bin/bash
#!/bin/bash

# Define options for the checklist
airports=(EGLL,EGKK,EGCC,EGBB,EGSS,EGPF,EGPH,EGPD,EGPK,EGHH,EGHI,EGNT,EGNX,EGGW,EGGD,EGCN,EGNM,EGNS,EGAA,EGBD)
  

# Calculate the height and width of the checklist window
height=$(( ${#airports[@]} / 2 )) # Divide by 2 to account for descriptions
width=60

# Show the checklist with custom formatting
selected=$(whiptail --title "Airports" --checklist \
    "Choose options:" $height $width $((height - 1)) \
    "${options[@]}" 3>&1 1>&2 2>&3)

# Display selected options
echo "Airports selected:"
for choice in $selected; do
    echo "- $choice"
done
