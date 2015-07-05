#!/bin/bash
#
#3> <> a conversion:ConversionTrigger; # Could also be conversion:Idempotent;
#3>    foaf:name    "convert.sh";
#3>    rdfs:seeAlso <https://github.com/timrdf/csv2rdf4lod-automation/wiki/Triggers#wiki-3-computation-triggers>;
#3> .
#

if [[ "$1" == 'clean' ]]; then
   rm automatic/dblp.xml.ttl
   exit
fi

echo automatic/dblp.xml.ttl
if [[ ! -e automatic/dblp.xml.ttl ]]; then
   saxon.sh ../../src/grddl.xsl xml ttl automatic/dblp.xml > automatic/dblp.xml.ttl
fi
