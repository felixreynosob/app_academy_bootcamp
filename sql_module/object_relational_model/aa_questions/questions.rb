require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
    include Singleton 

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end

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
end

class Question
    attr_accessor :id, :title, :body, :author_id

    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
          questions
        WHERE
          id = ?
        SQL
        return nil if data.empty?
        Question.new(data.first)
    end

    def self.find_by_author_id(author_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT
          *
        FROM 
          questions
        WHERE
          author_id = ?
        SQL
        data.map { |datum| Question.new(datum) }
    end

    def self.most_followed(n)
        Question_follow.most_followed_questions(n)
    end

    def self.most_liked(n)
        Question_like.most_liked_questions(n)
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def author
        User.find_by_id(self.author_id)
    end

    def replies
        Reply.find_by_question_id(self.id)
    end

    def followers
        Question_follow.find_by_question.id(self.id)
    end

    def likers
        Question_like.likers_for_question_id(self.id)
    end

    def num_likes
        Question_like.num_likes_for_question_id(self.id)
    end
end

class Question_follow
    attr_accessor :id, :question_id, :follower_id

    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
          question_follows
        WHERE
            id = ?
        SQL
        Question_follow.new(data.first)
    end

    def self.followers_for_question_id(question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
          users.id, users.fname, users.lname
        FROM
          users
        INNER JOIN question_follows
          ON users.id = question_follows.follower_id    
        WHERE
          question_follows.question_id = ?
        SQL
        return nil if data.empty?
        data.map { |datum| User.new(datum) }
    end

    def self.followers_for_user_id(user_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
            questions.id, questions.title, questions.body, questions.author_id
        FROM
          questions
        INNER JOIN question_follows
          ON questions.id = question_follows.question_id    
        WHERE
          question_follows.follower_id = ?
        SQL
        return nil if data.empty?
        data.map { |datum| Question.new(datum) }
    end

    def self.most_followed_questions(n)
        data = QuestionsDatabase.instance.execute(<<-SQL, n)
        SELECT
          questions.id, questions.title, questions.body, questions.author_id
        FROM
          question_follows
        INNER JOIN questions
          ON questions.id = question_follows.question_id 
        GROUP BY questions.title
        ORDER BY COUNT(questions.id) DESC 
        LIMIT ?
        SQL
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @follower_id = options['follower_id']
    end
end

class Reply
    attr_accessor :id, :body, :question_id, :parent_id, :author_id

    def self.all 
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies;")
        data.map { |datum| Reply.new(datum) }
    end

    def self.find_by_id(id)
        data = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT
          *
        FROM
          replies
        WHERE
          id = ?
        SQL
        Reply.new(data.first)
    end

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

    def self.likers_for_question_id(question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
          users.id, users.fname, users.lname
        FROM
          users
        INNER JOIN question_likes
          ON users.id = question_likes.user_id
        WHERE
          question_likes.question_id = ?
        ORDER BY users.fname, users.lname
        SQL
        return nil if data.empty?
        data.map { |datum| User.new(datum) }
    end

    def self.num_likes_for_question_id(question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
          COUNT(question_likes.user_id) AS number_of_likes
        FROM
          question_likes
        WHERE
          question_likes.question_id = ?
        SQL
        data.first["number_of_likes"]
    end

    def self.liked_questions_for_user_id(user_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT 
          questions.id, questions.title, questions.body, questions.author_id
        FROM
          questions
        INNER JOIN question_likes
          ON questions.id = question_likes.question_id
        WHERE
          question_likes.user_id = ?
        SQL
        return nil if data.empty?
        data.map { |datum| Question.new(datum) }
    end

    def self.most_liked_questions(nbr)
        data = QuestionsDatabase.instance.execute(<<-SQL, nbr)
        SELECT 
          questions.id, questions.title, questions.body, questions.author_id
        FROM
          questions 
        INNER JOIN question_likes
          ON questions.id = question_likes.question_id 
        GROUP BY questions.id
        ORDER BY COUNT(question_likes.user_id) DESC, questions.id ASC
        LIMIT ?
        SQL
        return nil if data.empty?
        data.map { |datum| Question.new(datum) }
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
end

