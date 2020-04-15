
# OpenFDA

On  https://open.fda.gov/apis/downloads/ they mention
https://api.fda.gov/download.json as a a possible path to direct acceess of bulk data.

To be sure the json is well formed

```
curl -L https://api.fda.gov/download.json | jq . > download.json
```

From https://github.com/TomConlin/json2xpath using json2xpath.jq to explore.

```
json2xpath.jq download.json | sort -u | sed 's~/~|.~g' > download.jqpath
```



```
grep animal download.jqpath
.|.results|.animalandveterinary
.|.results|.animalandveterinary|.event
.|.results|.animalandveterinary|.event|.export_date
.|.results|.animalandveterinary|.event|.partitions
.|.results|.animalandveterinary|.event|.partitions|.display_name
.|.results|.animalandveterinary|.event|.partitions|.file
.|.results|.animalandveterinary|.event|.partitions|.records
.|.results|.animalandveterinary|.event|.partitions|.size_mb
.|.results|.animalandveterinary|.event|.total_records
```

------

except for knowing which items are arrays to be iterated over these are the paths
you can look for square brackets in the json

 fgrep ": [" download.json
        "partitions": [
        "partitions": [
        "partitions": [

or run a query and see where it breaks


jq ".|.results|.animalandveterinary|.event|.partitions|.file" download.json
jq: error (at download.json:7964): Cannot index array with string "file"


where "Cannot index array with string "file"  tells us the item before "file"
must be and array which is indexed by inserting `.[]|`  between the array and its index


----

jq  ".|.results|.animalandveterinary|.event|.partitions|.[]|.file" download.json  tr -d '"' > fda_animal_event_url.list


head fda_animal_event_url.list
https://download.open.fda.gov/animalandveterinary/event/all_other/animalandveterinary-event-0001-of-0001.json.zip
https://download.open.fda.gov/animalandveterinary/event/1987q1/animalandveterinary-event-0001-of-0001.json.zip
https://download.open.fda.gov/animalandveterinary/event/1987q2/animalandveterinary-event-0001-of-0001.json.zip
https://download.open.fda.gov/animalandveterinary/event/1987q3/animalandveterinary-event-0001-of-0001.json.zip
https://download.open.fda.gov/animalandveterinary/event/1987q4/animalandveterinary-event-0001-of-0001.json.zip
https://download.open.fda.gov/animalandveterinary/event/1988q1/animalandveterinary-event-0001-of-0001.json.zip
https://download.open.fda.gov/animalandveterinary/event/1988q2/animalandveterinary-event-0001-of-0001.json.zip
https://download.open.fda.gov/animalandveterinary/event/1988q3/animalandveterinary-event-0001-of-0001.json.zip
https://download.open.fda.gov/animalandveterinary/event/1988q4/animalandveterinary-event-0001-of-0001.json.zip
https://download.open.fda.gov/animalandveterinary/event/1989q1/animalandveterinary-event-0001-of-0001.json.zip




which can now be fetched.

---


for field descriptions I came across

https://open.fda.gov/fields/animalandveterinaryevent.yaml

