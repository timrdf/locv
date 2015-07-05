#!/bin/bash
#
#3> <> a conversion:PreparationTrigger; # Could also be conversion:Idempotent;
#3>    foaf:name "prepare.sh";
#3>    rdfs:seeAlso
#3>     <https://github.com/timrdf/csv2rdf4lod-automation/wiki/Automated-creation-of-a-new-Versioned-Dataset>,
#3>     <https://github.com/timrdf/csv2rdf4lod-automation/wiki/Triggers>,
#3>     <https://github.com/timrdf/csv2rdf4lod-automation/wiki/Conversion-trigger>,
#3>     <https://github.com/timrdf/csv2rdf4lod-automation/wiki/Conversion-cockpit>;
#3> .
#
# This script is responsible for processing files in source/ and storing their modified forms
# as files in the manual/ directory. These modified files should be ready for conversion.
# 
# This script is also responsible for constructing the conversion trigger
#   (e.g., with cr-create-conversion-trigger.sh -w manual/*.csv)
#
# When this script resides in a cr:directory-of-versions directory,
# (e.g. source/datahub-io/corpwatch/version)
# it is invoked by retrieve.sh (or cr-retrieve.sh).
#   (see https://github.com/timrdf/csv2rdf4lod-automation/wiki/Directory-Conventions)
#
# When this script is invoked, the conversion cockpit is the current working directory.
#

echo automatic/dblp.dtd
mkdir -p automatic && pushd automatic
    ln -sf ../source/dblp.uni-trier.de/xml/dblp.dtd .
popd

echo automatic/dblp.xml
if [[ ! -e automatic/dblp.xml ]]; then
   gunzip -c source/dblp.uni-trier.de/xml/dblp.xml.gz > automatic/dblp.xml
fi

mkdir -p ../../src && pushd ../../src

   # http://dblp.dagstuhl.de/faq/How+to+parse+dblp+xml.html
   #if [[ ! -e Xerces-J-bin.2.11.0.tar.gz ]]; then
   #   curl -O http://apache.osuosl.org//xerces/j/binaries/Xerces-J-bin.2.11.0.tar.gz
   #fi

   #if [[ ! -e xerces-2_11_0 ]]; then
   #   tar xzf Xerces-J-bin.2.11.0.tar.gz
   #fi

   ln -sf ../version/latest/source/dblp.uni-trier.de/db/about/simpleparser/*.java .
   javac -Xlint:unchecked *.java
   java -classpath . -mx900M -DentityExpansionLimit=1000000 Parser ../version/latest/automatic/dblp.xml > ../version/latest/automatic/out.txt
popd
