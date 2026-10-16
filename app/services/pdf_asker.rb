class PdfAsker
    def ask_question(pdf, question)
        text = PdfExtractor.new.extract_text(pdf)
        return "This document contains no extractable text." if text.strip.empty?
        prompt = "Based on #{text}, #{question}"

        AmaResponder.new(prompt).call
    end

end