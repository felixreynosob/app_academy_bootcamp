require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require_relative 'question_follow'
require_relative 'reply'


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