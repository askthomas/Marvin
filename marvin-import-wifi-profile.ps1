# =====================================================
#  Marvin - Import XML WiFi Profiles 
#
# (C) Thomas Ljunggren
# 1.0 - First Version
# =====================================================

# Variables
$wifi_path = "C:\Users\ThomasLjunggren\OneDrive\Backup\wifi\"
$wifi_filter = "*.xml"
$wifiparam=$args[0]

# Get all filenames
$files = get-childitem $wifi_path -Filter $wifi_filter

# Loop thrue all files and import
ForEach ($filename in $files) {

    $file = $filename.FullName.ToString()
    netsh wlan add profile filename=$file user=all

}

$wifiparam