require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    
    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end


    def valid_title?(title)
        @salaries.has_key?(title)
    end


    def >(other_startup)
        self.funding > other_startup.funding
    end


    def hire(employee_name, title)
        if @salaries.has_key?(title)
            @employees << Employee.new(employee_name, title)
        else
            raise_error
        end
    end


    def size
        @employees.length
    end


    def pay_employee(employee_instance)
        if @funding > salaries[employee_instance.title]
            employee_instance.pay(salaries[employee_instance.title])
            @funding -= salaries[employee_instance.title]
        else
            raise_error
        end
    end


    def payday
        @employees.each { |employee_to_pay| pay_employee(employee_to_pay) }
    end


    def average_salary
        total = @employees.inject(0) { |sum, employee_obj| sum + @salaries[employee_obj.title] } 
        total / @employees.length.to_f
    end


    def close 
        @employees = []
        @funding = 0
    end


    def acquire(other_startup)
        @funding += other_startup.funding
        other_startup.salaries.each do |k, v|
            if @salaries.has_key?(k) == false
                @salaries[k] = v
            else
                next
            end
        end 
        other_startup.employees.each { |employee| @employees << employee }
        other_startup.close
    end
end
