# require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'model_base'

class Reply < ModelBase
    attr_accessor :id, :body, :question_id, :parent_id, :author_id

    def self.all 
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies;")
        data.map { |datum| Reply.new(datum) }
    end

    # def self.find_by_id(id)
    #     data = QuestionsDatabase.instance.execute(<<-SQL, id)
    #     SELECT
    #       *
    #     FROM
    #       replies
    #     WHERE
    #       id = ?
    #     SQL
    #     Reply.new(data.first)
    # end

    def self.find_by_question_id(question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
          *
        FROM  
          replies
        WHERE
          question_id = ?
        SQL
        data.map { |datum| Question.new(datum) }
    end

    def self.find_by_user_id(user_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
          *
        FROM 
          replies
        WHERE
          author_id = ?
        SQL
        data.map { |datum| Reply.new(datum) }
    end

    def initialize(options)
        @id = options['id']
        @body = options['body']
        @question_id = options['question_id']
        @parent_id = options['parent_id']
        @author_id = options['author_id']
    end

    def replies
        Reply.find_by_question_id(self.id)
    end

    def author
        User.find_by_id(self.author_id)
    end

    def question
        Question.find_by_id(self.question_id)
    end

    def parent_reply
        Reply.find_by_id(self.parent_id)
    end

    def child_replies
        data = QuestionsDatabase.instance.execute(<<-SQL, self.id)
        SELECT
          *
        FROM 
          replies
        WHERE
          replies.parent_id = ? 
          AND replies.parent_id <> replies.id
        SQL
        return nil if data.empty?
        data.map { |datum| Reply.new(datum) }
    end

    def save
      return self.update if self.id
      QuestionsDatabase.instance.execute(<<-SQL, self.body, self.question_id, self.parent_id, self.author_id)    
      INSERT INTO
        replies (body, question_id, parent_id, author_id)
      VALUES
        (?, ?, ?, ?)
      SQL
      self.id = QuestionsDatabase.instance.last_insert_row_id
      return self
    end

    def update 
      raise "#{self} not in Database." unless self.id
      QuestionsDatabase.instance.execute(<<-SQL, self.body, self.question_id,self.parent_id,  self.author_id=self.author_id, self.id)
      UPDATE
        replies
      SET
        title = ?, question_id = ?, parent_id = ?,  author_id = ?
      WHERE
         id = ?
      SQL
      return self
    end
end