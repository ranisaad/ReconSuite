#!/bin/bash

# Reconsuite - Automated Subdomain Reconnaissance Script

# Get the target domain from the first argument
url="$1"

# Create the main directory for the target if it doesn't exist
if [ ! -d "$url" ]; then
    mkdir "$url"
fi

# Create a 'recon' subdirectory for recon data
if [ ! -d "$url/recon" ]; then
    mkdir "$url/recon"
fi

# Create a 'final' subdirectory for consolidated output
if [ ! -d "$url/recon/final" ]; then
    mkdir "$url/recon/final"
fi

# Run Sublist3r for subdomain enumeration and save the results
echo "[+] Enumerating subdomains with Sublist3r..."
sublist3r -d "$url" >> "$url/recon/Sublist3r.txt"
cat "$url/recon/Sublist3r.txt" >> "$url/recon/final/final.txt"

# Run Amass for additional subdomain discovery
echo "[+] Enumerating subdomains with Amass..."
amass enum -d "$url" >> "$url/recon/Amass.txt"
cat "$url/recon/Amass.txt" >> "$url/recon/final/final.txt"

# Run AssetFinder to find more subdomains
echo "[+] Enumerating subdomains with AssetFinder..."
assetfinder -subs-only "$url" >> "$url/recon/assetfinder.txt"
cat "$url/recon/assetfinder.txt" >> "$url/recon/final/final.txt"

# Deduplicate and sort the combined list of subdomains
echo "= = = = = = = = = = = = = = = = = = = = = = = ="
echo "Deleting duplications and sorting..."
sort "$url/recon/final/final.txt" | uniq > "$url/recon/final/temp.txt"
mv "$url/recon/final/temp.txt" "$url/recon/final/final.txt"

# Use httprobe to check which subdomains are alive and save the results
cat "$url/recon/final/final.txt" | httprobe | cut -d'/' -f3 | sort > "$url/recon/final/live_subdomains.txt"

# Use gowitness to take screenshots of all found subdomains
# Output is saved to a "screenshots" folder
gowitness file -f "$url/recon/final/final.txt" > /dev/null
mv screenshots "$url/recon/final/screenshots"

# Use Nmap to scan for open ports on live subdomains
echo "[+] Scanning open ports of live subdomains..."
nmap -iL "$url/recon/final/live_subdomains.txt" -oA "$url/recon/final/nmap_scan"

# End of script
