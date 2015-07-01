#!/bin/bash
#
#3> <> a conversion:PublicationTrigger; # Could also be conversion:Idempotent;
#3>    foaf:name    "publish.sh";
#3>    rdfs:seeAlso <https://github.com/timrdf/csv2rdf4lod-automation/wiki/Triggers#wiki-4-publication-triggers>;
#3> .
#

cr-publish.sh `find 'source/www.cv-foundation.org/openaccess' -mindepth 3 -maxdepth 3 -name *.pdf` \
            automatic/www.cv-foundation.org/openaccess/content_cvpr_2014/papers/Redi_6_Seconds_of_2014_CVPR_paper.txt \
            automatic/www.cv-foundation.org/openaccess/content_cvpr_2014/papers/Redi_6_Seconds_of_2014_CVPR_paper.txt.prov.ttl
#              `find 'automatic/www.cv-foundation.org/openaccess' -name *.txt`      \
#              `find 'automatic/www.cv-foundation.org/openaccess' -name *.prov.ttl` \
              manual/c4o-example.ttl
