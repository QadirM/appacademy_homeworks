require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    @id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end

  def self.find_by_title(title)

    play = PlayDBConnection.instance.execute(<<-SQL, title)
      SELECT
        *
      FROM
        plays
      WHERE
        plays.title = ?
    SQL

    return nil unless play.length > 0

    Play.new(play.first)
  end

  def self.find_by_playwright(name) #(returns all plays written by playwright)

    plays = PlayDBConnection.instance.execute(<<-SQL, name)
      SELECT
        title
      FROM
        plays
      JOIN
        playwrights ON playwrights.id = plays.playwright_id
      WHERE
        plays.playwright_id = (
          SELECT
            id
          FROM
            playwrights
          WHERE
            playwrights.name = ?
        )
    SQL

    plays.map{ |play| Play.new(play)}
  end

end

# class Playwright
#   attr_accessor :name, :birth_year
#
#   def self.all
#     data = PlayDBConnection.instance.execute(SELECT * From playwrights)
#     data.map { |datam| Playwright.new(datam) }
#   end
#
#   def initialize(options)
#     @id = options["id"]
#     @name = options["name"]
#     @birth_year = options["birth_year"]
#   end
#
#
#
# end

# Playwright::all
# Playwright::find_by_name(name)
# Playwright#new (this is the initialize method)
# Playwright#create
# Playwright#update
# Playwright#get_plays (returns all plays written by playwright)
