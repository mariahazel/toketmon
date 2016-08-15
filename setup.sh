path=$(pwd)

function getversion () {
echo "[+] Cek Versi"

VERSION=$(git ls-remote --tags https://github.com/jabbink/PokemonGoBot | grep -Po '[0-9]\.[0-9]\.[0-9]' | sort -V | tail -n 1)
    }
function downloadbot () {
getversion
echo "[+] Download Bot"

wget -O $path/config.properties https://raw.githubusercontent.com/jabbink/PokemonGoBot/master/config.properties.template
wget -O $path/pokemon.jar https://github.com/jabbink/PokemonGoBot/releases/download/v${VERSION}/PokemonGoBot-${VERSION}.jar
    }
	
function createcron () {
echo "[+] Create Cron"

croncmd="$path/run.sh"
cronjob="0 * * * * $croncmd"
( crontab -l | grep -v "$croncmd" ; echo "$cronjob" ) | crontab -
chmod +x run.sh
chmod +x pokemon.sh

    }
	
function install () {
echo "[+] Update Java"

sudo add-apt-repository ppa:webupd8team/java

sudo apt-get update -y
sudo apt-get install oracle-java8-installer -y 
sudo apt-get install screen -y 
downloadbot
createcron
    }
    
install