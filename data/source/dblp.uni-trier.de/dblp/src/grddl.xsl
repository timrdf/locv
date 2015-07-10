<!-- 
#3> <> prov:specializationOf <https://github.com/timrdf/locv/tree/master/data/source/dblp.uni-trier.de/dblp/version/src/grddl.xsl>;
#3>    prov:wasDerivedFrom <https://github.com/timrdf/csv2rdf4lod-automation/wiki/Alternative-XML-to-RDF-converters#xsl-crib-sheet>;
#3>    rdfs:seeAlso        <https://github.com/timrdf/locv/wiki/DBLP>;
#3> .
-->
<xsl:transform version="2.0" 
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="">
<xsl:output method="text"/>

<xsl:variable name="prefixes">
<xsl:text><![CDATA[@prefix rdf:     <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix dblp:    <http://dblp.uni-trier.de/rdf/schema-2015-01-26#> .
@prefix owl:     <http://www.w3.org/2002/07/owl#> .
@prefix dcterms: <http://purl.org/dc/terms/> .
@prefix foaf:    <http://xmlns.com/foaf/0.1> .
@prefix bibtex:  <http://data.bibbase.org/ontology/#> .
@prefix schema:  <http://schema.org/> .
]]></xsl:text>
</xsl:variable>

<xsl:template match="/">
   <xsl:value-of select="$prefixes"/>
   <xsl:apply-templates select="dblp/article"/>
   <!--xsl:apply-templates select="dblp/inproceedings"/>
   <xsl:apply-templates select="dblp/www"/-->
   <xsl:for-each-group select="dblp/*" group-by="local-name(.)">
      <xsl:message select="concat(count(current-group()),' ',current-grouping-key(),'s')"/>
   </xsl:for-each-group>
   <!--
      article
      proceedings
      inproceedings
      incollection
      book
      phdthesis
      mastersthesis
      www
   -->
</xsl:template>

<xsl:template match="dblp/article">
   <!--
       <article mdate="2011-01-11" key="journals/acta/Saxena96">
          <author>Sanjeev Saxena</author>
          <title>Parallel Integer Sorting and Simulation Amongst CRCW Models.</title>
          <pages>607-619</pages>
          <year>1996</year>
          <volume>33</volume>
          <journal>Acta Inf.</journal>
          <number>7</number>
          <url>db/journals/acta/acta33.html#Saxena96</url>
          <ee>http://dx.doi.org/10.1007/BF03036466</ee>
       </article>

       <author>Nathan Goodman</author>
       <author>Oded Shmueli</author>
       => dblp:authoredBy <http://dblp.uni-trier.de/pers/g/Goodman:Nathan>, 
                          <http://dblp.uni-trier.de/pers/s/Shmueli:Oded> ; -->

   <xsl:value-of select="concat(
      $LT,'http://dblp.uni-trier.de/rec/',@key,$GT,$NL,
      '    a dblp:Publication;',$NL,
      '    dblp:publicationType dblp:Article;',$NL,
      '    dblp:bibtexType    bibtex:Article;',$NL,
      '    dblp:title    ',$DQ,$DQ,$DQ,replace(replace(title,'\\','\\\\'),$DQ,concat('\\',$DQ)),$DQ,$DQ,$DQ,';',$NL)"/>
   <xsl:for-each select="author">
      <xsl:value-of select="concat(
         '    schema:author ',$DQ,replace(.,$DQ,concat('\\',$DQ)),$DQ,';',$NL)"/>
         <!--'   dblp:authoredBy ',$LT,'http://dblp.uni-trier.de/pers/TODO-LAST-INITIAL/LAST-NAME:FIRST-NAME',$GT,';',$NL)"/-->
   </xsl:for-each>
   <xsl:value-of select="concat(
      '    dblp:publicationLastModifiedDate   ',$DQ, @mdate,  $DQ,';',$NL,
      '    dblp:publishedInJournal            ',$DQ, journal, $DQ,';',$NL,
      '    dblp:yearOfPublication             ',$DQ, year,    $DQ,';',$NL,
      '    dblp:publishedInJournalVolume      ',$DQ, volume,  $DQ,';',$NL,
      if (string-length(number)) then concat('    dblp:publishedInJournalVolumeIssue ',$DQ, number,  $DQ,';',$NL) else '',
      '    dblp:pageNumbers                   ',$DQ, pages,   $DQ,';',$NL)"/>
   <xsl:for-each select="ee">
      <xsl:choose>
         <xsl:when test="starts-with(.,'db/')">
            <!-- 'db/journals/dr/Bertino00c.html' => 'http://dblp.uni-trier.de/db/journals/dr/Bertino00c.html' -->
            <xsl:value-of select="concat(
               '    dblp:primaryElectronicEdition ',  $LT, 'http://dblp.uni-trier.de/',., $GT,';',$NL)"/>
         </xsl:when>
         <xsl:when test="not(contains(.,$LT)) and not(ends-with(.,'timedchall.pdf')) and not(ends-with(.,'colConc82.pdf'))">
            <!-- <ee>http://dx.doi.org/10.1002/1521-3870(200108)47:3&lt;409::AID-MALQ409&gt;3.0.CO;2-L</ee>
                    <http://www.acm.org/sigmod/record/issues/0109/e2-chairmsg.pdf">
                    <http://dx.doi.org/10.1137/040604947\end{DOI> 
                    <http://www.cs.auc.dk/\~luca/BEATCS/timedchall.pdf>
                    <http://www.cs.auc.dk/\~luca/BEATCS/colConc82.pdf> -->
            <xsl:value-of select="concat(
               '    dblp:primaryElectronicEdition ',  $LT, replace(replace(.,concat($DQ,'$'),''),'\\end\{DOI',''),       $GT,';',$NL)"/>
         </xsl:when>
         <xsl:otherwise>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:for-each>
   <xsl:value-of select="concat(
      '    owl:sameAs                    ',$LT,'http://dblp.org/rec/',@key,$GT,';',$NL,
      '    dcterms:license ',$LT,'http://www.opendatacommons.org/licenses/by/',$GT,' .',$NL)"/>
</xsl:template>

<xsl:template match="@*|node()">
  <xsl:copy>
      <xsl:copy-of select="@*"/>   
      <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:variable name="NL" select="'&#xa;'"/>
<xsl:variable name="DQ" select="'&#x22;'"/>
<xsl:variable name="LT">&lt;</xsl:variable>
<xsl:variable name="GT">&gt;</xsl:variable>

</xsl:transform>
