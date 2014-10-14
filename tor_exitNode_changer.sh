#!/bin/bash
#
# ====================================================================================
# Name          : Tor Browser {Exit Nodes} Changer
# Description   : Bash script to change Tor's {Exit Nodes} Country Codes
# Version       : 1.0
# Enviroment    : OS X / Unix
# Author        : gmo
# Proyect       : https://github.com/gmolop/Tor-ExitNode-changer
# Tested on     : OS X 10.9.5 / bash 3.2.51(1) / Tor Browser Bundle 3.6.5



# ====================================================================================
# Config vars

    lang=$(defaults read .GlobalPreferences AppleLanguages | tr -d [:space:] | cut -c2-3)
    DIR=$(cd $(dirname "$0"); pwd)
    scriptName=$(basename "$0")
    appName="TorBrowser"
    appPath="/Applications/TorBrowser.app"
    configFile="$appPath/Data/Tor/torrc"
    configParam="ExitNodes"
    NL='
    '

# ====================================================================================
# Locale Messages

    # More translations are welcome ;)
    # To check your system code, run "tor --lang"

    case $lang in
        es)
            msg_country_010="Ingresa un código de país: "
            msg_country_020="Debes poner algun país para hacer el cambio."
            msg_country_030="El código que has introducido no parece ser valido, o bien, no es soportado por Tor."

            msg_actions_010="Comprobando si Tor Browser se este ejecutando."
            msg_actions_020="Tor en ejecución, cerrando Tor..."
            msg_actions_030="Comprobado, Tor Browser no se esta ejecutando."
            msg_actions_040="Cambiando a PROXI de"
            msg_actions_050="Iniciando Tor con la nueva configuración..."
            msg_actions_060="Terminado!"
            msg_actions_070="Configuración exitNode eliminada!"
            msg_actions_080="La configuración exitNode no ha podido ser eliminada!\nPara eliminar manualmente, utiliza: tor --edit"

            msg_warning_010="Configuración encontrada, seguimos..."
            msg_warning_020="Condición no encontrada en el archivo de configuración."
            msg_warning_030="Se ha intentado añadir la condición, volvemos a comprobar..."
            msg_warning_040="La configuración esta activada."
            msg_warning_050="La configuración esta desactivada."
            msg_warning_060="2 letras para el codigo país en ISO3166: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2"
            msg_warning_070="Para el listado completo, utiliza: tor --list"
            ;;
        *)
            msg_country_010="Enter a country code: "
            msg_country_020="You must enter some country to make the switch."
            msg_country_030="The code you entered does not appear to be valid or it is not supported by Tor."

            msg_actions_010="Checking if Tor Browser is running."
            msg_actions_020="Tor is running, closing Tor Browser..."
            msg_actions_030="Checked, Tor Browser is not running."
            msg_actions_040="Changing to a PROXI from"
            msg_actions_050="Starting Tor with the new configuration..."
            msg_actions_060="Done!"
            msg_actions_070="exitNode settings removed!"
            msg_actions_080="exitNode settings can be removed!\nFor manually remove, use: tor --edit"

            msg_warning_010="Setup found, we can continue..."
            msg_warning_020="Condition not found in the configuration file."
            msg_warning_030="An attempt was made to add the condition, going back to verify..."
            msg_warning_040="The configuration is enabled."
            msg_warning_050="The configuration is disabled."
            msg_warning_060="2 letter ISO3166 country code: https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2"
            msg_warning_070="For full list, use: tor --list"
            ;;
    esac

# ====================================================================================
# Allowed Country codes

    country=(
        "ac:ASCENSION ISLAND"
        "af:AFGHANISTAN"
        "ax:ALAND"
        "al:ALBANIA"
        "dz:ALGERIA"
        "ad:ANDORRA"
        "ao:ANGOLA"
        "ai:ANGUILLA"
        "aq:ANTARCTICA"
        "ag:ANTIGUA AND BARBUDA"
        "ar:ARGENTINA REPUBLIC"
        "am:ARMENIA"
        "aw:ARUBA"
        "au:AUSTRALIA"
        "at:AUSTRIA"
        "az:AZERBAIJAN"
        "bs:BAHAMAS"
        "bh:BAHRAIN"
        "bd:BANGLADESH"
        "bb:BARBADOS"
        "by:BELARUS"
        "be:BELGIUM"
        "bz:BELIZE"
        "bj:BENIN"
        "bm:BERMUDA"
        "bt:BHUTAN"
        "bo:BOLIVIA"
        "ba:BOSNIA AND HERZEGOVINA"
        "bw:BOTSWANA"
        "bv:BOUVET ISLAND"
        "br:BRAZIL"
        "io:BRITISH INDIAN OCEAN TERR"
        "vg:BRITISH VIRGIN ISLANDS"
        "bn:BRUNEI DARUSSALAM"
        "bg:BULGARIA"
        "bf:BURKINA FASO"
        "bi:BURUNDI"
        "kh:CAMBODIA"
        "cm:CAMEROON"
        "ca:CANADA"
        "cv:CAPE VERDE"
        "ky:CAYMAN ISLANDS"
        "cf:CENTRAL AFRICAN REPUBLIC"
        "td:CHAD"
        "cl:CHILE"
        "cn:PEOPLE’S REPUBLIC OF CHINA"
        "cx:CHRISTMAS ISLANDS"
        "cc:COCOS ISLANDS"
        "co:COLOMBIA"
        "km:COMORAS"
        "cg:CONGO"
        "cd:CONGO (DEMOCRATIC REPUBLIC"
        "ck:COOK ISLANDS"
        "cr:COSTA RICA"
        "ci:COTE D IVOIRE"
        "hr:CROATIA"
        "cu:CUBA"
        "cy:CYPRUS"
        "cz:CZECH REPUBLIC"
        "dk:DENMARK"
        "dj:DJIBOUTI"
        "dm:DOMINICA"
        "do:DOMINICAN REPUBLIC"
        "tp:EAST TIMOR"
        "ec:ECUADOR"
        "eg:EGYPT"
        "sv:EL SALVADOR"
        "gq:EQUATORIAL GUINEA"
        "ee:ESTONIA"
        "et:ETHIOPIA"
        "fk:FALKLAND ISLANDS"
        "fo:FAROE ISLANDS"
        "fj:FIJI"
        "fi:FINLAND"
        "fr:FRANCE"
        "fx:FRANCE METROPOLITAN"
        "gf:FRENCH GUIANA"
        "pf:FRENCH POLYNESIA"
        "tf:FRENCH SOUTHERN TERRITORIES"
        "ga:GABON"
        "gm:GAMBIA"
        "ge:GEORGIA"
        "de:GERMANY"
        "gh:GHANA"
        "gi:GIBRALTER"
        "gr:GREECE"
        "gl:GREENLAND"
        "gd:GRENADA"
        "gp:GUADELOUPE"
        "gu:GUAM"
        "gt:GUATEMALA"
        "gn:GUINEA"
        "gw:GUINEA-BISSAU"
        "gy:GUYANA"
        "ht:HAITI"
        "hm:HEARD & MCDONALD ISLAND"
        "hn:HONDURAS"
        "hk:HONG KONG"
        "hu:HUNGARY"
        "is:ICELAND"
        "in:INDIA"
        "id:INDONESIA"
        "ir:IRAN, ISLAMIC REPUBLIC OF"
        "iq:IRAQ"
        "ie:IRELAND"
        "im:ISLE OF MAN"
        "il:ISRAEL"
        "it:ITALY"
        "jm:JAMAICA"
        "jp:JAPAN"
        "jo:JORDAN"
        "kz:KAZAKHSTAN"
        "ke:KENYA"
        "ki:KIRIBATI"
        "kp:KOREA, DEM. PEOPLES REP OF"
        "kr:KOREA, REPUBLIC OF"
        "kw:KUWAIT"
        "kg:KYRGYZSTAN"
        "la:LAO PEOPLE’S DEM. REPUBLIC"
        "lv:LATVIA"
        "lb:LEBANON"
        "ls:LESOTHO"
        "lr:LIBERIA"
        "ly:LIBYAN ARAB JAMAHIRIYA"
        "li:LIECHTENSTEIN"
        "lt:LITHUANIA"
        "lu:LUXEMBOURG"
        "mo:MACAO"
        "mk:MACEDONIA"
        "mg:MADAGASCAR"
        "mw:MALAWI"
        "my:MALAYSIA"
        "mv:MALDIVES"
        "ml:MALI"
        "mt:MALTA"
        "mh:MARSHALL ISLANDS"
        "mq:MARTINIQUE"
        "mr:MAURITANIA"
        "mu:MAURITIUS"
        "yt:MAYOTTE"
        "mx:MEXICO"
        "fm:MICRONESIA"
        "md:MOLDAVA REPUBLIC OF"
        "mc:MONACO"
        "mn:MONGOLIA"
        "me:MONTENEGRO"
        "ms:MONTSERRAT"
        "ma:MOROCCO"
        "mz:MOZAMBIQUE"
        "mm:MYANMAR"
        "na:NAMIBIA"
        "nr:NAURU"
        "np:NEPAL"
        "an:NETHERLANDS ANTILLES"
        "nl:NETHERLANDS, THE"
        "nc:NEW CALEDONIA"
        "nz:NEW ZEALAND"
        "ni:NICARAGUA"
        "ne:NIGER"
        "ng:NIGERIA"
        "nu:NIUE"
        "nf:NORFOLK ISLAND"
        "mp:NORTHERN MARIANA ISLANDS"
        "no:NORWAY"
        "om:OMAN"
        "pk:PAKISTAN"
        "pw:PALAU"
        "ps:PALESTINE"
        "pa:PANAMA"
        "pg:PAPUA NEW GUINEA"
        "py:PARAGUAY"
        "pe:PERU"
        "ph:PHILIPPINES (REPUBLIC OF THE"
        "pn:PITCAIRN"
        "pl:POLAND"
        "pt:PORTUGAL"
        "pr:PUERTO RICO"
        "qa:QATAR"
        "re:REUNION"
        "ro:ROMANIA"
        "ru:RUSSIAN FEDERATION"
        "rw:RWANDA"
        "ws:SAMOA"
        "sm:SAN MARINO"
        "st:SAO TOME/PRINCIPE"
        "sa:SAUDI ARABIA"
        "uk:SCOTLAND"
        "sn:SENEGAL"
        "rs:SERBIA"
        "sc:SEYCHELLES"
        "sl:SIERRA LEONE"
        "sg:SINGAPORE"
        "sk:SLOVAKIA"
        "si:SLOVENIA"
        "sb:SOLOMON ISLANDS"
        "so:SOMALIA"
        "as:SOMOA,GILBERT,ELLICE ISLANDS"
        "za:SOUTH AFRICA"
        "gs:SOUTH GEORGIA, SOUTH SANDWICH ISLANDS"
        "su:SOVIET UNION"
        "es:SPAIN"
        "lk:SRI LANKA"
        "sh:ST. HELENA"
        "kn:ST. KITTS AND NEVIS"
        "lc:ST. LUCIA"
        "pm:ST. PIERRE AND MIQUELON"
        "vc:ST. VINCENT & THE GRENADINES"
        "sd:SUDAN"
        "sr:SURINAME"
        "sj:SVALBARD AND JAN MAYEN"
        "sz:SWAZILAND"
        "se:SWEDEN"
        "ch:SWITZERLAND"
        "sy:SYRIAN ARAB REPUBLIC"
        "tw:TAIWAN"
        "tj:TAJIKISTAN"
        "tz:TANZANIA, UNITED REPUBLIC OF"
        "th:THAILAND"
        "tg:TOGO"
        "tk:TOKELAU"
        "to:TONGA"
        "tt:TRINIDAD AND TOBAGO"
        "tn:TUNISIA"
        "tr:TURKEY"
        "tm:TURKMENISTAN"
        "tc:TURKS AND CALCOS ISLANDS"
        "tv:TUVALU"
        "ug:UGANDA"
        "ua:UKRAINE"
        "ae:UNITED ARAB EMIRATES"
        "gb:UNITED KINGDOM (no new registrations"
        "uk:UNITED KINGDOM"
        "us:UNITED STATES"
        "um:UNITED STATES MINOR OUTL.IS"
        "uy:URUGUAY"
        "uz:UZBEKISTAN"
        "vu:VANUATU"
        "va:VATICAN CITY STATE"
        "ve:VENEZUELA"
        "vn:VIET NAM"
        "vi:VIRGIN ISLANDS (USA"
        "wf:WALLIS AND FUTUNA ISLANDS"
        "eh:WESTERN SAHARA"
        "ye:YEMEN"
        "zm:ZAMBIA"
        "zw:ZIMBABWE"
    )

# ====================================================================================
# functions

    f_check_if_in_array () {

        found="notFound"

        for iso in "${country[@]}" ; do

            KEY=${iso%%:*}
            VALUE=${iso#*:}

            if [ "$1" = "$KEY" ]; then

                found=$VALUE

            fi

        done

        echo $found

    }

    f_check_exitNode_string () {

        if egrep -wl "$configParam" "$configFile" 1>/dev/null; then

            retval=0

        else

            retval=1

        fi

        return $retval

    }

    f_add_exitNode_parameter () {

        if f_check_exitNode_string; then

            echo -e " ** $msg_warning_010"
            f_do_the_change

        else

            echo -e " ** $msg_warning_020"
            sed -i -e "1,1 s/^/$configParam {$ISO_uppercase}\\$NL/" $configFile
            echo -e " ** $msg_warning_030"
            f_add_exitNode_parameter

        fi

        exit

    }

    f_do_the_change () {

        echo -e " >> $msg_actions_010"

        if ps aux | grep "[T]orBrowser" > /dev/null; then

            echo -e " >> $msg_actions_020"
            kill `ps -ef | grep $appName | grep -v grep | awk '{print $2}'`

        else

            echo -e " >> $msg_actions_030"

        fi

        echo " >> $msg_actions_040: $NODECountry"
        sed -i -e "s/$configParam {.*.}/$configParam {$ISO_uppercase}/" $configFile
        echo -e " >> $msg_actions_050"
        open $appPath
        echo -e " >> $msg_actions_060"

        exit
    }

    f_show_country_list () {

        echo -e "\nUSE    => FOR COUNTRY\n---------------------"

        for iso in "${country[@]}" ; do

            KEY=${iso%%:*}
            VALUE=${iso#*:}
            printf "tor %s => %s\n" "$KEY" "$VALUE"

        done

        echo -e "---------------------\n"

    }

    f_toggle_status () {

        if [ ! "$1" = "enabled" ] && [ ! "$1" = "disabled" ] ; then

            echo "(e)nabled or (d)isabled? "

            while read -r -n 1 -s answer; do

                if [[ $answer = [EeDd] ]]; then

                    [[ $answer = [Ee] ]] && newStatus="enabled"
                    [[ $answer = [Dd] ]] && newStatus="disabled"
                    break

                fi

            done

        else

            newStatus=$1

        fi

        if f_check_exitNode_string; then

            echo -e " ** $msg_warning_010"

            if [ "$newStatus" = "enabled" ]; then

                sed -i -e "s/.*.$configParam {/$configParam {/" $configFile
                echo -e " ** $msg_warning_040"

            elif [ "$newStatus" = 'disabled' ]; then

                sed -i -e "s/.*.$configParam {/$configParam {/" $configFile
                sed -i -e "s/$configParam {/# $configParam {/" $configFile
                echo -e " ** $msg_warning_050"

                exit

            fi

        else

            echo -e " ** $msg_warning_020"

        fi

    }

    f_remove_exitNode_from_file () {

        if f_check_exitNode_string; then

            sed -i -e "/\(\.\*\)\{0,1\}$configParam/d" $configFile

            if f_check_exitNode_string; then

                echo -e " >> $msg_actions_080"

            else

                echo -e " >> $msg_actions_070"

            fi

        else

            echo -e " ** $msg_warning_020"

        fi

        exit

    }

# ====================================================================================
# Parameters

    if [ $# -eq 0 ]; then

        read -p " !! $msg_country_010" NODE

    elif [ "$1" = "--list" ]; then

        f_show_country_list
        exit

    elif [ "$1" = "--lang" ]; then

        echo "System language: $lang"
        exit

    elif [ "$1" = "--set" ]; then

        f_toggle_status $2
        exit

    elif [ "$1" = "--edit" ]; then

        vim $configFile
        exit

    elif [ "$1" = "--clean" ]; then

        f_remove_exitNode_from_file
        exit

    else

        NODE=$*

    fi

    if [ "$NODE" = "" ]; then

        echo -e " !! $msg_country_020\n ** $msg_warning_060"
        $DIR/$scriptName
        exit

    fi

# ====================================================================================
# normalize & check

    ISO_uppercase=$(echo $NODE | tr 'a-z' 'A-Z')
    ISO_lowercase=$(echo $NODE | tr 'A-Z' 'a-z')
    NODECountry=$(f_check_if_in_array $ISO_lowercase)

    if [ $NODECountry = "notFound" ]; then

        echo -e " !! $msg_country_030\n ** $msg_warning_070"
        exit

    fi

# ====================================================================================
# If we get here, looks good, go on!

    f_add_exitNode_parameter
