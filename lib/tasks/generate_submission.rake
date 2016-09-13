namespace :omg do
  data = ENV['data']

  desc "Generate submission table and output in stdout"
  task :submission do |t|
    puts OMGSeq::Sample.new(data).create_submission
  end
end
