require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require_relative 'question_like'
require_relative 'reply'

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