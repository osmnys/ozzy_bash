#!/bin/bash

# Verzeichnisse und Ausgabedatei
DIR1="/path/to/first/directory"
DIR2="/path/to/second/directory"
OUTPUT_FILE="comparison_output.txt"

# Datei leeren oder erstellen
> "$OUTPUT_FILE"

# Funktion zum Vergleichen von zwei Dateien und Schreiben der Unterschiede in die Ausgabedatei
compare_files() {
    local file1=$1
    local file2=$2
    local output_file=$3
    
    # Nummerierung der Zeilen in den Dateien und dann diff anwenden
    diff_output=$(diff -y --left-column <(cat -n "$file1") <(cat -n "$file2"))
    
    if [ -n "$diff_output" ]; then
        echo "Differences between $file1 and $file2:" >> "$output_file"
        echo "$diff_output" >> "$output_file"
        echo -e "\n================================================================================\n" >> "$output_file"
    fi
}

# Hauptskript
for file1 in "$DIR1"/*; do
    filename=$(basename "$file1")
    file2="$DIR2/$filename"
    
    if [ -f "$file2" ]; then
        compare_files "$file1" "$file2" "$OUTPUT_FILE"
    else
        echo "$filename does not exist in $DIR2" >> "$OUTPUT_FILE"
        echo -e "\n================================================================================\n" >> "$OUTPUT_FILE"
    fi
done

echo "Comparison complete. Check the output file: $OUTPUT_FILE"
