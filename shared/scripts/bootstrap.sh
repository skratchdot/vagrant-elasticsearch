# config values
ES_DEB="elasticsearch-1.1.0.deb"
ES_URL="https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_DEB"

# superuser from elasticsearch directory
sudo su
cd /vagrant/shared/elasticsearch

# update box
apt-get update

# install dependencies
apt-get install -y curl
apt-get install -y unzip
apt-get install -y openjdk-7-jre-headless -y
apt-get install -y nginx

# start nginx on startup
update-rc.d nginx defaults
/etc/init.d/nginx start

# copy nginx.conf
cp /vagrant/shared/data/nginx.conf /etc/nginx/;
nginx -s reload;

# Download and install elastic search
# Check http://www.elasticsearch.org/download/ for latest version of ElasticSearch and replace wget link below
if [ ! -f "$ES_DEB" ]; then
    wget "$ES_URL"
fi
if [ ! -f /usr/share/elasticsearch/bin/elasticsearch ]; then
    dpkg -i "$ES_DEB"
fi

# setup elasticsearch as a service
# http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/setup-service.html
update-rc.d elasticsearch defaults 95 10
/etc/init.d/elasticsearch start

# install some elasticsearch plugins
/usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-river-twitter/2.0.0
/usr/share/elasticsearch/bin/plugin -install elasticsearch/marvel/latest
/usr/share/elasticsearch/bin/plugin -install mobz/elasticsearch-head
/usr/share/elasticsearch/bin/plugin -install lmenezes/elasticsearch-kopf
#/usr/share/elasticsearch/bin/plugin -install derryx/elasticsearch-changes-plugin

# setup twitter dashboard in kibana
cp /vagrant/shared/data/twitter-dashboard.json /vagrant/shared/kibana/src/app/dashboards/twitter.json

# setup shakespeare dashboard in kibana
cp /vagrant/shared/data/shakespeare-dashboard.json /vagrant/shared/kibana/src/app/dashboards/shakespeare.json

# create shakespeare index
http_code=$(curl --write-out "%{http_code}\n" --silent -XHEAD http://localhost:9200/shakespeare)
if [ "$http_code" -eq "404" ]; then
    curl -XPUT http://localhost:9200/shakespeare --data-binary @/vagrant/shared/data/shakespeare-index.json
fi

# get remote shakespeare data if we haven't already
if [ ! -f /vagrant/shared/data/shakespeare-data.json ]; then
    curl -o /vagrant/shared/data/shakespeare-data.json https://raw.githubusercontent.com/elasticsearch/docs/9fc666a0ea3fa2a2e1c889302b84caadc27c2223/html/en/kibana/current/snippets/shakespeare.json
fi

# create shakespeare data
http_code=$(curl --write-out "%{http_code}\n" --silent -XHEAD http://localhost:9200/shakespeare/_act/0)
if [ "$http_code" -eq "404" ]; then
    curl -XPUT http://localhost:9200/_bulk --data-binary @/vagrant/shared/data/shakespeare-data.json
fi

# restart elasticsearch after install plugins, etc
/etc/init.d/elasticsearch restart
