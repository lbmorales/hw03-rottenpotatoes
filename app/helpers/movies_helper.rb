module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def class_for_order_column(column, order_column)
    column == order_column ? 'hilite' : ''
  end
end
