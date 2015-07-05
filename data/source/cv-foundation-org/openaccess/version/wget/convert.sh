#!/bin/bash
#
#3> <> a conversion:ConversionTrigger; # Could also be conversion:Idempotent;
#3>    foaf:name    "convert.sh";
#3>    rdfs:seeAlso <https://github.com/timrdf/csv2rdf4lod-automation/wiki/Triggers#wiki-3-computation-triggers>;
#3> .
#

for html in `find 'automatic/www.cv-foundation.org/openaccess' -mindepth 3 -maxdepth 3 -name *.html`; do
   ttl="$html.ttl"
   echo "$html => $ttl"
   python ../../src/scrape.py `cr-sdv.sh --attribute-value--` "$html" > "$ttl"
done
