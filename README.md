# vagrant-elasticsearch

a vagrant box with elasticsearch tools installed.

uses the shakespeare dataset from the kibana tutorial, and optionally inserts/indexes
data from a twitter stream (requiring you to enter oauth credentials).


## dependencies

- [git](http://git-scm.com/)
- [vagrant](http://www.vagrantup.com/)


## installation

```bash
git clone git@github.com:skratchdot/vagrant-elasticsearch.git
cd vagrant-elasticsearch
git submodule update --init --recursive
vagrant up
```

### twitter river

#### install twitter river
1. create twitter.json:
```bash
cp ./shared/data/twitter.json.example ./shared/data/twitter.json
```
2. add your credentials to twitter.json. see [elasticsearch-twitter-river prerequisites](https://github.com/elasticsearch/elasticsearch-river-twitter#prerequisites)
3. now re-provision your vagrant box by running:
```bash
vagrant reload --provision
```
4. start/stop the river via: [http://192.168.33.10/twitter.html](http://192.168.33.10/twitter.html)


## urls after installation

| name | url |
|------|-----|
| main info (readme) | http://192.168.33.10 |
| elasticsearch | http://192.168.33.10:9200/ |
| elasticsearch-head | http://192.168.33.10:9200/_plugin/head/ |
| elasticsearch-kopf | http://192.168.33.10:9200/_plugin/kopf/ |
| elasticsearch-marvel | http://192.168.33.10:9200/_plugin/marvel/ |
| kibana | http://192.168.33.10:8080/ |
| twitter river [status / start / stop] | http://192.168.33.10/twitter.html |
| dashboard - shakespeare | http://192.168.33.10:8080/index.html#/dashboard/file/shakespeare.json |
| dashboard - twitter | http://192.168.33.10:8080/index.html#/dashboard/file/twitter.json |


## links

#### source code
- [vagrant-elasticsearch](https://github.com/skratchdot/vagrant-elasticsearch/)

#### installed
- [elasticsearch](http://www.elasticsearch.org)
- [elasticsearch-head](https://github.com/mobz/elasticsearch-head)
- [elasticsearch-kopf](https://github.com/lmenezes/elasticsearch-kopf)
- [elasticsearch-marvel](http://www.elasticsearch.org/overview/marvel/)
- [kibana](https://github.com/elasticsearch/kibana)

#### articles
- [realtime analytics tutorial](http://lbroudoux.wordpress.com/2013/04/30/real-time-analytics-with-elasticsearch-and-kibana3/)
- [kibana - 10 minute walkthrough](http://www.elasticsearch.org/guide/en/kibana/current/using-kibana-for-the-first-time.html)


## License

Copyright (c) 2014 [skratchdot](http://skratchdot.com/)  
Licensed under the MIT license.
