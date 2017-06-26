class TodoItem
    attr_reader :name

    def initialize(name)
        @name = name
        @complete = false
    end

    def complete?
        @complete
    end

    # convention to mark any method that changes a reciever with a !
    def mark_complete!
        @complete = true
    end

    def mark_incomplete!
        @complete = false
    end

    def to_s
        (complete?)? "[C] #{name}" : "[I] #{name}"
    end

end