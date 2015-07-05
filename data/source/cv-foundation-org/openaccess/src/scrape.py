import argparse
import pprint
from BeautifulSoup import BeautifulSoup

def lift(_html, sdv):

   sdv.source    = sdv.base + '/source/' + sdv.s;
   sdv.abstract  = sdv.base + '/source/' + sdv.s + '/dataset/' + sdv.d;
   sdv.versioned = sdv.base + '/source/' + sdv.s + '/dataset/' + sdv.d + '/version/' + sdv.v;

   with open(_html, 'r') as myfile:
      contents = myfile.read()
      soup = BeautifulSoup(contents) #print soup.prettify() 
      title = soup.findAll('meta', {'name' : 'citation_title'})[0]['content']
      print title
      # 6 Seconds of Sound and Vision: Creativity in Micro-Videos
      for meta in soup.findAll('meta', {'name' : 'citation_author'}):
         print meta['content']
         # Redi, Miriam
         # O'Hare, Neil
         # Schifanella, Rossano
         # Trevisiol, Michele
         # Jaimes, Alejandro

      print soup.findAll('meta', {'name':'citation_publication_date'})[0]['content']
      # 2014
      print soup.findAll('meta', {'name':'citation_conference_title'})[0]['content']
      # Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition
      print soup.findAll('meta', {'name':'citation_firstpage'})[0]['content']
      # 4272
      print soup.findAll('meta', {'name':'citation_lastpage'})[0]['content']
      # 4279
      print soup.findAll('meta', {'name':'citation_pdf_url'})[0]['content']
      # http://www.cv-foundation.org/openaccess/content_cvpr_2014/papers/Redi_6_Seconds_of_2014_CVPR_paper.pdf
      print soup.findAll('div',  {'id':'abstract'})[0].contents
      # [u'The notion of creativity, as opposed to related\nconcepts such as beauty or interestingness...
      for snippet in soup.findAll('div',  {'class':'bibref'})[0].contents:
         if not(hasattr(snippet, 'contents')): # Some <br/> among NavigableStrings...
            print snippet.string.strip(' \t\n\r'),
            # @InProceedings{Redi_2014_CVPR, author = {Redi, Miriam and O'Hare, Neil and Schifanella, Rossano
            # and Trevisiol, Michele and Jaimes, Alejandro}, title = {6 Seconds of Sound and Vision: Creativity in
            # Micro-Videos}, journal = {The IEEE Conference on Computer Vision and Pattern
            # Recognition (CVPR)}, month = {June}, year = {2014} }

if __name__ == '__main__':

   HELP='https://github.com/timrdf/csv2rdf4lod-automation/wiki/SDV-organization'
   parser = argparse.ArgumentParser(description='Load Database from JSON');
   parser.add_argument('--cr-base-uri',   dest='base',     help=HELP, required=True);
   parser.add_argument('--cr-source-id',  dest='s',        help=HELP, required=True);
   parser.add_argument('--cr-dataset-id', dest='d',        help=HELP, required=True);
   parser.add_argument('--cr-version-id', dest='v',        help=HELP, required=True);
   parser.add_argument('html', nargs='+',                  help='Input HTML file');

   args = parser.parse_args();

   for input in args.html:
      lift(input, args)
