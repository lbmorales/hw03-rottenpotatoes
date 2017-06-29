module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ? 'odd' : 'even'
  end

  # Returns class hilitie to view
  def class_for_order_column(column, order_column)
    column == order_column ? 'hilite' : ''
  end

  # Reuturn which checkbox is checked by user to ratings form
  def checked_by_user(rating, checked_ratings)
    return true if checked_ratings.include?(rating)
    return false
  end
end
