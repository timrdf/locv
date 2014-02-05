#3> <#> a <http://purl.org/twc/vocab/conversion/CSV2RDF4LOD_environment_variables> ;
#3>     rdfs:seeAlso 
#3>     <http://purl.org/twc/page/csv2rdf4lod/distributed_env_vars>,
#3>     <https://github.com/timrdf/csv2rdf4lod-automation/wiki/Script:-source-me.sh> .

source /home/locv/prizms/locv/data/source/csv2rdf4lod-source-me-for-locv.sh
source /home/locv/prizms/locv/data/source/csv2rdf4lod-source-me-on-locv.sh
source /home/locv/prizms/locv/data/source/csv2rdf4lod-source-me-credentials.sh
export CSV2RDF4LOD_CONVERT_DATA_ROOT="/home/locv/prizms/locv/data/source"
export CSV2RDF4LOD_PUBLISH_VARWWW_DUMP_FILES="true"
export CSV2RDF4LOD_PUBLISH_VARWWW_ROOT="/var/www"
export PATH=$PATH`/home/locv/opt/prizms/bin/install/paths.sh`
export CLASSPATH=$CLASSPATH`/home/locv/opt/prizms/bin/install/classpaths.sh`
export CSV2RDF4LOD_HOME="/home/locv/opt/prizms/repos/csv2rdf4lod-automation"
export DATAFAQS_HOME="/home/locv/opt/prizms/repos/DataFAQs"
export CSV2RDF4LOD_PUBLISH_VIRTUOSO=''
export CSV2RDF4LOD_PUBLISH_SUBSET_SAMPLES=''
export JENAROOT=/home/locv/opt/apache-jena-2.10.0
