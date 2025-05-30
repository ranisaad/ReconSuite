![ReconSuite Banner](https://raw.githubusercontent.com/ranisaad/ReconSuite/main/ReconSuite_Banner_1280x640.png)

# ReconSuite

A Bash script that automates subdomain enumeration, liveness checking, screenshot capturing, and port scanning. Useful for penetration testers and bug bounty hunters to quickly gather recon data on a target domain.

## 🚀 Features
- Subdomain enumeration using:
  - Sublist3r
  - Amass
  - AssetFinder
- Duplicate removal and sorting
- Live host detection with `httprobe`
- Screenshots with `gowitness`
- Port scanning with `nmap`

## 📦 Requirements
Make sure these tools are installed and available in your `$PATH`:
- [Sublist3r](https://github.com/aboul3la/Sublist3r)
- [Amass](https://github.com/owasp-amass/amass)
- [AssetFinder](https://github.com/tomnomnom/assetfinder)
- [httprobe](https://github.com/tomnomnom/httprobe)
- [gowitness](https://github.com/sensepost/gowitness)
- [nmap](https://nmap.org/)

## 🔧 Usage
```bash
chmod +x recon.sh
./recon.sh example.com
```

## 📁 Output Structure
```
example.com/
└── recon/
    ├── Sublist3r.txt
    ├── Amass.txt
    ├── assetfinder.txt
    └── final/
        ├── final.txt             # All discovered subdomains (deduplicated)
        ├── live_subdomains.txt  # Live hosts only
        ├── screenshots/         # Screenshots of web services
        └── nmap_scan.*          # Nmap output in all formats
```

## 📜 License
This project is licensed under the MIT License. See the `LICENSE` file for more information.

## 🙋 Author
Rani Saad
