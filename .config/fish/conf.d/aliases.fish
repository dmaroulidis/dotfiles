alias dotconf="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias docker-cf="sudo docker run -it --rm --name certbot -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" certbot/dns-cloudflare:latest certonly --dns-cloudflare --dns-cloudflare-credentials /etc/letsencrypt/cloudflare.ini"
alias co="ykman oath code"
