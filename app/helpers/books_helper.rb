module BooksHelper
    require 'net/http'
    require 'pp'
    require "uri"
    # for barcode http://toreto.re/barby/howto.html
    # require 'barby'
    # require 'barby/outputter/png_outputter'
    # require 'barby/barcode/code_128'
    # require 'barby/outputter/ascii_outputter'
    
    def get_barcode(str)
        Barcodes.render('Codabar', 'poc.pdf', {:data => '12345'})
        ap(str)
    end
end
