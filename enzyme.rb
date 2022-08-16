class CraqValidator

    attr_reader :errors

    ALREADY_COMPLETE = 'was answered even though a previous response indicated that the questions were complete'

    def initialize(questions, answers)
        @questions = []
        @errors = {}
        @valid = true
        answers ||= {}

        validate(questions, answers)
    end

    def valid?
        @valid
    end

    private

    def validate(questions, answers)
        questions.each_with_index do |q, i| 
            @questions << Question.new(q, answers[:"q#{i}"])

            if @completed
                if @questions[i].answered?
                    @errors[:"q#{i}"] = ALREADY_COMPLETE
                    @valid = false
                end
                next
            end

            if !@questions[i].is_valid_answer?
                @valid = false
                @errors[:"q#{i}"] = @questions[i].error
            else
                @completed = true if @questions[i].complete_if_selected?
            end
        end
    end
end

class Question

    attr_reader :error

    NOT_ANSWERED = 'was not answered'
    INVALID_ANSWER = 'has an answer that is not on the list of valid answers'

    def initialize(question, answer)
        @question = question[:text]
        @opts = question[:options]
        @answer = answer
        @error = nil
    end

    def is_valid_answer?
        if !answered?
            @error = NOT_ANSWERED
            return false
        elsif !@answer.between?(0, @opts.length-1)
            @error = INVALID_ANSWER
            return false
        end
        
        true
    end

    def answered?
        !@answer.nil?
    end

    def complete_if_selected?
        !!@opts[@answer][:complete_if_selected]
    end
end
