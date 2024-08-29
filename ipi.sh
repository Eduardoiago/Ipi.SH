#!/bin/bash

# IP Information
# Author:           Eduardo Iago
# API:              ipgeolocation.io
# Shell script para exibir informações de IPv4 e IPv6.

show_help() {
    echo
    echo "    8 8888 8  8888888888o   8 8888 8"
    echo "    8 8888 8  8888      88  8 8888 8"
    echo "    8 8888 8  8888      88  8 8888 8"
    echo "    8 7411 8  8888     ,88  8 2811 8"
    echo "    8 0942 8  8888.   ,88'  8 9143 8"
    echo "    8 0468 8  888888888P'   8 1268 8"
    echo "    8 9103 8  8888          8 6106 8"
    echo "    8 2473 8  8888          8 3419 8"
    echo "    8 1620 8  8888          8 2697 8"
    echo "    8 9007 8  8888          8 0035 8"
    echo
    echo "    IP Information | Version 1.0.0"
    echo "        Created by Eduardo Iago"
    echo
    echo " Usage: [-i IP_ADDRESS] [-h]"
    echo
    echo  "  -i IP_ADDRESS      Specify the IPv4 or IPv6 address to lookup"
    echo  "  -h                 Show this help message"
}
# Variáveis para armazenar os parâmetros
ip=""
apiKEY="" # API Key
# Processa os parâmetros usando getopts
while getopts ":i:h" opt; do
    case ${opt} in
        i )
            ip=$OPTARG
            ;;
        h )
            show_help
            exit 0
            ;;
        \? )
            echo "Invalid option: -$OPTARG" 1>&2
            show_help
            exit 1
            ;;
        : )
            echo "Invalid option: -$OPTARG requires an argument" 1>&2
            show_help
            exit 1
            ;;
    esac
done
# Verifica se um IP foi fornecido
if [ -z "$ip" ]; then
    echo "Error: IP address is required"
    show_help
    exit 1
fi
# Faz uma solicitação à API para obter informações sobre o IP
response=$(curl -s "https://api.ipgeolocation.io/ipgeo?apiKey=$apiKEY&ip=$ip")
# Verifica no response da API se a resposta contém um erro
if echo "$response" | grep -q "error"; then
    echo "Unable to fetch information for the given IP address."
    exit 1
fi
# Extrai e exibe as informações do IP
ip=$(echo "$response" | jq -r '.ip')
hostname=$(echo "$response" | jq -r '.hostname')
continent_name=$(echo "$response" | jq -r '.continent_name')
country_code3=$(echo "$response" | jq -r '.country_code3')
country_name=$(echo "$response" | jq -r '.country_name')
state_prov=$(echo "$response" | jq -r '.state_prov')
city=$(echo "$response" | jq -r '.city')
zipcode=$(echo "$response" | jq -r '.zipcode')
latitude=$(echo "$response" | jq -r '.latitude')
longitude=$(echo "$response" | jq -r '.longitude')
calling_code=$(echo "$response" | jq -r '.calling_code')
country_tld=$(echo "$response" | jq -r '.country_tld')
languages=$(echo "$response" | jq -r '.languages')
country_flag=$(echo "$response" | jq -r '.country_flag')
isp=$(echo "$response" | jq -r '.isp')
organization=$(echo "$response" | jq -r '.organization')
currency_c=$(echo "$response" | jq -r '.currency.code')
currency_n=$(echo "$response" | jq -r '.currency.name')
currency_s=$(echo "$response" | jq -r '.currency.symbol')
time_zone=$(echo "$response" | jq -r '.time_zone.name')
time_zone_offset=$(echo "$response" | jq -r '.time_zone.offset')
time_zone_current_time=$(echo "$response" | jq -r '.time_zone.current_time')
# Informações do IP
echo "========================================================="
echo "IP:                 $ip"
echo "========================================================="
echo "Hostname:           $hostname"
echo "Continent Name:     $continent_name"
echo "Country Code:       $country_code3"
echo "Country Name:       $country_name"
echo "State/Province:     $state_prov"
echo "Time Zone:          $time_zone"
echo "City:               $city"
echo "Zip Code:           $zipcode"
echo "Latitude:           $latitude"
echo "Longitude:          $longitude"
echo "Calling Code:       $calling_code"
echo "Country TLD:        $country_tld"
echo "Languages:          $languages"
echo "ISP:                $isp"
echo "Organization:       $organization"
echo "Currency Code:      $currency_c"
echo "Currency Name:      $currency_n"
echo "Currency Symbol:    $currency_s"
echo "Time Zone Offset:   $time_zone_offset"
echo "Current Time:       $time_zone_current_time"
echo "========================================================="