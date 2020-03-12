require 'singleton'

class QuestionsDatabase < SQlite3::Database
    include Singleton 

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end

class User
    attr_accessor :id, :fname, :lname

    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, self.id)
        SELECT
          *
        FROM
          users
        WHERE
            id = ?
        SQL
        User.new(data.first)
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end
end

class Question
    attr_accessor :id, :title, :body, :author_id

    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, self.id)
        SELECT
          *
        FROM
          questions
        WHERE
            id = ?
        SQL
        Question.new(data.first)
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end
end

class Question_follow
    attr_accessor :id, :question_id, :follower_id

    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, self.id)
        SELECT
          *
        FROM
          question_follows
        WHERE
            id = ?
        SQL
        Question_follow.new(data.first)
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @follower_id = options['follower_id']
    end
end

class Reply
    attr_accessor :id, :body, :question_id, :parent_id, :author_id

    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, self.id)
        SELECT
          *
        FROM
          replies
        WHERE
            id = ?
        SQL
        Reply.new(data.first)
    end

    def initialize(options)
        @id = options['id']
        @body = options['body']
        @question_id = options['question_id']
        @parent_id = options['parent_id']
        @author_id = options['author_id']
    end
end

class Question_like
    attr_accessor :id, :question_id, :user_id

    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, self.id)
        SELECT
          *
        FROM
          question_likes
        WHERE
            id = ?
        SQL
        Question_like.new(data.first)
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
end

