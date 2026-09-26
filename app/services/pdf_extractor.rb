class PdfExtractor
  def extract_text(pdf)
    reader = PDF::Reader.new(pdf)
    text = ""
    reader.pages.each do |page|
        text << page.text
        end
    text
  end
end