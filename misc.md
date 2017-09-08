# ppj = Pretty Printer for JSON

One-time setup:

```bash
sudo apt-get install openjdk-8-jdk-headless python-pip
sudo pip install colout
echo "alias ppj='python -m json.tool | native2ascii -encoding UTF-8 -reverse | colout -t json'" >> ~/.bash_aliases
source ~/.bash_aliases
```

Usage:

```bash
json-generating-program | ppj
```

Sources:

- http://stackoverflow.com/a/1920585
- https://stackoverflow.com/questions/352098/how-can-i-pretty-print-json#comment17494666_1920585
- http://stackoverflow.com/a/8872702
- https://stackoverflow.com/questions/352098/how-can-i-pretty-print-json#comment25596405_1920585