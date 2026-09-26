class PdfAsker
    def ask_question(pdf, question)
        text = PdfExtractor.new.extract_text(pdf)
        prompt = "Based on #{text}, #{question}"
    end

end