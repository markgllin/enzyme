class CraqValidator

    attr_reader :errors

    def initialize(questions, answers)
        @questions = []
        @errors = {}
        @valid = true
        answers ||= {}

        questions.each_with_index do |q, i| 
            @questions << Question.new(q, i, answers[:"q#{i}"])

            if !@questions[i].is_valid_answer?
                puts @questions[i].inspect
                @valid = false
                @errors[:"q#{i}"] = @questions[i].error
            end
        end
    end

    def valid?
        @valid
    end

end

class Question

    attr_reader :error

    def initialize(question, number, answer)
        @question_number = number
        @question = question[:text]
        @opts = question[:options]
        @answer = answer
        @error = nil
    end

    def is_valid_answer?
        if @answer.nil?
            @error = 'was not answered'
            return false
        elsif !@answer.between?(0, @opts.length-1)
            @error = 'has an answer that is not on the list of valid answers'
            return false
        end
        
        true
    end

    def error
        @error
    end
end
