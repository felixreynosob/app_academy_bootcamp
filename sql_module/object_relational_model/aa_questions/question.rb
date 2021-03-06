require_relative 'questions_database'
require_relative 'user'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'reply'

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

    def self.all
      data = QuestionsDatabase.instance.execute("SELECT * FROM questions;")
      data.map { |datum| Question.new(datum) }
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

    def save
      return self.update if self.id
      QuestionsDatabase.instance.execute(<<-SQL, self.title, self.body, self.author_id)    
      INSERT INTO
        questions (title, body, author_id)
      VALUES
        (?, ?, ?)
      SQL
      self.id = QuestionsDatabase.instance.last_insert_row_id
      return self
    end

    def update 
      raise "#{self} not in Database." unless self.id
      QuestionsDatabase.instance.execute(<<-SQL, self.title, self.body, self.author_id=self.author_id, self.id)
      UPDATE
        questions
      SET
        title = ?, body = ?, author_id = ?
      WHERE
         id = ?
      SQL
      return self
    end
end