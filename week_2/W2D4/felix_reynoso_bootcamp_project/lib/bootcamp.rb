class Bootcamp

    attr_reader :name, :slogan, :teachers, :students

    def initialize(name, slogan, student_capacity)
        @name = name
        @slogan = slogan
        @student_capacity = student_capacity
        @teachers = []
        @students = []
        @grades = Hash.new { |hash, k| hash[k] = [] }
    end


    def hire(teacher)
        @teachers.push(teacher)
    end


    def enroll(student)
        if @students.length < @student_capacity
            @students << student
            return true
        else
            return false
        end
    end


    def enrolled?(student)
        @students.include?(student)
    end


    def student_to_teacher_ratio
        ratio = @students.length / @teachers.length.to_f
        return ratio.floor()
    end


    def add_grade(student, grade)
        if enrolled?(student)
            @grades[student] << grade
            return true
        else
            return false
        end
    end


    def num_grades(student)
        return @grades[student].length
    end


    def average_grade(student)
        if !enrolled?(student)
            return nil
        elsif !@grades.has_key?(student)
            return nil
        else
        (@grades[student].inject {|sum, el| sum += el} / @grades[student].length.to_f).floor()
        end
    end

end
