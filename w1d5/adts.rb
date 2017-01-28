class Stack
  def initialize
    @stack = []
  end

  def add(el)
    stack << el
  end

  def remove
    stack.pop
  end

  def show
    stack
  end

  private
    attr_reader :stack
end

class Queue
  def initialize
    @queue = []
  end

  def enqueue(el)
    queue << el
  end

  def dequeue
    queue.shift
  end

  def show
    queue
  end

  private
    attr_reader :queue
end

class Map
  def initialize
    @map = []
  end

  def assign(key, value)
    if lookup(key).nil?
      map << [key, value]
    else
      remove(key)
      map << [key, value]
    end
  end

  def lookup(key)
    map.each { |k, v| return v if k == key }
    nil
  end

  def remove(key)
    map.reject! { |k, v| k == key }
  end

  def show
    map
  end

  private
    attr_reader :map
end
