require 'active_support/inflector'
require 'questions_database'

class ModelBase

    def self.table
        self.to_s.tableize
    end

    def self.find_by_id(id)
        data = DatabaseQuestions.get_first_row(<<-SQL, id: id)
        SELECT
          *
        FROM
          #{table}
        WHERE
          id = :id
        SQL
        
        data.nil? ? nil : self.new(data)
    end

    def self.all
    end
end