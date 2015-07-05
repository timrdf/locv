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

for pdf in `find 'source/www.cv-foundation.org/openaccess' -mindepth 3 -maxdepth 3 -name *.pdf`; do
   echo $pdf                      # source/www.cv-foundation.org/openaccess/content_cvpr_2014/papers/Redi_6_Seconds_of_2014_CVPR_paper.pdf
   dir=`dirname $pdf | sed 's/^source/automatic/'`
   base=`basename $pdf`

   txt="$dir/${base/%pdf/txt}"    # automatic/www.cv-foundation.org/openaccess/content_cvpr_2014/papers/Redi_6_Seconds_of_2014_CVPR_paper.txt
   if [[ ! -e $txt ]]; then
      echo "    $dir"
      mkdir -p $dir 
      echo "    $txt" 
      pdftotext $pdf $txt
      justify.sh $pdf $txt 'http://dbpedia.org/resource/Pdftotext'
      echo
   fi

   htm=${pdf/\/papers\//\/html\/} # source/www.cv-foundation.org/openaccess/content_cvpr_2014/html/Redi_6_Seconds_of_2014_CVPR_paper.html
   htm=${htm/%pdf/html}
   dir=`dirname $htm | sed 's/^source/automatic/'`
   base=`basename $htm`
   tidy="$dir/$base"
   if [[ -e "$htm" && ! -e "$tidy" ]]; then
      echo "    $dir"
      mkdir -p $dir 
      echo "    $tidy" 
      tidy.sh "$htm" > "$tidy"
      echo
   fi
done
