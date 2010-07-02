class ZboziExportController < Spree::BaseController
  def index
    
    respond_to do |format|
      format.xml { render :layout => false, :xml => _build_zbozi_xml }
    end
  end
  
  private
  def _build_zbozi_xml
    returning '' do |output|
      xml = Builder::XmlMarkup.new(:target => output, :indent => 2) 
      xml.instruct!  :xml, :version => "1.0", :encoding => "UTF-8"
      xml.urlset( :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" )
    end
  end
end