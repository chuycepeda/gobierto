class ActivityDecorator < BaseDecorator
  def initialize(activity)
    @object = activity
  end

  def subject_name
    fetch_relation(:subject)
  end

  def author_name
    fetch_relation(:author)
  end

  def recipient_name
    fetch_relation(:recipient)
  end

  private

  def fetch_relation(relation_name)
    if object.send(relation_name).present?
      object.send(relation_name).try(:name)
    else
      if object.send("#{relation_name}_type").present?
        "(deleted) #{object.send("#{relation_name}_type")} - #{object.send("#{relation_name}_id")}"
      else
        "-"
      end
    end
  end
end
