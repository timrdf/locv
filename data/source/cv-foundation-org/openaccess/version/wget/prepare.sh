#!/bin/bash
#
#3> @prefix doap:    <http://usefulinc.com/ns/doap#> .
#3> @prefix dcterms: <http://purl.org/dc/terms/> .
#3> @prefix rdfs:    <http://www.w3.org/2000/01/rdf-schema#> .
#3> 
#3> <> a conversion:RetrievalTrigger, doap:Project; # Could also be conversion:Idempotent;
#3>    dcterms:description 
#3>      "Script to retrieve and convert a new version of the dataset.";
#3>    rdfs:seeAlso 
#3>      <https://github.com/timrdf/csv2rdf4lod-automation/wiki/Automated-creation-of-a-new-Versioned-Dataset>,
#3>      <https://github.com/timrdf/csv2rdf4lod-automation/wiki/tic-turtle-in-comments>;
#3> .

mkdir -p automatic
for pdf in `find 'source/www.cv-foundation.org/openaccess' -mindepth 3 -maxdepth 3 -name *.pdf`; do

   echo $pdf
   dir=`dirname $pdf | sed 's/^source/automatic/'`
   base=`basename $pdf`
   base=${base/%pdf/txt}
   txt="$dir/$base"

   if [[ ! -e $txt ]]; then
      echo "    $dir"
      mkdir -p $dir 
      echo "    $txt" 
      pdftotext $pdf $txt
      justify.sh $pdf $txt 'http://dbpedia.org/resource/Pdftotext'
      echo
   fi
done
