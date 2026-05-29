#!/bin/bash
# İsim SOYİSİM: Gizem Kızılay
# Öğrenci Numarası: 2420191015
# Sertifika Bağlantıları:
# 1. https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=L8dcNDq9oG
# 2. https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=7rptZjZ0WL
# 3. https://credsverse.com/credentials/6cb394a0-99ef-4a8a-b26f-5954ba0def69

LOG_FILE="report.log"

echo "Tarih: $(date --iso-8601=seconds)" > "$LOG_FILE"
echo "----------------------------------------" >> "$LOG_FILE"

echo "=== Windows Donanım Bilgileri ===" >> "$LOG_FILE"
echo "[İşlemci]" >> "$LOG_FILE"
wmic cpu get name >> "$LOG_FILE"
echo "[RAM (Kapasite)]" >> "$LOG_FILE"
wmic memorychip get capacity >> "$LOG_FILE"
echo "[Anakart]" >> "$LOG_FILE"
wmic baseboard get product >> "$LOG_FILE"
echo "[UUID]" >> "$LOG_FILE"
wmic csproduct get uuid >> "$LOG_FILE"
echo "[Disk (Marka, Model, Seri No, Kapasite)]" >> "$LOG_FILE"
wmic diskdrive get model,serialnumber,size >> "$LOG_FILE"
echo "[MAC Adresi]" >> "$LOG_FILE"
getmac >> "$LOG_FILE"

read -s -p "Lutfen kriptolama parolasini giriniz: " PAROLA
echo "" 

echo "$PAROLA" | gpg --batch --yes --passphrase-fd 0 --symmetric --cipher-algo AES256 -o report.log.gpg "$LOG_FILE"

if [ -f "report.log.gpg" ]; then
    rm "$LOG_FILE"
    echo "Sistem bilgileri basariyla alindi, sifrelendi ve orijinal log dosyasi imha edildi."
else
    echo "Sifreleme sirasinda bir hata olustu!"
fi

