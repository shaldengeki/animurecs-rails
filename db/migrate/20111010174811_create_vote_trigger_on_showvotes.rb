class CreateVoteTriggerOnShowvotes < ActiveRecord::Migration
  def self.up
	execute <<-SQL
		CREATE TRIGGER add_votes_on_showvotes AFTER INSERT ON `showvotes`
		FOR EACH ROW BEGIN
			UPDATE `shows` SET `upvotes` = `upvotes` + 1 WHERE (`id` = NEW.show_id && 1 = NEW.vote) LIMIT 1;
			UPDATE `shows` SET `downvotes` = `downvotes` + 1 WHERE (`id` = NEW.show_id && -1 = NEW.vote) LIMIT 1;
		END;
	SQL

	execute <<-SQL
		CREATE TRIGGER update_votes_on_showvotes AFTER UPDATE ON `showvotes`
		FOR EACH ROW BEGIN
			UPDATE `shows` SET `upvotes` = `upvotes` + (NEW.vote - OLD.vote) / 2 WHERE (`id` = OLD.show_id) LIMIT 1;
			UPDATE `shows` SET `downvotes` = `downvotes` + (OLD.vote - NEW.vote) / 2 WHERE (`id` = OLD.show_id) LIMIT 1;
		END;
	SQL

	execute <<-SQL
		CREATE TRIGGER delete_votes_on_showvotes AFTER DELETE ON `showvotes`
		FOR EACH ROW BEGIN
			UPDATE `shows` SET `upvotes` = `upvotes` - 1 WHERE (`id` = OLD.show_id && 1 = OLD.vote) LIMIT 1;
			UPDATE `shows` SET `downvotes` = `downvotes` - 1 WHERE (`id` = OLD.show_id && -1 = OLD.vote) LIMIT 1;
		END;
	SQL
  end

  def self.down
	execute <<-SQL
		DROP TRIGGER add_votes_on_showvotes
	SQL
	execute <<-SQL
		DROP TRIGGER update_votes_on_showvotes
	SQL
	execute <<-SQL
		DROP TRIGGER delete_votes_on_showvotes
	SQL
  end
end
