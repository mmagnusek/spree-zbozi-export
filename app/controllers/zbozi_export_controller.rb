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
      xml.shop do
        Product.active.each do |product|
          xml.shopitem do
            xml.productname product.name
            xml.description product.description
            xml.url product_url(product)
            xml.itemtyp 'new'
            product.variants.each do |variant|
              xml.variant do
                xml.productnameext variant.options_text
                xml.price variant.price
              end
            end
          end
        end
      end
    end
  end
end