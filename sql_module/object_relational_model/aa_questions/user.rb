require_relative 'questions_database'
require_relative 'question'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'reply'

class User
    attr_accessor :id, :fname, :lname

    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users;")
        data.map { |datum| User.new(datum) }
    end

    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
          users
        WHERE
            id = ?
        SQL
        User.new(data.first)
    end

    def self.find_by_name(fname, lname)
        data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        SELECT
          *
        FROM 
          users
        WHERE
          fname LIKE ? AND lname LIKE ?
        SQL
        return nil if data.empty?
        User.new(data.first)
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def authored_questions
        Question.find_by_author_id(self.id)
    end

    def authored_replies
        Reply.find_by_user_id(self.id)
    end

    def followed_questions
        Question_follow.followers_for_user_id(self.id)
    end

    def liked_questions
        Question_like.liked_questions_for_user_id(self.id)
    end

    def average_karma
        data = QuestionsDatabase.instance.execute(<<-SQL, self.id)
        SELECT
          COUNT(question_likes.user_id) /
            CAST(COUNT(DISTINCT(questions.id)) AS FLOAT) 
              AS avg_karma
        FROM
          questions
        LEFT JOIN question_likes
          ON questions.id = question_likes.question_id
        WHERE
          questions.author_id = ?
        SQL
        return nil if data.empty?
        data.first['avg_karma']
    end

    def save
      return self.update if self.id
      QuestionsDatabase.instance.execute(<<-SQL, self.fname, self.lname)    
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?)
      SQL
      self.id = QuestionsDatabase.instance.last_insert_row_id
      return self
    end

    def update 
      raise "#{self} not in Database." unless self.id
      QuestionsDatabase.instance.execute(<<-SQL, self.fname, self.lname, self.id)
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
         id = ?
      SQL
      return self
    end
end