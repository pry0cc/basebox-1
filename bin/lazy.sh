
mkdir -p ~/work/$1
cd ~/work/$1

#finding subdomains
subfinder -d $1 | tee -a domains
assetfinder -subs-only $1 | tee -a domains
curl -s "https://crt.sh/\?q\=%25.$1\&output\=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | tee -a domains
cat ~/lists/jhaddix-all.txt | subgen -d "$1" |  zdns A  | jq '.[].answers?[]?' | jq -r 'select(.type == "A") | .name' | tee -a domains

#sorting/uniq
#cat subb.txt >> domains
sort -u domains > dom2;rm domains;mv dom2 domains

#account takeover scanning
subjack -w domains -t 100 -timeout 30 -ssl -c $GOPATH/src/github.com/haccer/subjack/fingerprints.json -v | tee -a takeover

#httprobing 
cat domains | httprobe | tee -a responsive
gf interestingsubs responsive > interestingsubs

#endpoint discovery
cat responsive | gau | tee -a all_urls
cat responsive | hakrawler --depth 3 --plain | tee -a all_urls

#extracting all responsive js files
grep "\.js$" all_urls | anti-burl | grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" | sort -u | tee -a javascript_files

#analyzing js files for secrets
mkdir js;cd js;~/bin/wgetlist ../javascript_files; cat * >> GF; gf sec GF > gf_sec; rm GF; > sec; cd ..

#grabing endpoints that include juicy parameters
gf redirect all_urls | anti-burl > redirects
gf idor all_urls | anti-burl > idor
gf rce all_urls | anti-burl > rce
gf lfi all_urls | anti-burl > lfi
gf xss all_urls | anti-burl > xss
gf xss all_urls | anti-burl > xss
gf ssrf all_urls | anti-burl > ssrf
