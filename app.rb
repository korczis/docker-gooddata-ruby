#! /usr/bin/env ruby

require 'gooddata'
require 'mem_info'

puts GoodData::VERSION

# Nice format bytes
def print_nice(bytes)
  i = 0
  units = ['B', 'kB', 'MB', 'GB']

  while bytes > 1024 && i < units.length - 1
    bytes /= 1024.0
    i += 1
  end

  {val: bytes, unit: units[i]}
end

# Print memory usage
def print_usage
  m = MemInfo.new
  size = m.memused.to_i
  usage = print_nice(size)
  puts "#{size} B, #{usage[:val]} #{usage[:unit]}"
end

# Start memory reporting thread
def start_mem_thread
  $t = Thread.new do
    loop do
      print_usage
      sleep 10
    end
  end
end

# Kill memory reporting thread
def kill_mem_thread
  $t.kill
end

# Start reporting
start_mem_thread

res = []
while (res.length < 1e6) do
  # puts res.length
  for i in 1..10_000
    res << "Hello! " * 1000
  end
  sleep 1
end

# Do something
kill_mem_thread