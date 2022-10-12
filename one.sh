clear

sleep 0.5

tput setaf 6; cat << "EOF"

    ============================================================================================================

                             __        __   _                            _____
                             \ \      / /__| | ___ ___  _ __ ___   ___  |_   _|__
                              \ \ /\ / / _ \ |/ __/ _ \| '_ ` _ \ / _ \   | |/ _ \
                               \ V  V /  __/ | (_| (_) | | | | | |  __/   | | (_) |
                                \_/\_/ \___|_|\___\___/|_| |_| |_|\___|   |_|\___/

                               __        __            _ ____  _
                               \ \      / /__  _ __ __| | __ )| | ___  ___ ___
                                \ \ /\ / / _ \| '__/ _` |  _ \| |/ _ \/ __/ __|
                                 \ V  V / (_) | | | (_| | |_) | |  __/\__ \__ \
                                  \_/\_/ \___/|_|  \__,_|____/|_|\___||___/___/


    ============================================================================================================
                                           Created by: Louie Chillingworth
EOF
tput sgr0

sleep 3

clear

# Checking If Compatible 

GOOD='\033[42m'
BAD='\033[41m'
NC='\033[0m' # No Color

clear

echo -e "Checking site compatibility...\n"

VERSION=$(grep "required_php_version =" wp-includes/version.php | awk '{print $3}' | sed "s/'//g" | sed "s/;//g")
PHP='5.6'


sleep 1

# CHECKING PHP VERSION

if [[ "$VERSION" < "$PHP" ]];
    then
      echo -e "${BAD} ❌ - PHP Version Out of Date ($VERSION) ${NC}"
      read -p "Press any key to exit"
      exit
      else
      echo -e  "${GOOD} ✔ - PHP Version OK ($VERSION) ${NC}"
      continue
fi

sleep 2

tput sgr0

clear


echo -e "Dumping Database...\n"


WPDBNAME=`cat wp-config.php | grep DB_NAME | cut -d \' -f 4`
WPDBUSER=`cat wp-config.php | grep DB_USER | cut -d \' -f 4`
WPDBPASS=`cat wp-config.php | grep DB_PASSWORD | cut -d \' -f 4`

mysqldump --no-tablespaces -u $WPDBUSER -p$WPDBPASS $WPDBNAME > $WPDBNAME.sql



sleep 0.5

echo -e "\n Database: $WPDBNAME.sql dumped successfully \n"

sleep 1

# sitename="USER INPUT"
read -p "What's the site name?: " sitename;

realsite=$( echo $sitename | tr '.' '-' )

sleep 2

currentDir=$(pwd)

currentIP=$(hostname -i)

echo -e "\e[92mYour WordBless Code: \e[42m rsync --progress -avz -e ssh root@"$currentIP":"$currentDir"/ /home/storm/sites/"$realsite"/public/ \e[39m\n"


read -p "Press enter to exit"

clear
