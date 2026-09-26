class ComplexityScorer
    def initialize(prompt, document: nil)
        @prompt = prompt
        @document = document
        
    end

    def call
        taxonomy = YAML.load_file(Rails.root.join("config", "bloom_taxonomy.yml"))
        skills = taxonomy["skills"]
        scores = []

        prompt = @prompt.downcase

        skills.each do |skill, data|
            vocabulary = data["verbs"] + data["phrases"]

            match = vocabulary.any? do |term|
                prompt.match?(/\b#{Regexp.escape(term)}\b/)
            end

            scores << data["score"] if match
        end

        scores.max
    end

end